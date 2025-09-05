import fitz  # PyMuPDF
from pathlib import Path

def extract_text_until_keywords(pdf_path: Path, keywords=None) -> str:
    if keywords is None:
        keywords = [
            "obrazlozenje",
            "obrazloženje",
            "o b r a z l o ž e nj e",
            "o b r a z l o ž e n j e"
        ]

    doc = fitz.open(str(pdf_path))
    accumulated_text = []

    for page in doc:
        page_text = page.get_text()
        page_text_lower = page_text.lower()

        found_index = -1
        for kw in keywords:
            idx = page_text_lower.find(kw)
            if idx != -1:
                found_index = idx
                break

        if found_index != -1:
            accumulated_text.append(page_text[:found_index])
            break
        else:
            accumulated_text.append(page_text)

    doc.close()
    return '\n'.join(accumulated_text)

def batch_process_pdfs(input_dir: Path, output_dir: Path, skip_existing=True):
    output_dir.mkdir(parents=True, exist_ok=True)

    pdf_files = list(input_dir.rglob("*.pdf"))
    if not pdf_files:
        print("Nema PDF fajlova u ulaznom folderu.")
        return

    for pdf_file in pdf_files:
        out_file = output_dir / f"{pdf_file.stem}.txt"
        if skip_existing and out_file.exists():
            print(f"Preskačem već postojeći fajl {out_file.name}")
            continue

        print(f"Ekstrahujem iz {pdf_file.name}...")
        text = extract_text_until_keywords(pdf_file)
        if text.strip():
            out_file.write_text(text.strip(), encoding="utf-8")
            print(f"Spremljeno: {out_file.name}")
        else:
            print(f"Upozorenje: Nije ekstrahovan tekst iz {pdf_file.name}")

if __name__ == "__main__":
    import sys
    input_path = Path("./presude/pdf")
    output_path = Path("./presude/text")

    batch_process_pdfs(input_path, output_path)
