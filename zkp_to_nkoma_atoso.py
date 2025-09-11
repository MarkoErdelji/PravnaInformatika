#!/usr/bin/env python3
# parse_zkp.py
# Usage: python parse_zkp.py input.html output.xml

import re
import sys
import html
from collections import defaultdict
from bs4 import BeautifulSoup
import lxml.etree as ET

# -------------------------
# Utilities
# -------------------------
ROMAN_MAP = {
    'I':1,'II':2,'III':3,'IV':4,'V':5,'VI':6,'VII':7,'VIII':8,'IX':9,'X':10,
    'XI':11,'XII':12,'XIII':13,'XIV':14,'XV':15,'XVI':16,'XVII':17,'XVIII':18,
    'XIX':19,'XX':20,'XXI':21,'XXII':22,'XXIII':23,'XXIV':24,'XXV':25,'XXVI':26,
    'XXVII':27,'XXVIII':28,'XXIX':29,'XXX':30
}

def roman_to_int(r):
    if not r:
        return None
    r = r.strip().upper()
    return ROMAN_MAP.get(r)

def clean_text(t):
    if t is None:
        return ""
    s = t.strip()
    s = re.sub(r"\s+", " ", s)
    s = s.replace("KRIVICNOG", "KRIVIČNOG")
    return s

# -------------------------
# Reference recognition regex (ordered: most specific first)
# -------------------------
REF_RE = re.compile(r"""
(?P<art_st_tacke_list>\bčlana\s+(?P<artA>\d+)\s+st\.\s*(?P<stavA>[0-9,\s.i]+)(?:\s+tač\.\s*(?P<tackeA>[0-9,\s.i\-do]+))?(?:\s+ovog\s+zakonika)?)|  # člana N st. X,Y i Z tač. A,B
(?P<art_st_list>\bčlana\s+(?P<artC>\d+)\s+st\.\s*(?P<stavC>[0-9,\s.i]+)(?:\s+ovog\s+zakonika)?)|  # člana N st. X,Y i Z
(?P<art_st>\bčlana\s+(?P<artB>\d+)\s+stava\s+(?P<stavB>\d+)(?:\s+ovog\s+zakonika)?)|  # člana N stava M
(?P<st_tacke_list>\bstava\s+(?P<stavD>[0-9,\s.i]+)\s+tač\.\s*(?P<tackeD>[0-9,\s.i\-do]+)\s+ovog\s+člana)|  # stava X,Y i Z tač. A,B ovog člana
(?P<st_list>\bst\.\s*(?P<stavE>[0-9,\s.i]+)(?:\s+ovog\s+člana)?)|  # st. X,Y i Z (ovog člana)
(?P<stava_only>\bstava\s+(?P<stavF>\d+)\s+ovog\s+člana)|  # stava N ovog člana
(?P<art_only>\bčlana\s+(?P<artG>\d+)(?:\s+ovog\s+zakonika)?)  # člana N
""", re.IGNORECASE | re.VERBOSE)

EXISTING_REF_RE = re.compile(r'<ref\s+href="([^"]+)">(.+?)</ref>', re.IGNORECASE | re.DOTALL)

# Helper to split lists like "1, 2 i 3" into individual numbers
def split_stav_list(stav_str):
    if not stav_str:
        return []
    # Replace 'i' with ',' and split by commas or spaces
    stav_str = re.sub(r'\s*i\s*', ',', stav_str)
    stavs = re.split(r'[,\s]+', stav_str.strip())
    return [s for s in stavs if s.isdigit()]

# -------------------------
# XML building helpers
# -------------------------
def append_text_or_tail(elem, text):
    """Append text into elem: if no children -> elem.text, else last child.tail"""
    if not text:
        return
    children = list(elem)
    if not children:
        if elem.text:
            elem.text += text
        else:
            elem.text = text
    else:
        last = children[-1]
        if last.tail:
            last.tail += text
        else:
            last.tail = text

def build_mixed_p(content_elem, raw_text, current_article_eid):
    """
    Create a <p> child of content_elem and populate it with text and <ref> elements
    according to REF_RE and any existing <ref ...> present (escaped).
    """
    s = html.unescape(raw_text)
    p = ET.SubElement(content_elem, "p")
    pos = 0
    L = len(s)

    while pos < L:
        m_existing = EXISTING_REF_RE.search(s, pos)
        m_ref = REF_RE.search(s, pos)

        next_match = None
        next_type = None
        if m_existing and m_ref:
            if m_existing.start() <= m_ref.start():
                next_match = m_existing
                next_type = "existing"
            else:
                next_match = m_ref
                next_type = "generated"
        elif m_existing:
            next_match = m_existing
            next_type = "existing"
        elif m_ref:
            next_match = m_ref
            next_type = "generated"
        else:
            append_text_or_tail(p, s[pos:])
            break

        if next_match.start() > pos:
            append_text_or_tail(p, s[pos:next_match.start()])

        if next_type == "existing":
            href = next_match.group(1)
            inner = next_match.group(2)
            ref_elem = ET.SubElement(p, "ref", href=href)
            ref_elem.text = inner
            pos = next_match.end()
        else:
            m = next_match
            full = m.group(0)
            hrefs = []

            # Handle each reference pattern
            if m.group("artA"):  # člana N st. X,Y i Z tač. A,B
                art = m.group("artA")
                stav_list = split_stav_list(m.group("stavA"))
                for stav in stav_list:
                    hrefs.append((f"/zkp#art_{art}_st_{stav}", f"člana {art} st. {stav}"))
            elif m.group("artC"):  # člana N st. X,Y i Z
                art = m.group("artC")
                stav_list = split_stav_list(m.group("stavC"))
                for stav in stav_list:
                    hrefs.append((f"/zkp#art_{art}_st_{stav}", f"člana {art} st. {stav}"))
            elif m.group("artB"):  # člana N stava M
                art = m.group("artB")
                stav = m.group("stavB")
                hrefs.append((f"/zkp#art_{art}_st_{stav}", full))
            elif m.group("stavD"):  # stava X,Y i Z tač. A,B ovog člana
                stav_list = split_stav_list(m.group("stavD"))
                for stav in stav_list:
                    href = f"/zkp#{current_article_eid}_st_{stav}" if current_article_eid else f"/zkp#art_unknown_st_{stav}"
                    hrefs.append((href, f"stava {stav} ovog člana"))
            elif m.group("stavE"):  # st. X,Y i Z (ovog člana)
                stav_list = split_stav_list(m.group("stavE"))
                for stav in stav_list:
                    href = f"/zkp#{current_article_eid}_st_{stav}" if current_article_eid else f"/zkp#art_unknown_st_{stav}"
                    hrefs.append((href, f"st. {stav}"))
            elif m.group("stavF"):  # stava N ovog člana
                stav = m.group("stavF")
                href = f"/zkp#{current_article_eid}_st_{stav}" if current_article_eid else f"/zkp#art_unknown_st_{stav}"
                hrefs.append((href, full))
            elif m.group("artG"):  # člana N
                art = m.group("artG")
                hrefs.append((f"/zkp#art_{art}", full))

            # If multiple stavs, split the original text to match individual refs
            if len(hrefs) > 1:
                # Try to split the original match text to align with individual refs
                parts = re.split(r'(\s*[,i]\s*)', full)
                connectors = [p for p in parts if re.match(r'\s*[,i]\s*', p)]
                refs = [p for p in parts if not re.match(r'\s*[,i]\s*', p)]
                if len(refs) == len(hrefs):
                    for i, (href, _) in enumerate(hrefs):
                        ref_elem = ET.SubElement(p, "ref", href=href)
                        ref_elem.text = refs[i]
                        if i < len(connectors):
                            append_text_or_tail(p, connectors[i])
                else:
                    # Fallback: use constructed text
                    for i, (href, ref_text) in enumerate(hrefs):
                        ref_elem = ET.SubElement(p, "ref", href=href)
                        ref_elem.text = ref_text
                        if i < len(hrefs) - 1:
                            append_text_or_tail(p, ", " if i < len(hrefs) - 2 else " i ")
            elif hrefs:
                href, ref_text = hrefs[0]
                ref_elem = ET.SubElement(p, "ref", href=href)
                ref_elem.text = full  # Use original text for single ref
            else:
                append_text_or_tail(p, full)

            pos = m.end()

    return p

# -------------------------
# Main parser
# -------------------------
def parse_html_to_akn(html_text):
    soup = BeautifulSoup(html_text, "html.parser")
    root = ET.Element("akomaNtoso")
    act = ET.SubElement(root, "act", contains="originalVersion")
    body = ET.SubElement(act, "body")

    current_chapter = None
    current_chapter_id = None
    next_article_heading = None
    current_article = None
    art_num = None
    st_counters = defaultdict(int)

    p_elems = soup.find_all("p")
    for p in p_elems:
        raw = p.get_text()
        text = clean_text(raw)
        if not text:
            continue
        cls_list = p.get("class") or []
        cls = " ".join(cls_list)

        m_glava = re.match(r"Glava\s+([IVXLCDM]+)", text, flags=re.IGNORECASE)
        if m_glava:
            roman = m_glava.group(1).upper()
            num = roman_to_int(roman) or roman
            current_chapter_id = f"chap_{num}"
            current_chapter = ET.SubElement(body, "chapter", eId=current_chapter_id)
            num_elem = ET.SubElement(current_chapter, "num")
            num_elem.text = f"GLAVA {roman}"
            next_article_heading = None
            continue

        if current_chapter is None:
            current_chapter = ET.SubElement(body, "chapter", eId="chap_unknown")
            ET.SubElement(current_chapter, "num").text = "GLAVA NEPOZNATA"
            current_chapter_id = "chap_unknown"

        is_heading_class = any(k for k in cls_list if ("naslov" in k or "pododeljak" in k or "podglava" in k or "wyq060" in k or "wyq110" in k))
        is_upper_case = (text.isupper() and len(text.split()) <= 10)
        if is_heading_class or is_upper_case:
            next_article_heading = text
            continue

        m_clan = re.match(r"(?:Član|Clan)\s+(\d+)", text, flags=re.IGNORECASE)
        if "clan" in cls.lower() or m_clan:
            matchnum = m_clan.group(1) if m_clan else None
            if not matchnum:
                nums = re.findall(r"\d+", text)
                matchnum = nums[0] if nums else None
            if not matchnum:
                continue
            art_num = matchnum
            current_article = ET.SubElement(current_chapter, "article", eId=f"art_{art_num}")
            num_elem = ET.SubElement(current_article, "num")
            num_elem.text = text
            if next_article_heading:
                heading_elem = ET.SubElement(current_article, "heading")
                heading_elem.text = next_article_heading
                next_article_heading = None
            st_counters[art_num] = 0
            continue

        m_stav = re.match(r"\((\d+)\)\s*(.*)", text, flags=re.DOTALL)
        if m_stav and current_article is not None:
            stnum = m_stav.group(1)
            body_text = m_stav.group(2).strip()
            paragraph = ET.SubElement(current_article, "paragraph", eId=f"art_{art_num}_st_{stnum}")
            ET.SubElement(paragraph, "num").text = f"st. {stnum}"
            content = ET.SubElement(paragraph, "content")
            parts = re.split(r'(?=(?:\b\d+\)))', body_text)
            if len(parts) > 1 and re.match(r'\d+\)', parts[1].lstrip()):
                main_text = parts[0].strip()
                if main_text:
                    build_mixed_p(content, main_text, current_article_eid=f"art_{art_num}")
                items = re.findall(r'(\d+)\)\s*([^0-9\d]*(?:[^0-9]|\d(?!\)))+)', body_text, flags=re.DOTALL)
                if not items:
                    splitted = re.split(r'\d+\)\s*', body_text)[1:]
                    lst = ET.SubElement(content, "list")
                    for idx, it in enumerate(splitted, start=1):
                        it_text = it.strip(" ;.\n\t")
                        if not it_text:
                            continue
                        item_elem = ET.SubElement(lst, "item", eId=f"art_{art_num}_st_{stnum}_t_{idx}")
                        build_mixed_p(item_elem, it_text, current_article_eid=f"art_{art_num}")
                else:
                    lst = ET.SubElement(content, "list")
                    for idx, (num_marker, it_text) in enumerate(items, start=1):
                        it_text = it_text.strip(" ;.\n\t")
                        if not it_text:
                            continue
                        item_elem = ET.SubElement(lst, "item", eId=f"art_{art_num}_st_{stnum}_t_{idx}")
                        build_mixed_p(item_elem, it_text, current_article_eid=f"art_{art_num}")
            else:
                build_mixed_p(content, body_text, current_article_eid=f"art_{art_num}")
            continue

        m_item_only = re.match(r"^(\d+)\)\s*(.*)", text, flags=re.DOTALL)
        if m_item_only and current_article is not None:
            paragraphs = list(current_article.findall("paragraph"))
            if paragraphs:
                last_para = paragraphs[-1]
                content = last_para.find("content")
                lst = content.find("list")
                if lst is None:
                    lst = ET.SubElement(content, "list")
                idx = len(lst.findall("item")) + 1
                item_elem = ET.SubElement(lst, "item", eId=f"art_{art_num}_st_{last_para.get('eId').split('_')[-1]}_t_{idx}")
                build_mixed_p(item_elem, m_item_only.group(2), current_article_eid=f"art_{art_num}")
                continue
            else:
                st_counters[art_num] += 1
                stnum = st_counters[art_num]
                paragraph = ET.SubElement(current_article, "paragraph", eId=f"art_{art_num}_st_{stnum}")
                ET.SubElement(paragraph, "num").text = f"st. {stnum}"
                content = ET.SubElement(paragraph, "content")
                lst = ET.SubElement(content, "list")
                item_elem = ET.SubElement(lst, "item", eId=f"art_{art_num}_st_{stnum}_t_1")
                build_mixed_p(item_elem, m_item_only.group(2), current_article_eid=f"art_{art_num}")
                continue

        if current_article is not None:
            st_counters[art_num] += 1
            stnum = st_counters[art_num]
            paragraph = ET.SubElement(current_article, "paragraph", eId=f"art_{art_num}_st_{stnum}")
            ET.SubElement(paragraph, "num").text = f"st. {stnum}"
            content = ET.SubElement(paragraph, "content")
            build_mixed_p(content, text, current_article_eid=f"art_{art_num}")
            continue

        if current_chapter is not None and next_article_heading is None:
            existing_headings = current_chapter.findall("heading")
            if not existing_headings:
                h = ET.SubElement(current_chapter, "heading")
                h.text = text
                continue
            else:
                misc = ET.SubElement(current_chapter, "note")
                misc.text = text
                continue

    return ET.tostring(root, encoding="utf-8", pretty_print=True).decode("utf-8")

# -------------------------
# CLI
# -------------------------
if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python parse_zkp.py input.html output.xml")
        sys.exit(1)
    in_path = sys.argv[1]
    out_path = sys.argv[2]
    with open(in_path, "r", encoding="utf-8") as f:
        html_text = f.read()
    xml_out = parse_html_to_akn(html_text)
    with open(out_path, "w", encoding="utf-8") as f:
        f.write(xml_out)
    print("Saved:", out_path)
