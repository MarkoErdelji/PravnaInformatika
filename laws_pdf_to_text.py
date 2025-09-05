import os
import re
import json
from collections import defaultdict
from copy import deepcopy
from bs4 import BeautifulSoup


def get_included_text(structure, refs):
    result = []
    for art, data in structure.items():
        if art not in refs:
            continue
        out = []
        if data['header']:
            out.append(data['header'])
        if data['title']:
            out.append(data['title'])
        out.append(f"Član {art}")
        for st, text in data['stavs'].items():
            out.append(f"({st}) {text}" if st != "0" else text)
        result.append("\n".join(out))
    return "\n\n".join(result)


def expand_refs(structure, initial_refs):
    refs = deepcopy(initial_refs)
    pattern = r'\bčl(?:an|ana|anu|anom)?\.?\s*(\d+[a-z]?)\b' \
              r'(?:\s*ovog zakonika)?' \
              r'(?:\s*,?\s*(?:\((\d+)\)|st\.\s*(\d+)|(\d+)\.))?' \
              r'(?:\s*,?\s*(?:tač(?:ka|ke|ku|kom)?|t)\.?\s*(\d+))?'
    changed = True
    processed = set()

    while changed:
        changed = False
        current_text = get_included_text(structure, refs)
        for match in re.finditer(pattern, current_text, re.IGNORECASE):
            art = match.group(1).strip() if match.group(1) else None
            st = match.group(2) or match.group(3) or match.group(4) or '1'
            t = match.group(5)
            key = (art, st, t)
            if key in processed:
                continue
            processed.add(key)
            if art and art not in refs:
                refs[art] = defaultdict(list)
                changed = True
            if art and st:
                if st not in refs[art]:
                    refs[art][st] = []
                    changed = True
                if t and t not in refs[art][st]:
                    refs[art][st].append(t)
                    changed = True
                elif not t and None not in refs[art][st]:
                    refs[art][st].append(None)
                    changed = True
    return refs


def parse_html_file(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        soup = BeautifulSoup(f, 'html.parser')

    articles = {}
    current_article = None
    current_title = None
    current_header = None
    current_content = []

    def flush_article():
        nonlocal current_article, current_title, current_header, current_content
        if not current_article:
            return
        stavs = defaultdict(str)
        buffer = []
        stav_num = "0"
        for line in current_content:
            line = line.strip()
            if not line:
                continue
            m = re.match(r'^\((\d+)\)', line)
            if m:
                if buffer:
                    stavs[stav_num] = " ".join(buffer).strip()
                stav_num = m.group(1)
                buffer = [line[m.end():].strip()]
            else:
                buffer.append(line)
        if buffer:
            stavs[stav_num] = " ".join(buffer).strip()
        articles[current_article] = {
            'title': current_title or '',
            'stavs': dict(stavs),
            'header': current_header or ''
        }
        current_article, current_title, current_header, current_content = None, None, None, []

    for p in soup.find_all('p'):
        text = p.get_text(strip=True)
        if not text:
            continue
        if "glava" in p.get("class", [""])[0].lower():
            current_header = text
        elif "naslov-clana" in p.get("class", [""])[0].lower():
            current_title = text
        elif "clan" in p.get("class", [""])[0].lower():
            flush_article()
            m = re.search(r'Član\s+(\d+[a-z]?)', text)
            if m:
                current_article = m.group(1)
        else:
            if current_article:
                current_content.append(text)

    flush_article()
    return articles


def extract_refs_from_judgments(judgment_folder):
    refs = {'krivicni': defaultdict(lambda: defaultdict(list)), 'zkp': defaultdict(lambda: defaultdict(list))}
    pattern = r'art_(\d+[a-z]?)(?:_st_(\d+))?(?:_t_(\d+))?'
    if not os.path.exists(judgment_folder):
        return refs
    for filename in os.listdir(judgment_folder):
        if not filename.endswith('.xml'):
            continue
        path = os.path.join(judgment_folder, filename)
        with open(path, 'r', encoding='utf-8') as f:
            soup = BeautifulSoup(f, 'xml')
        for ref in soup.find_all('ref'):
            href = ref.get('href', '')
            if not href:
                continue
            href = href.replace('/', '#')
            parts = [p for p in href.split('#') if p]
            if len(parts) < 2:
                continue
            base = parts[0].lower()
            if base == 'krivicni':
                law_id = 'krivicni'
            elif base == 'zkp':
                law_id = 'zkp'
            else:
                continue
            m = re.match(pattern, parts[1])
            if m:
                art = m.group(1)
                st = m.group(2) or '1'
                t = m.group(3)
                refs[law_id][art][st].append(t if t else None)
    return refs


def process_legal_documents(input_folder, judgment_folder, out_krivicni, out_zkp, out_refs):
    refs = extract_refs_from_judgments(judgment_folder)
    for filename in os.listdir(input_folder):
        if not filename.endswith('.html'):
            continue
        path = os.path.join(input_folder, filename)
        law_id = 'krivicni' if 'krivicni_zakon' in filename.lower() else 'zkp'
        structure = parse_html_file(path)
        expanded_refs = expand_refs(structure, refs.get(law_id, {}))
        refs[law_id] = expanded_refs
        output_text = get_included_text(structure, expanded_refs)
        out_file = out_krivicni if law_id == 'krivicni' else out_zkp
        with open(out_file, 'w', encoding='utf-8') as f:
            f.write(f"File: {filename}\n\n{output_text}\n\n" + "="*50 + "\n")

    with open(out_refs, 'w', encoding='utf-8') as f:
        json.dump(refs, f, ensure_ascii=False, indent=4)


if __name__ == "__main__":
    input_folder = "./zakon/html/"
    judgment_folder = "./judgingapp/xml/"
    out_krivicni = "./zakon/text/parsed_krivicni_zakon.txt"
    out_zkp = "./zakon/text/parsed_zakonik_o_krivicnom_postupku.txt"
    out_refs = "legal_references.json"
    process_legal_documents(input_folder, judgment_folder, out_krivicni, out_zkp, out_refs)
    print("Processing complete.")
