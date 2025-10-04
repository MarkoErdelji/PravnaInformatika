import os
import csv
from pathlib import Path
from lxml import etree
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate
import json
import logging

logging.basicConfig(
    filename='parsing_log.txt',
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)

os.environ["OPENAI_API_KEY"] = "PLACEHOLDER"

BASE_DIR = Path(__file__).resolve().parent
XML_FOLDER = BASE_DIR / "judgingapp" / "xml"
OUTPUT_CSV = BASE_DIR / "judgingapp" / "src" / "main" / "resources" / "verdicts.csv"

VERDICT_HEADERS = [
    "ID", "COURT", "CASE NUMBER", "JUDGE", "CLERK", "PROSECUTOR", "DEFENDANT", "VERDICT DATE", "VICTIM",
    "SHORT DESCRIPTION", "JUDGMENT", "APPLIED PROVISIONS", "ACCUSATION",
    "IS MOVABLE PROPERTY", "IS TAKEN", "INTENT TO APPROPRIATE", "VALUE OF STOLEN ITEMS",
    "IS CULTURAL OR NATURAL GOOD", "BREAKING AND ENTERING", "PARTICULARLY DANGEROUS OR BRAZEN",
    "EXPLOITING HELPLESSNESS", "DURING DISASTER", "NUMBER OF PERPETRATORS", "IS ARMED",
    "USE OF FORCE OR THREAT", "CAUGHT IN THE ACT", "INTENT FOR SMALL GAIN",
    "CAUSED SEVERE INJURY", "DEATH CAUSED", "ATTEMPTED CRIME"
]

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
            'ID': str(xml_path.stem),
            'COURT': safe_text(root.find(".//akn:FRBRauthor", namespaces=NS)),
            'CASE NUMBER': safe_text(root.find(".//akn:FRBRtitle", namespaces=NS)),
            'VERDICT DATE': safe_get(root.find(".//akn:FRBRdate", namespaces=NS), "date"),
        }

        judge = root.find(".//akn:party[@as='#judge']", namespaces=NS)
        meta['JUDGE'] = safe_get(
            root.find(f".//akn:TLCPerson[@eId='{safe_get(judge, 'refersTo').lstrip('#')}']", namespaces=NS),
            "showAs"
        ) if judge is not None else ""

        clerk = root.find(".//akn:party[@as='#clerk']", namespaces=NS)
        meta['CLERK'] = safe_get(
            root.find(f".//akn:TLCPerson[@eId='{safe_get(clerk, 'refersTo').lstrip('#')}']", namespaces=NS),
            "showAs"
        ) if clerk is not None else ""

        prosecutor_org = root.find(".//akn:organization[@as='#odt']", namespaces=NS)
        meta['PROSECUTOR'] = safe_get(prosecutor_org, "showAs") or "Osnovno državno tužilaštvo"

        defendants = [
            safe_get(root.find(f".//akn:TLCPerson[@eId='{safe_get(defendant, 'refersTo').lstrip('#')}']", namespaces=NS), "showAs")
            for defendant in root.findall(".//akn:party[@as='#defendant']", namespaces=NS)
            if defendant is not None
        ]
        meta['DEFENDANT'] = ", ".join(defendants) if defendants else ""

        victims = [
            safe_get(root.find(f".//akn:TLCPerson[@eId='{safe_get(victim, 'refersTo').lstrip('#')}']", namespaces=NS), "showAs")
            for victim in root.findall(".//akn:party[@as='#victim']", namespaces=NS)
            if victim is not None
        ]
        meta['VICTIM'] = ", ".join(victims)

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
        ("system", """You are an expert in legal documents in Montenegrin language. Analyze the court verdict text and extract the requested information in JSON format. Keep fields like APPLIED PROVISIONS and ACCUSATION in their original form. For ACCUSATION, extract each accusation as a separate string in the format 'čl. <article> st. <stav>' (e.g., 'čl. 239 st. 1') or 'čl. <article>' if no stav is specified. If multiple accusations are present (e.g., 'čl. 239 st. 1 u vezi čl. 240 st. 2'), split them into separate entries in the array. Extract facts of the case as specified, using English for field names. Provide a SHORT DESCRIPTION as a brief summary (1-2 sentences) in Serbian of the case details not covered by the specific legal facts. Extract JUDGMENT as one of the following verdict types: ACQUITTAL (oslobađajuća presuda, e.g., 'ODBIJA SE OPTUŽBA' due to lack of evidence), FINE (novčana kazna), PRISON (kazna zatvora), SUSPENDED (uslovna osuda), FINE_AND_PRISON (kombinacija novčane kazne i zatvora), DISMISSAL (odbačaj optužbe due to procedural issues). Ensure NUMBER OF PERPETRATORS matches the number of defendants listed in the verdict text. If JUDGMENT is provided in the XML <conclusions> section, use that value; otherwise, infer it from the text.

Use these strongly-typed fields:
- SHORT DESCRIPTION (string): Brief summary of the case details in Serbian (1-2 sentences)
- JUDGMENT (string): Verdict outcome (ACQUITTAL, FINE, PRISON, SUSPENDED, FINE_AND_PRISON, DISMISSAL)
- APPLIED PROVISIONS (string): Legal provisions applied in the verdict (e.g., 'čl. 372 st. 1')
- ACCUSATION (array of strings): The criminal offenses the defendant was accused of (e.g., ['čl. 239 st. 1', 'čl. 240 st. 2'])
- IS MOVABLE PROPERTY (boolean): Whether the stolen item is someone else's movable property
- IS TAKEN (boolean): Whether the item was taken from another person
- INTENT TO APPROPRIATE (boolean): Whether there was intent to appropriate the item for unlawful gain
- VALUE OF STOLEN ITEMS (number): Value of stolen items in euros (minimum 0)
- IS CULTURAL OR NATURAL GOOD (boolean): Whether the stolen item is a cultural or natural good
- BREAKING AND ENTERING (boolean): Whether the theft involved breaking and entering closed spaces
- PARTICULARLY DANGEROUS OR BRAZEN (boolean): Whether the theft was committed in a particularly dangerous or brazen manner
- EXPLOITING HELPLESSNESS (boolean): Whether the theft exploited helplessness or a difficult state of a person
- DURING DISASTER (boolean): Whether the theft occurred during a fire, flood, earthquake, or other disaster
- NUMBER OF PERPETRATORS (number): Number of perpetrators involved (minimum 1, must match number of defendants)
- IS ARMED (boolean): Whether the perpetrator carried a weapon or dangerous tool
- USE OF FORCE OR THREAT (boolean): Whether force or threat to life/body was used
- CAUGHT IN THE ACT (boolean): Whether the perpetrator was caught in the act of theft
- INTENT FOR SMALL GAIN (boolean): Whether the intent was to gain a small benefit (<150 euros)
- CAUSED SEVERE INJURY (boolean): Whether severe bodily injury was intentionally caused
- DEATH CAUSED (boolean): Whether a person was intentionally killed during the act
- ATTEMPTED CRIME (boolean): Whether the act was an attempt

Return a valid JSON object with all fields. If a field cannot be determined, use appropriate defaults (e.g., [] for arrays, "" for strings, false for booleans, 0 for numbers). Example:


  "SHORT DESCRIPTION": "Okrivljeni je priključio svoj stambeni objekat na elektromrežu zaobilazeći brojilo kablom 2x2.5 mm CU, oduzimajući električnu energiju od oštećenog.",
  "JUDGMENT": "ACQUITTAL",
  "APPLIED PROVISIONS": "čl. 372 st. 1",
  "ACCUSATION": ["čl. 239 st. 1"],
  "IS MOVABLE PROPERTY": true,
  "IS TAKEN": true,
  "INTENT TO APPROPRIATE": true,
  "VALUE OF STOLEN ITEMS": 327.77,
  "IS CULTURAL OR NATURAL GOOD": false,
  "BREAKING AND ENTERING": false,
  "PARTICULARLY DANGEROUS OR BRAZEN": false,
  "EXPLOITING HELPLESSNESS": false,
  "DURING DISASTER": false,
  "NUMBER OF PERPETRATORS": 1,
  "IS ARMED": false,
  "USE OF FORCE OR THREAT": false,
  "CAUGHT IN THE ACT": false,
  "INTENT FOR SMALL GAIN": false,
  "CAUSED SEVERE INJURY": false,
  "DEATH CAUSED": false,
  "ATTEMPTED CRIME": false

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
        
        # Ensure ACCUSATION is a list
        if "ACCUSATION" in verdict_data:
            if isinstance(verdict_data["ACCUSATION"], str):
                verdict_data["ACCUSATION"] = [verdict_data["ACCUSATION"]] if verdict_data["ACCUSATION"] else []
            elif not isinstance(verdict_data["ACCUSATION"], list):
                logging.warning(f"Invalid ACCUSATION format for {xml_path.name}: {verdict_data['ACCUSATION']}")
                verdict_data["ACCUSATION"] = []
        else:
            verdict_data["ACCUSATION"] = []
        
    except json.JSONDecodeError as e:
        logging.error(f"Error decoding JSON for {xml_path.name}: {e}")
        print(f"Error decoding JSON for {xml_path.name}")
        return None
    except Exception as e:
        logging.error(f"Error processing {xml_path.name} with LLM: {e}")
        print(f"Error processing {xml_path.name}")
        return None

    verdict = {**meta, **verdict_data}

    defaults = {
        "ID": "",
        "COURT": "",
        "CASE NUMBER": "",
        "JUDGE": "",
        "CLERK": "",
        "PROSECUTOR": "",
        "DEFENDANT": "",
        "VERDICT DATE": "",
        "VICTIM": "",
        "SHORT DESCRIPTION": "",
        "JUDGMENT": "",
        "APPLIED PROVISIONS": "",
        "ACCUSATION": [],
        "IS MOVABLE PROPERTY": False,
        "IS TAKEN": False,
        "INTENT TO APPROPRIATE": False,
        "VALUE OF STOLEN ITEMS": 0.0,
        "IS CULTURAL OR NATURAL GOOD": False,
        "BREAKING AND ENTERING": False,
        "PARTICULARLY DANGEROUS OR BRAZEN": False,
        "EXPLOITING HELPLESSNESS": False,
        "DURING DISASTER": False,
        "NUMBER OF PERPETRATORS": 1,
        "IS ARMED": False,
        "USE OF FORCE OR THREAT": False,
        "CAUGHT IN THE ACT": False,
        "INTENT FOR SMALL GAIN": False,
        "CAUSED SEVERE INJURY": False,
        "DEATH CAUSED": False,
        "ATTEMPTED CRIME": False
    }

    for key in VERDICT_HEADERS:
        if key not in verdict:
            verdict[key] = defaults.get(key, "")

    verdict["SHORT DESCRIPTION"] = str(verdict.get("SHORT DESCRIPTION", ""))
    verdict["JUDGMENT"] = str(verdict.get("JUDGMENT", ""))
    verdict["APPLIED PROVISIONS"] = str(verdict.get("APPLIED PROVISIONS", ""))
    verdict["ACCUSATION"] = ";".join(verdict.get("ACCUSATION", []))  # Convert list to semicolon-separated string for CSV
    verdict["IS MOVABLE PROPERTY"] = bool(verdict.get("IS MOVABLE PROPERTY", False))
    verdict["IS TAKEN"] = bool(verdict.get("IS TAKEN", False))
    verdict["INTENT TO APPROPRIATE"] = bool(verdict.get("INTENT TO APPROPRIATE", False))
    verdict["VALUE OF STOLEN ITEMS"] = float(verdict.get("VALUE OF STOLEN ITEMS", 0.0))
    verdict["IS CULTURAL OR NATURAL GOOD"] = bool(verdict.get("IS CULTURAL OR NATURAL GOOD", False))
    verdict["BREAKING AND ENTERING"] = bool(verdict.get("BREAKING AND ENTERING", False))
    verdict["PARTICULARLY DANGEROUS OR BRAZEN"] = bool(verdict.get("PARTICULARLY DANGEROUS OR BRAZEN", False))
    verdict["EXPLOITING HELPLESSNESS"] = bool(verdict.get("EXPLOITING HELPLESSNESS", False))
    verdict["DURING DISASTER"] = bool(verdict.get("DURING DISASTER", False))
    verdict["NUMBER OF PERPETRATORS"] = int(verdict.get("NUMBER OF PERPETRATORS", 1))
    verdict["IS ARMED"] = bool(verdict.get("IS ARMED", False))
    verdict["USE OF FORCE OR THREAT"] = bool(verdict.get("USE OF FORCE OR THREAT", False))
    verdict["CAUGHT IN THE ACT"] = bool(verdict.get("CAUGHT IN THE ACT", False))
    verdict["INTENT FOR SMALL GAIN"] = bool(verdict.get("INTENT FOR SMALL GAIN", False))
    verdict["CAUSED SEVERE INJURY"] = bool(verdict.get("CAUSED SEVERE INJURY", False))
    verdict["DEATH CAUSED"] = bool(verdict.get("DEATH CAUSED", False))
    verdict["ATTEMPTED CRIME"] = bool(verdict.get("ATTEMPTED CRIME", False))

    logging.info(f"Successfully processed {xml_path.name}")
    return verdict

def run_pipeline():
    """Run the pipeline to process all XML files and write to CSV."""
    llm = ChatOpenAI(model="gpt-4o", temperature=0)
    prompt = build_prompt()

    if not XML_FOLDER.exists():
        raise FileNotFoundError(f"XML folder {XML_FOLDER} does not exist.")
    
    xml_files = list(XML_FOLDER.glob("*.xml"))
    if not xml_files:
        logging.warning(f"No XML files found in {XML_FOLDER}.")
        print(f"No XML files found in {XML_FOLDER}.")
        return

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

    logging.info(f"Processing complete. Processed: {processed}, Skipped: {skipped}")
    print(f"Processing complete. Processed: {processed}, Skipped: {skipped}")

if __name__ == "__main__":
    run_pipeline()