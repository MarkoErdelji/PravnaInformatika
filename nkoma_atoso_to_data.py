import os
import csv
from pathlib import Path
from lxml import etree
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate
import json
import re
import logging

# Podešavanje logovanja za dijagnostiku
logging.basicConfig(filename='parsiranje_log.txt', level=logging.ERROR, format='%(asctime)s - %(levelname)s - %(message)s')

# Postavljanje OpenAI API ključa
os.environ["OPENAI_API_KEY"] = "PLACEHOLDER"

# Definisanje foldera i izlaznih fajlova
xml_folder = Path("./presude/xml")
metapodaci_csv = Path("./presude/presude_metapodaci.csv")
cinjenice_csv = Path("./presude/presude_cinjenice.csv")

# Definisanje imenskog prostora
ns = {"akn": "http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17"}

# Definisanje zaglavlja za metapodatke
metapodaci_zaglavlja = [
    "#id", "Sud", "Poslovni broj", "Sudija", "Tužilac", "Okrivljeni",
    "Krivično delo", "Telesne povrede", "Vrsta presude", "Primijenjeni propisi",
    "Datum presude", "Oštećeni", "Kazna", "Mesto događaja", "Datum događaja",
    "Povreda mere zaštite", "Sredstvo izvršenja", "Troškovi postupka"
]

# Definisanje zaglavlja za činjenice
cinjenice_zaglavlja = [
    "#id", "Priroda nasilja", "Odnos oštećenog", "Tip povreda",
    "Sredstvo izvršenja", "Povreda mere", "Mesto događaja", "Datum događaja",
    "Status okrivljenog", "Oštećeni", "Starost okrivljenog", "Starost oštećenog",
    "Prethodni incidenti", "Alkohol ili droge", "Prisustvo dece"
]

# Funkcija za bezbedno izvlačenje atributa
def safe_get(element, attr):
    try:
        return element.get(attr, "") if element is not None else ""
    except Exception as e:
        logging.error(f"Greška pri dohvatanju atributa {attr}: {e}")
        return ""

# Funkcija za bezbedno izvlačenje teksta
def safe_text(element):
    try:
        return element.text.strip() if element is not None and element.text else ""
    except Exception as e:
        logging.error(f"Greška pri dohvatanju teksta: {e}")
        return ""

# Funkcija za izvlačenje metapodataka i teksta iz XML-a
def extract_metadata_and_text(xml_path):
    try:
        tree = etree.parse(xml_path)
        root = tree.getroot()

        meta = {}
        meta['#id'] = str(xml_path.stem)
        meta['Sud'] = safe_text(root.find(".//akn:FRBRauthor", namespaces=ns))
        meta['Poslovni broj'] = safe_text(root.find(".//akn:FRBRtitle", namespaces=ns))
        meta['Datum presude'] = safe_get(root.find(".//akn:FRBRdate", namespaces=ns), "date")

        # Izvlačenje sudija
        sudije = []
        for person in root.findall(".//akn:TLCPerson", namespaces=ns):
            show_as = safe_get(person, "showAs").lower()
            if "sudija" in show_as or "sudi" in show_as:
                sudije.append(safe_get(person, "showAs"))
        for role in root.findall(".//akn:TLCRole", namespaces=ns):
            if "sudija" in safe_get(role, "showAs").lower():
                sudije.append(safe_get(role, "showAs"))
        meta['Sudija'] = ", ".join(set(sudije)) if sudije else ""

        # Izvlačenje tužioca
        tuzilac_org = root.find(".//akn:organization[@refersTo='#odt']", namespaces=ns)
        meta['Tužilac'] = safe_get(tuzilac_org, "showAs") or "Osnovno državno tužilaštvo"

        # Izvlačenje okrivljenog
        okrivljeni = []
        for person in root.findall(".//akn:TLCPerson", namespaces=ns):
            if safe_get(person, "eId") in [safe_get(p, "refersTo").lstrip("#") for p in root.findall(".//akn:party[@as='#defendant']", namespaces=ns)]:
                okrivljeni.append(safe_get(person, "showAs"))
        meta['Okrivljeni'] = ", ".join(set(okrivljeni)) if okrivljeni else ""

        # Izvlačenje oštećenog
        osteceni = []
        for person in root.findall(".//akn:TLCPerson", namespaces=ns):
            if safe_get(person, "eId") in [safe_get(p, "refersTo").lstrip("#") for p in root.findall(".//akn:party[@as='#victim']", namespaces=ns)]:
                osteceni.append(safe_get(person, "showAs"))
        meta['Oštećeni'] = ", ".join(set(osteceni)) if osteceni else ""

        # Izvlačenje teksta sudskog tela
        judgment_body = root.find(".//akn:judgmentBody", namespaces=ns)
        full_text = etree.tostring(judgment_body, method="text", encoding="unicode").strip() if judgment_body is not None else ""

        return meta, full_text
    except Exception as e:
        logging.error(f"Greška pri parsiranju {xml_path}: {e}")
        print(f"Greška pri parsiranju {xml_path}: {e}")
        return {}, ""

# Funkcija za kreiranje prompta sa eksplicitnom JSON šemom
def build_prompt():
    return ChatPromptTemplate.from_messages([
        ("system", """Ti si ekspert za pravne dokumente na srpskom jeziku. Analiziraj tekst sudske presude i izdvoji sledeće informacije u JSON formatu, koristeći crnogorski Krivični zakonik (Član 220). Ako neka informacija nije prisutna, vrati praznu vrednost (''). Vrati samo validan JSON objekat prema sledećoj šemi:

        ```json
        "Krivično delo": "string", // npr. 'cl. 220 st. 1', koristi 'cl.' i 'st.'
        "Telesne povrede": "string", // npr. 'lake', 'teške', 'lake,teške'
        "Vrsta presude": "string", // npr. 'osuđujuća', 'uslovna osuda', 'odbijanje optužbe', 'rešenje o pritvoru'
        "Primijenjeni propisi": "string", // npr. 'cl. 220 st. 1, cl. 42 st. 1 KZ, cl. 374 ZKP', koristi 'cl.' i 'st.'
        "Kazna": "string", // npr. 'kazna zatvora u trajanju od 6 mjeseci'
        "Mesto događaja": "string", // npr. 'Podgorica, ulica Mitra Bakića br. 154'
        "Datum događaja": "string", // npr. '2023-01-24'
        "Povreda mere zaštite": "string", // 'Da' ili 'Ne'
        "Sredstvo izvršenja": "string", // npr. 'pesnica, sjekira'
        "Troškovi postupka": "string", // npr. '90,50 €'
        "Priroda nasilja": "string", // npr. 'grubo nasilje, prijetnja'
        "Odnos oštećenog": "string", // npr. 'supruga, majka'
        "Status okrivljenog": "string", // npr. 'nezaposlen, oženjen, ranije osuđivan'
        "Starost okrivljenog": "string", // npr. '45 godina'
        "Starost oštećenog": "string", // npr. '38 godina'
        "Prethodni incidenti": "string", // npr. 'osuđivan presudom K.br. 850/05'
        "Alkohol ili droge": "string", // 'Da' ili 'Ne'
        "Prisustvo dece": "string" // 'Da' ili 'Ne'
        ```"""),
                ("user", """Iz sledećeg teksta sudske presude, izdvoji tražene informacije u JSON formatu prema datoj šemi:

        Presuda:
        {input}
        """)
            ])

# Funkcija za čišćenje JSON odgovora
def clean_response(text):
    text = text.strip()
    if text.startswith("```json"):
        text = text[len("```json"):].strip()
    if text.endswith("```"):
        text = text[:-len("```")].strip()
    return text

# Funkcija za obradu jednog slučaja
def process_case(xml_path, llm, prompt):
    meta, text = extract_metadata_and_text(xml_path)
    if not text or not meta:
        logging.warning(f"Preskočen {xml_path.name} zbog praznog teksta ili metapodataka.")
        return None, None

    chain = prompt | llm
    try:
        result = chain.invoke({"input": text})
        parsed = json.loads(clean_response(result.content))
    except json.JSONDecodeError as e:
        logging.error(f"Nevalidan JSON za {xml_path.name}: {e}")
        print(f"GREŠKA: JSON nevalidan za {xml_path.name}")
        parsed = {}

    # Standardizacija formata
    if parsed.get("Krivično delo"):
        parsed["Krivično delo"] = parsed["Krivično delo"].replace("čl.", "cl.").replace("stav", "st.")
    if parsed.get("Primijenjeni propisi"):
        parsed["Primijenjeni propisi"] = parsed["Primijenjeni propisi"].replace("čl.", "cl.").replace("stav", "st.")
    if parsed.get("Telesne povrede"):
        injuries = parsed["Telesne povrede"].lower()
        if "lake" in injuries and "teške" in injuries:
            parsed["Telesne povrede"] = "lake,teške"
        elif "lake" in injuries:
            parsed["Telesne povrede"] = "lake"
        elif "teške" in injuries:
            parsed["Telesne povrede"] = "teške"
        else:
            parsed["Telesne povrede"] = ""
    for field in ["Povreda mere zaštite", "Alkohol ili droge", "Prisustvo dece"]:
        if parsed.get(field):
            parsed[field] = "Da" if parsed[field].lower() in ["da", "yes", "prisutno", "true"] else "Ne"

    # Podela na metapodatke i činjenice
    metapodaci = {
        "#id": meta.get("#id", ""),
        "Sud": meta.get("Sud", ""),
        "Poslovni broj": meta.get("Poslovni broj", ""),
        "Sudija": meta.get("Sudija", ""),
        "Tužilac": meta.get("Tužilac", ""),
        "Okrivljeni": meta.get("Okrivljeni", ""),
        "Oštećeni": meta.get("Oštećeni", ""),
        "Krivično delo": parsed.get("Krivično delo", ""),
        "Telesne povrede": parsed.get("Telesne povrede", ""),
        "Vrsta presude": parsed.get("Vrsta presude", ""),
        "Primijenjeni propisi": parsed.get("Primijenjeni propisi", ""),
        "Datum presude": meta.get("Datum presude", ""),
        "Kazna": parsed.get("Kazna", ""),
        "Mesto događaja": parsed.get("Mesto događaja", ""),
        "Datum događaja": parsed.get("Datum događaja", ""),
        "Povreda mere zaštite": parsed.get("Povreda mere zaštite", ""),
        "Sredstvo izvršenja": parsed.get("Sredstvo izvršenja", ""),
        "Troškovi postupka": parsed.get("Troškovi postupka", "")
    }

    cinjenice = {
        "#id": meta.get("#id", ""),
        "Priroda nasilja": parsed.get("Priroda nasilja", ""),
        "Odnos oštećenog": parsed.get("Odnos oštećenog", ""),
        "Tip povreda": parsed.get("Telesne povrede", ""),
        "Sredstvo izvršenja": parsed.get("Sredstvo izvršenja", ""),
        "Povreda mere": parsed.get("Povreda mere zaštite", ""),
        "Mesto događaja": parsed.get("Mesto događaja", ""),
        "Datum događaja": parsed.get("Datum događaja", ""),
        "Status okrivljenog": parsed.get("Status okrivljenog", ""),
        "Oštećeni": meta.get("Oštećeni", ""),
        "Starost okrivljenog": parsed.get("Starost okrivljenog", ""),
        "Starost oštećenog": parsed.get("Starost oštećenog", ""),
        "Prethodni incidenti": parsed.get("Prethodni incidenti", ""),
        "Alkohol ili droge": parsed.get("Alkohol ili droge", ""),
        "Prisustvo dece": parsed.get("Prisustvo dece", "")
    }

    return metapodaci, cinjenice

# Glavna funkcija za obradu svih fajlova
def run_pipeline():
    llm = ChatOpenAI(model="gpt-4o", temperature=0)
    prompt = build_prompt()

    with open(metapodaci_csv, "w", encoding="utf-8", newline="") as meta_file, \
         open(cinjenice_csv, "w", encoding="utf-8", newline="") as cin_file:
        meta_writer = csv.DictWriter(meta_file, fieldnames=metapodaci_zaglavlja, delimiter=";")
        cin_writer = csv.DictWriter(cin_file, fieldnames=cinjenice_zaglavlja, delimiter=";")
        meta_writer.writeheader()
        cin_writer.writeheader()

        fajl_id = 0
        for xml_file in xml_folder.glob("*.xml"):
            print(f"Obrada: {xml_file.name}")
            metapodaci, cinjenice = process_case(xml_file, llm, prompt)
            if metapodaci and cinjenice:
                meta_writer.writerow(metapodaci)
                cin_writer.writerow(cinjenice)
                fajl_id += 1
            else:
                print(f"Preskočen {xml_file.name} zbog greške.")

if __name__ == "__main__":
    run_pipeline()