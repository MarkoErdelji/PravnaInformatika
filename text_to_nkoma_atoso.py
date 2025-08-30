import os
import argparse
import pathlib
from langchain_core.prompts import ChatPromptTemplate
from langchain_openai import ChatOpenAI

# Direktno postavljanje API ključa (za test, bolje koristi .env)
os.environ["OPENAI_API_KEY"] = "PLACEHOLDER"

llm = ChatOpenAI(model="gpt-4o", temperature=0)

example_path = pathlib.Path("./presude/primer/example.xml")
presuda_example = example_path.read_text(encoding="utf-8") if example_path.exists() else "<judgement></judgement>"

conclusion_example = """
Na osnovu
    <ref href="/krivicni#art_220">čl. 220 st. 2 Krivičnog zakonika Crne Gore</ref>
    i
    <ref href="/krivicni#art_220">čl. 220 st. 3 Krivičnog zakonika Crne Gore</ref>
sud izriče...
"""

prompt = ChatPromptTemplate.from_messages([
    ("system",
     "Ti si ekspert za pravne dokumente i tvoj zadatak je da sudsku presudu konvertuješ u validan Akoma Ntoso 3.0 XML dokument. "
     "Struktura mora da bude tipa <judgement>. Koristi XML tagove pravilno i po standardu. "
     "Obavezno koristi <ref> tagove za članke zakona u zaključku, kao u ovom primeru:\n"
     f"{conclusion_example}\n\n"
     "Evo primera gotove presude u Akoma Ntoso XML formatu:\n"
     f"{presuda_example}\n\n"
     "Na osnovu teksta koji sledi, konvertuj u AKN XML:\n\n"
     ),
    ("user", "{input}")
])

def convert_presuda(text: str, file_path: pathlib.Path):
    chain = prompt | llm
    result = chain.invoke({"input": text})
    output_dir = pathlib.Path("./presude/xml")
    output_dir.mkdir(parents=True, exist_ok=True)
    output_path = output_dir / f"{file_path.stem}.xml"
    output_path.write_text(result.content, encoding="utf-8")
    print(f"[✓] Sačuvano: {output_path}")

def main():
    folder_path = pathlib.Path("./presude/text")
    if not folder_path.exists():
        print(f"[!] Folder ne postoji: {folder_path}")
        return

    txt_files = list(folder_path.rglob("*.txt"))
    if not txt_files:
        print(f"[!] Nema .txt fajlova u {folder_path}")
        return

    for file_path in txt_files:
        print(f"Procesiram: {file_path}")
        text = file_path.read_text(encoding="utf-8")
        convert_presuda(text, file_path)

if __name__ == "__main__":
    main()
