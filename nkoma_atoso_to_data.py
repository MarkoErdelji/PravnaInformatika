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
xml_folder = Path("./presude/xml")
output_csv = Path("./judgingapp/src/main/resources/verdicts.csv")

# Define headers for verdicts.csv (English standardized)
verdict_headers = [
    "id", "Court", "Case Number", "Judge", "Prosecutor", "Defendant",
    "Criminal Offense", "Injury Types", "Verdict Type", "Applied Provisions",
    "Verdict Date", "Victim", "Penalty", "Event Location", "Event Date",
    "Protection Measure Violation", "Execution Means", "Procedure Costs",
    "Violence Nature", "Victim Relationship", "Defendant Status", "Defendant Age",
    "Victim Age", "Previous Incidents", "Alcohol or Drugs", "Children Present",
    "Use of Weapon", "Number of Victims", "Number of Defendants"
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
            show_as = safe_get(person, "showAs").lower()
            if "sudija" in show_as or "sudi" in show_as:
                judges.append(safe_get(person, "showAs"))
        for role in root.findall(".//akn:TLCRole", namespaces=ns):
            if "sudija" in safe_get(role, "showAs").lower():
                judges.append(safe_get(role, "showAs"))
        meta['Judge'] = ", ".join(set(judges)) if judges else ""

        # Extract prosecutor
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
          "Execution Means": "string", // Standardized: 'hands', 'feet', 'weapon', 'tool', 'verbal', 'other'; e.g., 'tool:pliers'
          "Procedure Costs": "string", // In English, e.g., '90.50 € borne by the court' or original if specific
          "Violence Nature": "string", // Standardized: 'rough violence', 'threat', 'arrogant and reckless behavior', or ''
          "Victim Relationship": "string", // Standardized: 'spouse', 'parent', 'sibling', 'child', 'other', or ''
          "Defendant Status": "string", // In English, e.g., 'unemployed, unmarried, previously convicted'
          "Defendant Age": "string", // e.g., '45 years' or ''
          "Victim Age": "string", // e.g., '38 years' or ''
          "Previous Incidents": "string", // In English, e.g., 'convicted by verdict K.no. 850/05' (keep verdict numbers original)
          "Alcohol or Drugs": "boolean", // true or false
          "Children Present": "boolean", // true or false
          "Use of Weapon": "boolean", // true if Execution Means involves 'weapon' or 'tool', false otherwise
          "Number of Victims": "integer", // Number of victims mentioned
          "Number of Defendants": "integer" // Number of defendants mentioned
        ```"""),
        ("user", """From the following court verdict text, extract the requested information in JSON format according to the given schema:

        Verdict:
        {input}
        """)
    ])

# Function to clean response
def clean_response(text):
    text = text.strip()
    if text.startswith("```json"):
        text = text[len("```json"):].strip()
    if text.endswith("```"):
        text = text[:-len("```")].strip()
    return text

# Function to process one case
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

    # Standardize formats
    if parsed.get("Criminal Offense"):
        parsed["Criminal Offense"] = parsed["Criminal Offense"].replace("čl.", "cl.").replace("stav", "st.")
    if parsed.get("Applied Provisions"):
        parsed["Applied Provisions"] = parsed["Applied Provisions"].replace("čl.", "cl.").replace("stav", "st.")
    if parsed.get("Injury Types"):
        injuries = parsed["Injury Types"].lower()
        if "light" in injuries and "severe" in injuries:
            parsed["Injury Types"] = "light,severe"
        elif "light" in injuries or "lake" in injuries:
            parsed["Injury Types"] = "light"
        elif "severe" in injuries or "teške" in injuries:
            parsed["Injury Types"] = "severe"
        else:
            parsed["Injury Types"] = ""
    if parsed.get("Victim Relationship"):
        rel = parsed["Victim Relationship"].lower()
        if "spouse" in rel or "supruga" in rel or "suprug" in rel:
            parsed["Victim Relationship"] = "spouse"
        elif "parent" in rel or "majka" in rel or "otac" in rel:
            parsed["Victim Relationship"] = "parent"
        elif "sibling" in rel or "sestra" in rel or "brat" in rel:
            parsed["Victim Relationship"] = "sibling"
        elif "child" in rel or "dete" in rel or "sin" in rel or "kći" in rel:
            parsed["Victim Relationship"] = "child"
        else:
            parsed["Victim Relationship"] = "other"
    if parsed.get("Violence Nature"):
        vio = parsed["Violence Nature"].lower()
        if "rough violence" in vio or "grubo nasilje" in vio:
            parsed["Violence Nature"] = "rough violence"
        elif "threat" in vio or "prijetnja" in vio:
            parsed["Violence Nature"] = "threat"
        elif "arrogant and reckless behavior" in vio or "drsko i bezobzirno ponašanje" in vio:
            parsed["Violence Nature"] = "arrogant and reckless behavior"
        else:
            parsed["Violence Nature"] = ""
    if parsed.get("Execution Means"):
        means = parsed["Execution Means"].lower()
        if "pesnica" in means or "hand" in means or "fist" in means:
            parsed["Execution Means"] = "hands"
        elif "noga" in means or "foot" in means or "feet" in means:
            parsed["Execution Means"] = "feet"
        elif "oružje" in means or "weapon" in means or "gun" in means or "knife" in means:
            parsed["Execution Means"] = "weapon"
        elif "alat" in means or "tool" in means or "kliješta" in means or "pliers" in means:
            parsed["Execution Means"] = "tool:pliers"
        elif "verbal" in means or "prijetnja" in means or "threat" in means:
            parsed["Execution Means"] = "verbal"
        else:
            parsed["Execution Means"] = "other"
    if parsed.get("Use of Weapon"):
        parsed["Use of Weapon"] = parsed["Execution Means"] in ["weapon", "tool:pliers"]
    if parsed.get("Defendant Status"):
        status = parsed["Defendant Status"].lower()
        status_parts = []
        if "nezaposlen" in status or "unemployed" in status:
            status_parts.append("unemployed")
        if "neoženjen" in status or "unmarried" in status:
            status_parts.append("unmarried")
        if "osuđivan" in status or "previously convicted" in status:
            status_parts.append("previously convicted")
        parsed["Defendant Status"] = ", ".join(status_parts) if status_parts else ""
    if parsed.get("Verdict Type") not in ["PRISON", "SUSPENDED", "ACQUITTED", "DETENTION"]:
        parsed["Verdict Type"] = "SUSPENDED"

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
        "Number of Defendants": str(meta.get("Number of Defendants", 1))
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