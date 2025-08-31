import os
import csv
from pathlib import Path
from lxml import etree
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate
import json
import logging

# Set up logging
logging.basicConfig(filename='parsing_log.txt', level=logging.ERROR, format='%(asctime)s - %(levelname)s - %(message)s')

# Set OpenAI API key
os.environ["OPENAI_API_KEY"] = "PLACEHOLDER"

# Define folders and output file
xml_folder = Path("./judgingapp/xml")
output_csv = Path("./judgingapp/src/main/resources/verdicts.csv")

# Define headers for verdicts.csv (English standardized)
verdict_headers = [
    "id", "Court", "Case Number", "Judge", "Prosecutor", "Defendant",
    "Criminal Offense", "Injury Types", "Verdict Type", "Applied Provisions",
    "Verdict Date", "Victim", "Penalty", "Event Location", "Event Date",
    "Protection Measure Violation", "Execution Means", "Procedure Costs",
    "Violence Nature", "Victim Relationship", "Defendant Status", "Defendant Age",
    "Victim Age", "Previous Incidents", "Alcohol or Drugs", "Children Present",
    "Use of Weapon", "Number of Victims", "Number of Defendants", "Aware of Illegality"
]

# Define namespace
ns = {"akn": "http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17"}

# Function to safely get attribute
def safe_get(element, attr):
    try:
        return element.get(attr, "") if element is not None else ""
    except Exception as e:
        logging.error(f"Error getting attribute {attr}: {e}")
        return ""

# Function to safely get text
def safe_text(element):
    try:
        return element.text.strip() if element is not None and element.text else ""
    except Exception as e:
        logging.error(f"Error getting text: {e}")
        return ""

# Function to extract metadata and text from XML
def extract_metadata_and_text(xml_path):
    try:
        tree = etree.parse(xml_path)
        root = tree.getroot()

        meta = {}
        meta['id'] = str(xml_path.stem)
        meta['Court'] = safe_text(root.find(".//akn:FRBRauthor", namespaces=ns))
        meta['Case Number'] = safe_text(root.find(".//akn:FRBRtitle", namespaces=ns))
        meta['Verdict Date'] = safe_get(root.find(".//akn:FRBRdate", namespaces=ns), "date")

        # Extract judges
        judges = []
        for person in root.findall(".//akn:TLCPerson", namespaces=ns):
            if safe_get(person, "eId") in [safe_get(p, "refersTo").lstrip("#") for p in root.findall(".//akn:party[@as='#judge']", namespaces=ns)]:
                judges.append(safe_get(person, "showAs"))
        meta['Judge'] = ", ".join(set(judges)) if judges else ""

        # Extract prosecutor
        prosecutors = []
        for person in root.findall(".//akn:TLCPerson", namespaces=ns):
            if safe_get(person, "eId") in [safe_get(p, "refersTo").lstrip("#") for p in root.findall(".//akn:party[@as='#prosecutor']", namespaces=ns)]:
                prosecutors.append(safe_get(person, "showAs"))
        if prosecutors:
            meta['Prosecutor'] = ", ".join(set(prosecutors))
        else:
            prosecutor_org = root.find(".//akn:organization[@refersTo='#odt']", namespaces=ns)
            meta['Prosecutor'] = safe_get(prosecutor_org, "showAs") or "Osnovno državno tužilaštvo"

        # Extract defendant
        defendants = []
        for person in root.findall(".//akn:TLCPerson", namespaces=ns):
            if safe_get(person, "eId") in [safe_get(p, "refersTo").lstrip("#") for p in root.findall(".//akn:party[@as='#defendant']", namespaces=ns)]:
                defendants.append(safe_get(person, "showAs"))
        meta['Defendant'] = ", ".join(set(defendants)) if defendants else ""
        meta['Number of Defendants'] = len(set(defendants)) if defendants else 1

        # Extract victim
        victims = []
        for person in root.findall(".//akn:TLCPerson", namespaces=ns):
            if safe_get(person, "eId") in [safe_get(p, "refersTo").lstrip("#") for p in root.findall(".//akn:party[@as='#victim']", namespaces=ns)]:
                victims.append(safe_get(person, "showAs"))
        meta['Victim'] = ", ".join(set(victims)) if victims else ""
        meta['Number of Victims'] = len(set(victims)) if victims else 0

        # Extract judgment body text
        judgment_body = root.find(".//akn:judgmentBody", namespaces=ns)
        full_text = etree.tostring(judgment_body, method="text", encoding="unicode").strip() if judgment_body is not None else ""

        return meta, full_text
    except Exception as e:
        logging.error(f"Error parsing {xml_path}: {e}")
        print(f"Error parsing {xml_path}: {e}")
        return {}, ""

# Function to build the prompt with standardized schema
def build_prompt():
    return ChatPromptTemplate.from_messages([
        ("system", """You are an expert in legal documents in Serbian language. Analyze the court verdict text and extract the following information in JSON format, using the Montenegrin Criminal Code (Article 220). Keep metadata like names, locations, dates in their original form. Translate and standardize facts of the case to English, using predefined categories where possible. If information is missing, return empty string ('') for strings, false for booleans, 0 for integers. Return only a valid JSON object according to the following schema:

        ```json
          "Criminal Offense": "string", // e.g., 'cl. 220 st. 1'
          "Injury Types": "string", // Standardized: 'light', 'severe', 'light,severe', or ''
          "Verdict Type": "string", // Enum: 'PRISON', 'SUSPENDED', 'ACQUITTED', 'DETENTION'
          "Applied Provisions": "string", // e.g., 'cl. 220 st. 1, cl. 42 st. 1 KZ, cl. 374 ZKP'
          "Penalty": "string", // In English, e.g., 'prison sentence of 6 months' or ''
          "Event Location": "string", // Original, e.g., 'Podgorica, ulica Mitra Bakića br. 154'
          "Event Date": "string", // e.g., '2023-01-24'
          "Protection Measure Violation": "boolean", // true or false
          "Execution Means": "string", // Standardized categories: 'hands', 'feet', 'weapon', 'tool', 'verbal', 'other'
          "Procedure Costs": "string", // In English, e.g., '90.50 € borne by the court' or original if specific
          "Violence Nature": "string", // Standardized: 'violence', 'threat', 'reckless behaviour', or ''
          "Victim Relationship": "string", // Standardized: 'spouse', 'parent', 'sibling', 'child', 'other', or ''
          "Defendant Status": "string", // In English, e.g., 'unemployed, unmarried, previously convicted'
          "Defendant Age": "string", // e.g., '45 years' or ''
          "Victim Age": "string", // e.g., '38 years' or ''
          "Previous Incidents": "string", // In English, e.g., 'convicted by verdict K.no. 850/05' (keep verdict numbers original)
          "Alcohol or Drugs": "boolean", // true or false
          "Children Present": "boolean", // true or false
          "Use of Weapon": "boolean", // true if Execution Means involves 'weapon' or 'tool', false otherwise
          "Number of Victims": "integer", // Number of victims mentioned
          "Number of Defendants": "integer", // Number of defendants mentioned
          "Aware of Illegality": "boolean" // true if defendant was aware of illegality, false otherwise
        ```"""),
        ("user", """From the following court verdict text, extract the requested information in JSON format according to the given schema:

        Verdict:
        {input}
        """)
    ])

def clean_response(text):
    text = text.strip()
    if text.startswith("```json"):
        text = text[len("```json"):].strip()
    if text.endswith("```"):
        text = text[:-len("```")].strip()
    return text

def process_case(xml_path, llm, prompt):
    meta, text = extract_metadata_and_text(xml_path)
    if not text or not meta:
        logging.warning(f"Skipped {xml_path.name} due to empty text or metadata.")
        return None

    chain = prompt | llm
    try:
        result = chain.invoke({"input": text})
        parsed = json.loads(clean_response(result.content))
    except json.JSONDecodeError as e:
        logging.error(f"Invalid JSON for {xml_path.name}: {e}")
        print(f"ERROR: Invalid JSON for {xml_path.name}")
        parsed = {}

    # General post-processing for abbreviations
    if parsed.get("Criminal Offense"):
        parsed["Criminal Offense"] = parsed["Criminal Offense"].replace("stav", "st.").replace("čl.", "cl.")
    if parsed.get("Applied Provisions"):
        parsed["Applied Provisions"] = parsed["Applied Provisions"].replace("stav", "st.").replace("čl.", "cl.")

    # Standardize Injury Types based on keywords
    if parsed.get("Injury Types"):
        injuries = parsed["Injury Types"].lower()
        injury_set = set()
        if any(word in injuries for word in ["light", "laka", "lake"]):
            injury_set.add("light")
        if any(word in injuries for word in ["severe", "teška", "teške"]):
            injury_set.add("severe")
        parsed["Injury Types"] = ",".join(sorted(injury_set)) if injury_set else ""

    # Standardize Victim Relationship based on keywords
    if parsed.get("Victim Relationship"):
        rel = parsed["Victim Relationship"].lower()
        if any(word in rel for word in ["spouse", "supruga", "suprug", "wife", "husband"]):
            parsed["Victim Relationship"] = "spouse"
        elif any(word in rel for word in ["parent", "majka", "otac", "mother", "father"]):
            parsed["Victim Relationship"] = "parent"
        elif any(word in rel for word in ["sibling", "sestra", "brat", "sister", "brother"]):
            parsed["Victim Relationship"] = "sibling"
        elif any(word in rel for word in ["child", "dete", "sin", "kći", "son", "daughter"]):
            parsed["Victim Relationship"] = "child"
        else:
            parsed["Victim Relationship"] = "other"

    # Standardize Violence Nature based on keywords
    if parsed.get("Violence Nature"):
        vio = parsed["Violence Nature"].lower()
        if any(word in vio for word in ["rough violence", "grubo nasilje"]):
            parsed["Violence Nature"] = "violence"
        elif any(word in vio for word in ["threat", "prijetnja"]):
            parsed["Violence Nature"] = "threat"
        elif any(word in vio for word in ["arrogant and reckless behavior", "drsko i bezobzirno ponašanje"]):
            parsed["Violence Nature"] = "reckless behaviour"
        else:
            parsed["Violence Nature"] = ""

    # Standardize Execution Means based on keywords
    if parsed.get("Execution Means"):
        means = parsed["Execution Means"].lower()
        if any(word in means for word in ["pesnica", "hand", "fist", "šaka"]):
            parsed["Execution Means"] = "hands"
        elif any(word in means for word in ["noga", "foot", "feet", "kick"]):
            parsed["Execution Means"] = "feet"
        elif any(word in means for word in ["oružje", "weapon", "gun", "knife", "pištolj", "nož", "axe", "sjekira"]):
            parsed["Execution Means"] = "weapon"
        elif any(word in means for word in ["alat", "tool", "kliješta", "pliers", "chair", "stolice", "hammer"]):
            parsed["Execution Means"] = "tool"
        elif any(word in means for word in ["verbal", "prijetnja", "threat", "poruka"]):
            parsed["Execution Means"] = "verbal"
        else:
            parsed["Execution Means"] = "other"

    # Set Use of Weapon based on Execution Means
    if parsed.get("Execution Means"):
        means = parsed["Execution Means"].lower()
        parsed["Use of Weapon"] = any(word in means for word in ["weapon", "tool"])

    # Standardize Defendant Status based on keywords
    if parsed.get("Defendant Status"):
        status = parsed["Defendant Status"].lower()
        status_parts = []
        if any(word in status for word in ["nezaposlen", "unemployed"]):
            status_parts.append("unemployed")
        if any(word in status for word in ["neoženjen", "unmarried", "neoženjena"]):
            status_parts.append("unmarried")
        if any(word in status for word in ["osuđivan", "previously convicted", "ranije osuđivan"]):
            status_parts.append("previously convicted")
        parsed["Defendant Status"] = ", ".join(status_parts) if status_parts else ""

    # Default Verdict Type if not in enum
    if parsed.get("Verdict Type") not in ["PRISON", "SUSPENDED", "ACQUITTED", "DETENTION"]:
        if "odbija se optužba" in text.lower():
            parsed["Verdict Type"] = "ACQUITTED"
        elif "uslovnu osudu" in text.lower():
            parsed["Verdict Type"] = "SUSPENDED"
        elif "kazna zatvora" in text.lower() and "neće izvršiti" not in text.lower():
            parsed["Verdict Type"] = "PRISON"
        else:
            parsed["Verdict Type"] = ""

    # Set Aware of Illegality (default to true unless text indicates otherwise)
    if parsed.get("Aware of Illegality") is None:
        parsed["Aware of Illegality"] = True
    else:
        # Check for explicit indications of unawareness in the text
        if any(phrase in text.lower() for phrase in ["nesvjestan", "nisu znali", "not aware", "unaware"]):
            parsed["Aware of Illegality"] = False

    # Combine metadata and facts
    verdict = {
        "id": meta.get("id", ""),
        "Court": meta.get("Court", ""),
        "Case Number": meta.get("Case Number", ""),
        "Judge": meta.get("Judge", ""),
        "Prosecutor": meta.get("Prosecutor", ""),
        "Defendant": meta.get("Defendant", ""),
        "Criminal Offense": parsed.get("Criminal Offense", ""),
        "Injury Types": parsed.get("Injury Types", ""),
        "Verdict Type": parsed.get("Verdict Type", ""),
        "Applied Provisions": parsed.get("Applied Provisions", ""),
        "Verdict Date": meta.get("Verdict Date", ""),
        "Victim": meta.get("Victim", ""),
        "Penalty": parsed.get("Penalty", ""),
        "Event Location": parsed.get("Event Location", ""),
        "Event Date": parsed.get("Event Date", ""),
        "Protection Measure Violation": str(parsed.get("Protection Measure Violation", False)).lower(),
        "Execution Means": parsed.get("Execution Means", ""),
        "Procedure Costs": parsed.get("Procedure Costs", ""),
        "Violence Nature": parsed.get("Violence Nature", ""),
        "Victim Relationship": parsed.get("Victim Relationship", ""),
        "Defendant Status": parsed.get("Defendant Status", ""),
        "Defendant Age": parsed.get("Defendant Age", ""),
        "Victim Age": parsed.get("Victim Age", ""),
        "Previous Incidents": parsed.get("Previous Incidents", ""),
        "Alcohol or Drugs": str(parsed.get("Alcohol or Drugs", False)).lower(),
        "Children Present": str(parsed.get("Children Present", False)).lower(),
        "Use of Weapon": str(parsed.get("Use of Weapon", False)).lower(),
        "Number of Victims": str(meta.get("Number of Victims", 0)),
        "Number of Defendants": str(meta.get("Number of Defendants", 1)),
        "Aware of Illegality": str(parsed.get("Aware of Illegality", True)).lower()
    }

    return verdict

# Main function to process all files
def run_pipeline():
    llm = ChatOpenAI(model="gpt-4o", temperature=0)
    prompt = build_prompt()

    # Create directory if not exists
    output_csv.parent.mkdir(parents=True, exist_ok=True)

    with open(output_csv, "w", encoding="utf-8", newline="") as csv_file:
        writer = csv.DictWriter(csv_file, fieldnames=verdict_headers, delimiter=";")
        writer.writeheader()

        for xml_file in xml_folder.glob("*.xml"):
            print(f"Processing: {xml_file.name}")
            verdict = process_case(xml_file, llm, prompt)
            if verdict:
                writer.writerow(verdict)
            else:
                print(f"Skipped {xml_file.name} due to error.")

if __name__ == "__main__":
    run_pipeline()