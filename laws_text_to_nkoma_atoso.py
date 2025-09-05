import os
import argparse
import pathlib
import xml.etree.ElementTree as ET
from langchain_core.prompts import ChatPromptTemplate
from langchain_openai import ChatOpenAI
import json
import re 
# Initialize OpenAI model (replace with your API key setup)
os.environ["OPENAI_API_KEY"] = "PLACEHOLDER"
llm = ChatOpenAI(model="gpt-4o",temperature=0)


# Example law text and Akoma Ntoso XML (same as provided)
example_law_text = """
GLAVA ČETRNAESTA KRIVIČNA DJELA PROTIV ŽIVOTA I TIJELA
Učestvovanje u tuči
Član 152
st. 1
Ko drugog lako tjelesno povrijedi ili mu zdravlje lako naruši, kazniće se novčanom kaznom ili zatvorom do jedne godine.
st. 2
Ako je takva povreda nanesena oružjem, opasnim oruđem ili drugim sredstvom podobnim da tijelo teško povrijedi ili zdravlje teško naruši, učinilac će se kazniti zatvorom do tri godine.
st. 3
Sud može učiniocu djela iz stava 2 ovog člana izreći sudsku opomenu, ako je učinilac bio izazvan nepristojnim ili grubim ponašanjem oštećenog.
st. 4
Gonjenje za djelo iz stava 1 ovog člana preduzima se po privatnoj tužbi.

GLAVA OSAMNAESTA 
ISTRAGA
Svrha istrage
Član 274
st. 1
Istraga se sprovodi na osnovu naredbe o sprovođenju istrage protiv određenog lica kad postoji osnovana sumnja da je učinilo krivično djelo.
st. 2
U istrazi će se prikupiti dokazi i podaci koji su potrebni državnom tužiocu za donošenje odluke o podizanju optužnice ili o obustavi istrage i dokazi za koje postoji opasnost da se neće moći ponoviti na glavnom pretresu ili bi njihovo izvođenje bilo otežano, kao i drugi dokazi koji mogu biti od koristi za postupak, a čije se izvođenje, s obzirom na okolnosti slučaja, pokazuje cjelishodnim.
"""

example_akoma_ntoso = """
<?xml version="1.0" encoding="UTF-8"?>
<akomaNtoso xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17 ../schemas/akomantoso30.xsd"
            xmlns="http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17">
  <act contains="originalVersion">
    <meta>
      <identification source="#government">
        <FRBRWork>
          <FRBRthis value="/krivicni/main"/>
          <FRBRuri value="/krivicni"/>
          <FRBRdate date="2025-08-31" name="publication"/>
          <FRBRauthor href="#parliament"/>
          <FRBRcountry value="ME"/>
        </FRBRWork>
        <FRBRExpression>
          <FRBRthis value="/krivicni/main/2025-08-31"/>
          <FRBRuri value="/krivicni/2025-08-31"/>
          <FRBRdate date="2025-08-31" name="publication"/>
          <FRBRauthor href="#parliament"/>
        </FRBRExpression>
        <FRBRManifestation>
          <FRBRthis value="/krivicni/main/2025-08-31/xml"/>
          <FRBRuri value="/krivicni/2025-08-31/xml"/>
          <FRBRdate date="2025-08-31" name="publication"/>
          <FRBRauthor href="#government"/>
        </FRBRManifestation>
      </identification>
      <references source="#government">
        <TLCOrganization eId="parliament" href="/ontology/organization/me/parliament" showAs="Skupština Crne Gore"/>
        <TLCConcept eId="krivicni" href="/krivicni" showAs="Krivični zakonik Crne Gore"/>
      </references>
    </meta>
    <body>
      <chapter eId="chap_14">
        <num>GLAVA ČETRNAESTA</num>
        <heading>KRIVIČNA DJELA PROTIV ŽIVOTA I TIJELA</heading>
        <section eId="art_152">
          <num>Član 152</num>
          <heading>Učestvovanje u tuči</heading>
          <paragraph eId="art_152_st_1">
            <num>st. 1</num>
            <content>
              <p>Ko drugog lako tjelesno povrijedi ili mu zdravlje lako naruši, kazniće se novčanom kaznom ili zatvorom do jedne godine.</p>
            </content>
          </paragraph>
          <paragraph eId="art_152_st_2">
            <num>st. 2</num>
            <content>
              <p>Ako je takva povreda nanesena oružjem, opasnim oruđem ili drugim sredstvom podobnim da tijelo teško povrijedi ili zdravlje teško naruši, učinilac će se kazniti zatvorom do tri godine.</p>
            </content>
          </paragraph>
          <paragraph eId="art_152_st_3">
            <num>st. 3</num>
            <content>
              <p>Sud može učiniocu djela iz stava 2 ovog člana izreći sudsku opomenu, ako je učinilac bio izazvan nepristojnim ili grubim ponašanjem oštećenog.</p>
            </content>
          </paragraph>
          <paragraph eId="art_152_st_4">
            <num>st. 4</num>
            <content>
              <p>Gonjenje za djelo iz stava 1 ovog člana preduzima se po privatnoj tužbi.</p>
            </content>
          </paragraph>
        </section>
      </chapter>
      <chapter eId="chap_18">
        <num>GLAVA OSAMNAESTA</num>
        <heading>ISTRAGA</heading>
        <section eId="art_274" href="/krivicni#art_274">
          <num>Član 274</num>
          <heading>Svrha istrage</heading>
          <paragraph eId="art_274_st_1">
            <num>st. 1</num>
            <content>
              <p>Istraga se sprovodi na osnovu naredbe o sprovođenju istrage protiv određenog lica kad postoji osnovana sumnja da je učinilo krivično djelo.</p>
            </content>
          </paragraph>
          <paragraph eId="art_274_st_2">
            <num>st. 2</num>
            <content>
              <p>U istrazi će se prikupiti dokazi i podaci koji su potrebni državnom tužiocu za donošenje odluke o podizanju optužnice ili o obustavi istrage i dokazi za koje postoji opasnost da se neće moći ponoviti na glavnom pretresu ili bi njihovo izvođenje bilo otežano, kao i drugi dokazi koji mogu biti od koristi za postupak, a čije se izvođenje, s obzirom na okolnosti slučaja, pokazuje cjelishodnim.</p>
            </content>
          </paragraph>
        </section>
      </chapter>
    </body>
  </act>
</akomaNtoso>
"""

prompt = ChatPromptTemplate.from_messages([
    ("system",
     """You are an expert in Akoma Ntoso 3.0 XML for legal documents, as defined by the standard at http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17. Your task is to convert the provided legal text from Montenegro into a valid Akoma Ntoso 3.0 XML document with the structure <akomaNtoso><act>. The output must be syntactically correct, comply with the Akoma Ntoso 3.0 schema, and contain no comments, code blocks, or extraneous text—only pure XML.

### General Requirements
- **Input Context**: The legal text is from Montenegro and may include sections (Glava), articles (Član), paragraphs (stav), and items (tačka). If chapter titles or context are missing, infer them logically based on the content (e.g., use the article's heading as a clue for the chapter's context).
- **Output Format**: Produce only valid XML, starting with the XML declaration and namespace attributes:
  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <akomaNtoso xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17 ../schemas/akomantoso30.xsd"
              xmlns="http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17">
  ```
- **Root Element**: Use `<act contains="originalVersion">` as the root element within `<akomaNtoso>`.

### Metadata Structure
- In the `<meta>` section, include:
  - **FRBRWork**:
    - `<FRBRthis value="/{law_id}/main"/>`
    - `<FRBRuri value="/{law_id}"/>`
    - `<FRBRdate date="2025-08-31" name="publication"/>`
    - `<FRBRauthor href="#parliament"/>`
    - `<FRBRcountry value="ME"/>` (for Montenegro)
  - **FRBRExpression**:
    - `<FRBRthis value="/{law_id}/main/2025-08-31"/>`
    - `<FRBRuri value="/{law_id}/2025-08-31"/>`
    - `<FRBRdate date="2025-08-31" name="publication"/>`
    - `<FRBRauthor href="#parliament"/>`
  - **FRBRManifestation**:
    - `<FRBRthis value="/{law_id}/main/2025-08-31/xml"/>`
    - `<FRBRuri value="/{law_id}/2025-08-31/xml"/>`
    - `<FRBRdate date="2025-08-31" name="publication"/>`
    - `<FRBRauthor href="#government"/>`
  - **References**:
    - Include `<TLCOrganization eId="parliament" href="/ontology/organization/me/parliament" showAs="Skupština Crne Gore"/>`.
    - Include `<TLCConcept eId="{law_id}" href="/{law_id}" showAs="{law_name}"/>`.
  - Wrap these in `<identification source="#government">` and `<references source="#government">`.

### Body Structure
- Structure the `<body>` hierarchically:
  - **Chapters** (`<chapter>`): For each Glava (e.g., "GLAVA ČETRNAESTA"), create a `<chapter>` element with:
    - `eId="chap_X"` (e.g., `chap_14` for Glava Četrnaesta).
    - `<num>` containing the Glava text (e.g., `<num>GLAVA ČETRNAESTA</num>`).
    - `<heading>` with the chapter title (e.g., `<heading>KRIVIČNA DJELA PROTIV ŽIVOTA I TIJELA</heading>`).
    - Do NOT include an `href` attribute.
  - **Sections** (`<section>`): For each Član (e.g., "Član 152"), create a `<section>` element with:
    - `eId="art_X"` (e.g., `art_152`).
    - `<num>` containing the article number (e.g., `<num>Član 152</num>`).
    - `<heading>` with the article title (e.g., `<heading>Učestvovanje u tuči</heading>`).
    - Do NOT include an `href` attribute.
  - **Paragraphs** (`<paragraph>`): For each stav (e.g., "st. 1"), create a `<paragraph>` element with:
    - `eId="art_X_st_Y"` (e.g., `art_152_st_1`).
    - `<num>` containing the stav number (e.g., `<num>st. 1</num>`).
    - `<content><p>` for the text content.
    - Do NOT include an `href` attribute.
  - **Items** (`<item>`): For each tačka (e.g., "1)", "2)"), create an `<item>` element with:
    - `eId="art_X_st_Y_t_Z"` (e.g., `art_48_st_2_t_1`).
    - `<num>` containing the tačka number (e.g., `<num>1)</num>`).
    - `<content><p>` for the text content.
    - Do NOT include an `href` attribute.

### Reference Handling
- For any mentions of član, stav, or tačka within the text (e.g., "član 54", "čl. 4 stav 2", "stava 1 ovog člana", "tač. 2 do 4 ovog stava"), wrap them in `<ref>` tags:
  - Use **absolute href paths**:
    - For references within the same law, use `href="/{law_id}#appropriate_eId"` (e.g., `/krivicni#art_54`, `/krivicni#art_4_st_2`, `/krivicni#art_X_st_Y_t_Z`).
    - For references explicitly mentioning Zakonik o krivičnom postupku (e.g., "član 123 Zakonika o krivičnom postupku"), use `href="/zkp#art_X"` (e.g., `/zkp#art_123`).
  - The `appropriate_eId` must match the referenced element’s `eId` (e.g., `art_54`, `art_4_st_2`, `art_X_st_Y_t_Z`).
  - Preserve the original text in the `<ref>` tag (e.g., `<ref href="/krivicni#art_152_st_2">stava 2 ovog člana</ref>`).
  - For ranges (e.g., "tač. 2 do 4"), create separate `<ref>` tags for each tačka (e.g., `<ref href="/krivicni#art_X_st_Y_t_2">tač. 2</ref>`, `<ref href="/krivicni#art_X_st_Y_t_3">tač. 3</ref>`, `<ref href="/krivicni#art_X_st_Y_t_4">tač. 4</ref>`).
- **Law ID Rules**:
  - Use only `{law_id}` (either `krivicni` or `zkp`) as provided for the current document.
  - Use `zkp` for explicit references to Zakonik o krivičnom postupku.
  - Do NOT invent other law IDs (e.g., `/parsed_krivicni_zakon`, `/law_id`).

### Text Processing
- **Spelling Corrections**: Fix common errors, such as "KRIVICNOG DJELA" to "KRIVIČNOG DJELA".
- **XML Escaping**: Ensure special characters are escaped (e.g., `&` to `&amp;`, `<` to `&lt;`).
- **Semantic Integrity**: Maintain the meaning and structure of the text, ensuring no content is omitted or altered.
- **Avoid Duplicates**: Do not create duplicate references or elements for the same član, stav, or tačka.

### Example Input and Output
- The example input text and expected Akoma Ntoso XML are provided in {example_law_text} and {example_akoma_ntoso}. Use these as a guide, ensuring all references (e.g., "stava 2 ovog člana") are wrapped in `<ref>` tags with absolute `href` paths and tačka are structured as `<item>` elements.

### Input Processing
Convert the following legal text to Akoma Ntoso XML, ensuring:
- All structural elements (`<chapter>`, `<section>`, `<paragraph>`, `<item>`) use only `eId` for identification, not `href`.
- All references to član, stav, or tačka in the text are wrapped in `<ref>` tags with absolute `href` paths using `{law_id}` or `zkp`.
- Tačka (e.g., "1)", "2)") are extracted as `<item>` elements with correct `eId` and `<num>`.
- The output is valid XML, compliant with Akoma Ntoso 3.0, with no comments or code blocks.
""".format(example_law_text=example_law_text, example_akoma_ntoso=example_akoma_ntoso, law_id="{law_id}", law_name="{law_name}")
    ),
    ("user", "{input}")
])

def clean_xml_response(xml_string: str) -> str:
    """Remove code block markers and extra whitespace from LLM response."""
    xml_string = re.sub(r'^```xml\s*\n|```$', '', xml_string, flags=re.MULTILINE)
    xml_string = re.sub(r'^```|```$', '', xml_string, flags=re.MULTILINE)
    return xml_string

def validate_xml(xml_string: str) -> bool:
    """Validate if the generated XML is well-formed and Akoma Ntoso compliant."""
    try:
        tree = ET.fromstring(xml_string)
        if tree.tag != '{http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17}akomaNtoso':
            print("XML does not have <akomaNtoso> as root")
            return False
        if not tree.find('.//{http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17}act'):
            print("XML does not contain <act> element")
            return False
        return True
    except ET.ParseError as e:
        print(f"Invalid XML generated: {e}")
        return False

def convert_law(text: str, file_path: pathlib.Path, law_id: str, law_name: str):
    """Convert law text to Akoma Ntoso XML and save it."""
    try:
        chain = prompt | llm
        result = chain.invoke({"input": text, "law_id": law_id, "law_name": law_name})
        xml_content = clean_xml_response(result.content)

        if not validate_xml(xml_content):
            print(f"Skipping {file_path}: Generated XML is not well-formed or not Akoma Ntoso compliant")
            return

        output_dir = pathlib.Path("./zakon/xml")
        output_dir.mkdir(parents=True, exist_ok=True)
        output_path = output_dir / f"{file_path.stem}.xml"
        output_path.write_text(xml_content, encoding="utf-8")
        print(f"[✓] Saved: {output_path}")
    except Exception as e:
        print(f"Error processing {file_path}: {e}")

def main():
    """Process all .txt files in the input directory."""
    parser = argparse.ArgumentParser(description="Convert law texts to Akoma Ntoso XML")
    parser.add_argument('--input-dir', type=str, default="./zakon/text", help="Input directory with .txt files")
    args = parser.parse_args()

    folder_path = pathlib.Path(args.input_dir)
    if not folder_path.exists():
        print(f"[!] Folder does not exist: {folder_path}")
        return

    txt_files = list(folder_path.rglob("*.txt"))
    if not txt_files:
        print(f"[!] No .txt files found in {folder_path}")
        return

    law_id_map = {
        "krivicni_zakon": ("krivicni", "Krivični zakonik Crne Gore"),
        "zakonik_o_krivicnom_postupku": ("zkp", "Zakonik o krivičnom postupku Crne Gore")
    }

    for file_path in txt_files:
        print(f"Processing: {file_path}")
        text = file_path.read_text(encoding="utf-8")
        base_name = file_path.stem.lower()
        law_id, law_name = law_id_map.get(base_name, (base_name, base_name.title()))
        convert_law(text, file_path, law_id, law_name)

if __name__ == "__main__":
    main()