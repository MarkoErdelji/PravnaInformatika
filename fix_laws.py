import os
import argparse
import pathlib
import xml.etree.ElementTree as ET
from xml.dom import minidom

def fix_href_in_xml(file_path: pathlib.Path, output_dir: pathlib.Path) -> None:
    """
    Process an XML file to replace '/parsed_krivicni_zakon' with '/krivicni' in href attributes of <ref> tags.
    Save the modified XML to the output directory.
    """
    try:
        # Parse the XML file
        tree = ET.parse(file_path)
        root = tree.getroot()

        # Namespace for Akoma Ntoso
        namespace = "http://docs.oasis-open.org/legaldocml/ns/akn/3.0/WD17"
        ET.register_namespace("", namespace)

        # Find all <ref> tags
        ref_tags = root.findall(f".//{{{namespace}}}ref")

        # Track if any changes were made
        modified = False

        # Replace '/parsed_krivicni_zakon' with '/krivicni' in href attributes
        for ref in ref_tags:
            href = ref.get("href")
            if href and "/parsed_krivicni_zakon" in href:
                new_href = href.replace("/parsed_krivicni_zakon", "/krivicni")
                ref.set("href", new_href)
                modified = True
                print(f"Updated href in {file_path}: '{href}' -> '{new_href}'")

        if modified:
            # Ensure output directory exists
            output_dir.mkdir(parents=True, exist_ok=True)
            output_path = output_dir / file_path.name

            # Pretty-print and save the modified XML
            xml_str = minidom.parseString(ET.tostring(root, encoding="utf-8")).toprettyxml(indent="  ", encoding="utf-8").decode("utf-8")
            # Remove extra blank lines
            xml_str = "\n".join(line for line in xml_str.splitlines() if line.strip())
            with open(output_path, "w", encoding="utf-8") as f:
                f.write(xml_str)
            print(f"[✓] Saved updated XML: {output_path}")
        else:
            print(f"No changes needed in {file_path}")

    except ET.ParseError as e:
        print(f"Error parsing XML in {file_path}: {e}")
    except Exception as e:
        print(f"Error processing {file_path}: {e}")

def main():
    """Process all XML files in the input directory to fix href attributes."""
    parser = argparse.ArgumentParser(description="Replace '/parsed_krivicni_zakon' with '/krivicni' in href attributes of XML files")
    parser.add_argument('--input-dir', type=str, default="./zakon/xml", help="Input directory with XML files")
    parser.add_argument('--output-dir', type=str, default="./zakon/xml_fixed", help="Output directory for fixed XML files")
    args = parser.parse_args()

    input_dir = pathlib.Path(args.input_dir)
    output_dir = pathlib.Path(args.output_dir)

    if not input_dir.exists():
        print(f"[!] Input directory does not exist: {input_dir}")
        return

    xml_files = list(input_dir.rglob("*.xml"))
    if not xml_files:
        print(f"[!] No .xml files found in {input_dir}")
        return

    for xml_file in xml_files:
        print(f"Processing: {xml_file}")
        fix_href_in_xml(xml_file, output_dir)

if __name__ == "__main__":
    main()
