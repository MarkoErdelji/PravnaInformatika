import os
import csv
from pathlib import Path
from lxml import etree
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate
import json
import logging

# Configure logging
logging.basicConfig(
    filename='parsing_log.txt',
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

os.environ["OPENAI_API_KEY"] = "PLACEHOLDER"

# Define paths
BASE_DIR = Path(__file__).resolve().parent
XML_FOLDER = BASE_DIR / "judgingapp" / "xml"
OUTPUT_CSV = BASE_DIR / "judgingapp" / "src" / "main" / "resources" / "verdicts.csv"

# Define CSV headers
VERDICT_HEADERS = [
    "id", "Court", "Case Number", "Judge", "Clerk", "Prosecutor", "Defendant",
    "Criminal Offense", "Verdict Type", "Applied Provisions", "Verdict Date",
    "Victim", "Penalty", "Event Location", "Event Date",
    "Violence Nature", "Injury Types", "Use of Weapon",
    "Main Victim Age", "Main Victim Relationship", "Protection Measure Violation",
     "Procedure Costs", "Defendant Status", "Children Present",
    "Number of Victims", "Aware of Illegality", "Alcohol or Drugs"
]

# XML namespace
NS = {"akn": "http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17"}

def safe_get(element, attr):
    """Safely get an attribute from an XML element."""
    try:
        return element.get(attr, "") if element is not None else ""
    except Exception as e:
        logging.error(f"Error getting attribute {attr}: {e}")
        return ""

def safe_text(element):
    """Safely get text from an XML element."""
    try:
        return element.text.strip() if element is not None and element.text else ""
    except Exception as e:
        logging.error(f"Error getting text: {e}")
        return ""

def extract_metadata_and_text(xml_path):
    """Extract metadata and full text from an XML file."""
    try:
        tree = etree.parse(xml_path)
        root = tree.getroot()

        meta = {
            'id': str(xml_path.stem),
            'Court': safe_text(root.find(".//akn:FRBRauthor", namespaces=NS)),
            'Case Number': safe_text(root.find(".//akn:FRBRtitle", namespaces=NS)),
            'Verdict Date': safe_get(root.find(".//akn:FRBRdate", namespaces=NS), "date"),
        }

        # Extract Judge
        judge = root.find(".//akn:party[@as='#judge']", namespaces=NS)
        meta['Judge'] = safe_get(
            root.find(f".//akn:TLCPerson[@eId='{safe_get(judge, 'refersTo').lstrip('#')}']", namespaces=NS),
            "showAs"
        ) if judge is not None else ""

        # Extract Clerk
        clerk = root.find(".//akn:party[@as='#clerk']", namespaces=NS)
        meta['Clerk'] = safe_get(
            root.find(f".//akn:TLCPerson[@eId='{safe_get(clerk, 'refersTo').lstrip('#')}']", namespaces=NS),
            "showAs"
        ) if clerk is not None else ""

        # Extract Prosecutor
        prosecutor_org = root.find(".//akn:organization[@refersTo='#odt']", namespaces=NS)
        meta['Prosecutor'] = safe_get(prosecutor_org, "showAs") or "Osnovno državno tužilaštvo"

        # Extract Defendant
        defendant = root.find(".//akn:party[@as='#defendant']", namespaces=NS)
        meta['Defendant'] = safe_get(
            root.find(f".//akn:TLCPerson[@eId='{safe_get(defendant, 'refersTo').lstrip('#')}']", namespaces=NS),
            "showAs"
        ) if defendant is not None else ""

        # Extract Victims
        victims = [
            safe_get(root.find(f".//akn:TLCPerson[@eId='{safe_get(victim, 'refersTo').lstrip('#')}']", namespaces=NS), "showAs")
            for victim in root.findall(".//akn:party[@as='#victim']", namespaces=NS)
            if victim is not None
        ]
        meta['Victim'] = ", ".join(victims)
        meta['Number of Victims'] = len(victims)

        # Extract Judgment Body Text
        judgment_body = root.find(".//akn:judgmentBody", namespaces=NS)
        full_text = etree.tostring(judgment_body, method="text", encoding="unicode").strip() if judgment_body is not None else ""

        logging.info(f"Successfully extracted metadata and text from {xml_path.name}")
        return meta, full_text

    except Exception as e:
        logging.error(f"Error parsing {xml_path}: {e}")
        print(f"Error parsing {xml_path}: {e}")
        return {}, ""

def build_prompt():
    """Build the prompt for the LLM."""
    return ChatPromptTemplate.from_messages([
        ("system", """You are an expert in legal documents in Serbian language. Analyze the court verdict text and extract the requested information in JSON format. Keep metadata like names, locations, dates in their original form. Translate and standardize facts of the case to English.

Use these strongly-typed fields:
- Violence Nature (enum): "NONE", "PHYSICAL", "PSYCHOLOGICAL"
- Injury Types (enum): "NONE", "MINOR", "SERIOUS", "DEATH"
- Use of Weapon (boolean): true, false
- Main Victim Age (int): 0–120
- Main Victim Relationship (enum): "SPOUSE", "CHILD", "PARENT", "SIBLING", "OTHER_RELATIVE"
- Protection Measure Violation (boolean): true, false
- Verdict Type (enum): "ACQUITTAL", "FINE", "PRISON", "SUSPENDED", "FINE_AND_PRISON"


Return a valid JSON object with all fields. If a field cannot be determined, use appropriate defaults (e.g., "" for strings, false for booleans, 0 for integers). Examples:


  "Criminal Offense": "cl. 220 st. 5",
  "Verdict Type": "CONDITIONAL",
  "Applied Provisions": "cl. 220 st. 5, cl. 42 st. 1 KZ",
  "Penalty": "conditional sentence of 6 months",
  "Event Location": "Podgorica, ul. Mitra Bakića 154",
  "Event Date": "2023-01-24",
  "Violence Nature": "PHYSICAL",
  "Injury Types": "MINOR",
  "Use of Weapon": true,
  "Main Victim Age": 62,
  "Main Victim Relationship": "PARENT",
  "Protection Measure Violation": true,
  "Procedure Costs": "71.50 EUR",
  "Defendant Status": "employed",
  "Alcohol or Drugs": false,
  "Children Present": false,
  "Aware of Illegality": true
"""),
        ("user", """From the following court verdict text, extract the requested information in JSON format:

Verdict:
{input}""")
    ])

def clean_response(text):
    """Clean the LLM response to extract valid JSON."""
    text = text.strip()
    if text.startswith("```json"):
        text = text[len("```json"):].strip()
    if text.endswith("```"):
        text = text[:-len("```")].strip()
    return text

def process_case(xml_path, llm, prompt):
    """Process a single XML case file."""
    meta, text = extract_metadata_and_text(xml_path)
    if not text or not meta:
        logging.warning(f"Skipped {xml_path.name} due to empty text or metadata.")
        return None

    chain = prompt | llm
    try:
        result = chain.invoke({"input": text})
        verdict_data = json.loads(clean_response(result.content))
    except json.JSONDecodeError as e:
        logging.error(f"Error decoding JSON for {xml_path.name}: {e}")
        print(f"Error decoding JSON for {xml_path.name}")
        return None
    except Exception as e:
        logging.error(f"Error processing {xml_path.name} with LLM: {e}")
        print(f"Error processing {xml_path.name}")
        return None

    # Combine metadata and LLM output
    verdict = {**meta, **verdict_data}

    # Ensure all fields are present with defaults
    defaults = {
        "Criminal Offense": "",
        "Verdict Type": "",
        "Applied Provisions": "",
        "Penalty": "",
        "Event Location": "",
        "Event Date": "",
        "Violence Nature": "NONE",
        "Injury Types": "NONE",
        "Use of Weapon": False,
        "Main Victim Age": 0,
        "Main Victim Relationship": "OTHER_RELATIVE",
        "Protection Measure Violation": False,
        "Procedure Costs": "",
        "Defendant Status": "",
        "Defendant Age": 0,
        "Previous Incidents": "",
        "Alcohol or Drugs": False,
        "Children Present": False,
        "Aware of Illegality": True,
        "Number of Victims": meta.get("Number of Victims", 0),
    }

    for key in VERDICT_HEADERS:
        if key not in verdict:
            verdict[key] = defaults.get(key, "")

    # Validate and standardize fields, ensuring uppercase ENUMs
    verdict["Violence Nature"] = str(verdict.get("Violence Nature", "NONE")).upper()
    if verdict["Violence Nature"] not in ["NONE", "PHYSICAL", "PSYCHOLOGICAL"]:
        verdict["Violence Nature"] = "NONE"

    verdict["Injury Types"] = str(verdict.get("Injury Types", "NONE")).upper()
    if verdict["Injury Types"] not in ["NONE", "MINOR", "SERIOUS", "DEATH"]:
        verdict["Injury Types"] = "NONE"

    verdict["Main Victim Relationship"] = str(verdict.get("Main Victim Relationship", "OTHER_RELATIVE")).upper()
    if verdict["Main Victim Relationship"] not in ["SPOUSE", "CHILD", "PARENT", "SIBLING", "OTHER_RELATIVE"]:
        verdict["Main Victim Relationship"] = "OTHER_RELATIVE"

    verdict["Use of Weapon"] = bool(verdict.get("Use of Weapon", False))
    verdict["Protection Measure Violation"] = bool(verdict.get("Protection Measure Violation", False))
    verdict["Main Victim Age"] = int(verdict.get("Main Victim Age", 0))
    verdict["Number of Victims"] = int(verdict.get("Number of Victims", 0))
    verdict["Alcohol or Drugs"] = bool(verdict.get("Alcohol or Drugs", False))
    verdict["Children Present"] = bool(verdict.get("Children Present", False))
    verdict["Aware of Illegality"] = bool(verdict.get("Aware of Illegality", True))

    logging.info(f"Successfully processed {xml_path.name}")
    return verdict

def run_pipeline():
    """Run the pipeline to process all XML files and write to CSV."""
    llm = ChatOpenAI(model="gpt-4o", temperature=0)
    prompt = build_prompt()

    # Verify XML folder exists
    if not XML_FOLDER.exists():
        raise FileNotFoundError(f"XML folder {XML_FOLDER} does not exist.")
    
    xml_files = list(XML_FOLDER.glob("*.xml"))
    if not xml_files:
        logging.warning(f"No XML files found in {XML_FOLDER}.")
        print(f"No XML files found in {XML_FOLDER}.")
        return

    # Create output directory
    OUTPUT_CSV.parent.mkdir(parents=True, exist_ok=True)

    processed = 0
    skipped = 0

    with open(OUTPUT_CSV, "w", encoding="utf-8", newline="") as csv_file:
        writer = csv.DictWriter(csv_file, fieldnames=VERDICT_HEADERS, delimiter=";")
        writer.writeheader()

        for xml_file in xml_files:
            print(f"Processing: {xml_file.name}")
            verdict = process_case(xml_file, llm, prompt)
            if verdict:
                writer.writerow(verdict)
                processed += 1
            else:
                print(f"Skipped {xml_file.name} due to error.")
                skipped += 1

    # Log summary
    logging.info(f"Processing complete. Processed: {processed}, Skipped: {skipped}")
    print(f"Processing complete. Processed: {processed}, Skipped: {skipped}")


if __name__ == "__main__":
    run_pipeline()
