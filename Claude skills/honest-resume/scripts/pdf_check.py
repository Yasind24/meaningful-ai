"""Print a PDF's page count and extracted text (roughly what an ATS reads).

Tries pypdf, then the pdftotext command, then macOS PDFKit via Swift.
"""
import shutil
import subprocess
import sys
import tempfile


def with_pypdf(path):
    from pypdf import PdfReader
    reader = PdfReader(path)
    return len(reader.pages), "\n".join(p.extract_text() or "" for p in reader.pages)


def with_pdftotext(path):
    if not shutil.which("pdftotext"):
        raise RuntimeError
    text = subprocess.run(["pdftotext", "-layout", path, "-"], capture_output=True, text=True, check=True).stdout
    pages = text.count("\f") or 1
    return pages, text


def with_swift(path):
    if not shutil.which("swift"):
        raise RuntimeError
    code = (
        "import Foundation\nimport PDFKit\n"
        "let d = PDFDocument(url: URL(fileURLWithPath: CommandLine.arguments[1]))!\n"
        "print(d.pageCount)\nprint(d.string ?? \"\")\n"
    )
    with tempfile.NamedTemporaryFile("w", suffix=".swift", delete=False) as f:
        f.write(code)
    out = subprocess.run(["swift", f.name, path], capture_output=True, text=True, check=True).stdout
    first, _, rest = out.partition("\n")
    return int(first), rest


def main():
    path = sys.argv[1]
    for reader in (with_pypdf, with_pdftotext, with_swift):
        try:
            pages, text = reader(path)
            break
        except Exception:
            continue
    else:
        print("Could not extract text. Install pypdf (pip install pypdf) or poppler (pdftotext).")
        sys.exit(1)
    print(f"Pages: {pages}")
    print("----- extracted text -----")
    print(text)


if __name__ == "__main__":
    main()
