import os
import argparse
import pathlib
import xml.etree.ElementTree as ET
import re
import logging
from langchain_core.prompts import ChatPromptTemplate
from langchain_openai import ChatOpenAI
from dotenv import load_dotenv

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')
logger = logging.getLogger(__name__)


os.environ["OPENAI_API_KEY"] = "PLACEHOLDER"
llm = ChatOpenAI(model="gpt-4o", temperature=0)

example_dir = pathlib.Path("./presude/primer")
example_files = list(example_dir.glob("*.xml")) if example_dir.exists() else []
examples = [file.read_text(encoding="utf-8") for file in example_files]
example_text = "\n\n".join(examples) if examples else "<akomaNtoso><judgment><judgmentBody/></judgment></akomaNtoso>"

conclusion_example = """
Na osnovu
    <ref href="/krivicni#art_220">čl. 220 st. 2 Krivičnog zakonika Crne Gore</ref>
    i
    <ref href="/krivicni#art_220">čl. 220 st. 3 Krivičnog zakonika Crne Gore</ref>
sud izriče...
"""

prompt = ChatPromptTemplate.from_messages([
    ("system",
     """Ti si ekspert za Akoma Ntoso 3.0 XML standard za pravne dokumente. Tvoj zadatak je da konvertuješ sudsku presudu u validan Akoma Ntoso 3.0 XML dokument sa strukturom <akomaNtoso><judgment>. XML mora biti sintaksno ispravan i u skladu sa standardom[](http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17). Obavezno:

- Ispuni SAMO XML, bez dodatnih komentara, objašnjenja ili code blockova (npr. ```xml).
- Počni sa XML deklaracijom i namespace atributima:
  <?xml version="1.0" encoding="UTF-8"?>
  <akomaNtoso xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17 ../schemas/akomantoso30.xsd"
              xmlns="http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17">
- Koristi <meta> sekciju za metapodatke (FRBRWork sa FRBRauthor za sud, FRBRdate za datum presude, FRBRtitle za broj slučaja, FRBRcountry za 'ME'). U references uključi TLCOrganization za sud i tužilaštvo, TLCPerson za sudiju, zapisničara, okrivljenog, oštećenog itd., TLCRole za uloge.
- U <judgmentBody> strukturiši sadržaj detaljno:
  - Prvi <p> za uvodni deo (sud, sudija, zapisničar, optužni predlog, datum pretresa, prisutni).
  - <p><b>PRESUDU</b></p> za glavni naslov presude.
  - <p> za opis okrivljenog (Okrivljeni: ..).
  - <p><b>Kriv je</b></p> za izjavu o krivici.
  - <p> za opis djela (Što je: ...).
  - <p> za referencu na krivično djelo (-čime je učinio...).
  - !IMPORTANT: Odvoj pasuse da imaju smisla kasnije za prikazivanje, treba da budu celine i popravi reci koje nise pravopisne naprimer P R E S U D U u PRESUDU i sve ostale gde nadjes pravopisne
  greske moras obavezno da popravis, takodje pazi da nemas duplikata referenci osoba.
- Koristi <ref> tagove za članke zakona (npr. <ref href="/krivicni#art_220">čl. 220 st. 1</ref>).
- Održavaj hijerarhiju i semantiku tagova (<party> za osobe, <organization> za institucije, <date> za datume, <amount> za iznose, <time> za trajanje).
- Svi tekstualni sadržaji moraju biti XML-escaped (npr. & -> &amp;, < -> &lt;).
- Ako je tekst u formatu koji sugeriše podnaslov (npr. velika slova, bold), označi ga sa <b> unutar <p>.

Primeri Akoma Ntoso XML dokumenata:
{examples}

Primer zaključka sa referencama:
{conclusion_example}

- Ako se u tekstu pojavljuje "st. X" nakon člana, obavezno uključi u <ref> tag (npr. <ref href="/krivicni#art_220_st_2">čl. 220 st. 2</ref>).
- Ako nema "st.", referenciraj samo član.

Na osnovu sledećeg teksta, generiši Akoma Ntoso XML. Ponavljam: vrati SAMO validan XML bez code blockova ili dodatnog teksta:
""".format(examples=example_text, conclusion_example=conclusion_example)
    ),
    ("user", "{input}")
])

def clean_xml_response(xml_string: str) -> str:
    """Remove code block markers and extra whitespace from LLM response."""
    xml_string = re.sub(r'^```xml\s*\n|```$', '', xml_string, flags=re.MULTILINE)
    xml_string = re.sub(r'^```|```$', '', xml_string, flags=re.MULTILINE)
    xml_string = xml_string.strip()
    if not xml_string.startswith('<?xml'):
        xml_string = (
            '<?xml version="1.0" encoding="UTF-8"?>\n'
            '<akomaNtoso xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" '
            'xsi:schemaLocation="http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17 ../schemas/akomantoso30.xsd" '
            'xmlns="http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17">\n'
            + xml_string +
            '\n</akomaNtoso>'
        )
    return xml_string

def validate_xml(xml_string: str) -> bool:
    """Validate if the generated XML is well-formed and Akoma Ntoso compliant."""
    try:
        tree = ET.fromstring(xml_string)
        if tree.tag != '{http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17}akomaNtoso':
            logger.error("XML does not have <akomaNtoso> as root")
            return False
        if not tree.find('.//{http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17}judgment'):
            logger.error("XML does not contain <judgment> element")
            return False
        if not tree.find('.//{http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17}list'):
            logger.warning("No <list> element found, but proceeding")
        return True
    except ET.ParseError as e:
        logger.error(f"Invalid XML generated: {e}")
        return False

def convert_presuda(text: str, file_path: pathlib.Path):
    """Convert text to Akoma Ntoso XML and save it."""
    try:
        chain = prompt | llm
        result = chain.invoke({"input": text})
        xml_content = clean_xml_response(result.content)

        logger.debug(f"Raw LLM response: {result.content}")

        if not validate_xml(xml_content):
            logger.error(f"Skipping {file_path}: Generated XML is not well-formed or not Akoma Ntoso compliant")
            return

        output_dir = pathlib.Path("./judgingapp/xml")
        output_dir.mkdir(parents=True, exist_ok=True)
        output_path = output_dir / f"{file_path.stem}.xml"
        output_path.write_text(xml_content, encoding="utf-8")
        logger.info(f"[✓] Sačuvano: {output_path}")
    except Exception as e:
        logger.error(f"Error processing {file_path}: {e}")

def main():
    """Process all .txt files in the presude/text folder."""
    parser = argparse.ArgumentParser(description="Convert text judgments to Akoma Ntoso XML")
    parser.add_argument('--input-dir', type=str, default="./presude/text", help="Input directory with .txt files")
    args = parser.parse_args()

    folder_path = pathlib.Path(args.input_dir)
    if not folder_path.exists():
        logger.error(f"[!] Folder ne postoji: {folder_path}")
        return

    txt_files = list(folder_path.rglob("*.txt"))
    if not txt_files:
        logger.error(f"[!] Nema .txt fajlova u {folder_path}")
        return

    for file_path in txt_files:
        logger.info(f"Procesiram: {file_path}")
        text = file_path.read_text(encoding="utf-8")
        convert_presuda(text, file_path)

if __name__ == "__main__":
    main()