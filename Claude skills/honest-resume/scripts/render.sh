#!/bin/bash
# Render resume.html to PDF with a headless Chromium browser, then print
# the page count and the text an applicant tracking system would extract.
# Usage: render.sh <path/to/resume.html> [output.pdf]
set -euo pipefail

html="$1"
dir="$(cd "$(dirname "$html")" && pwd)"
pdf="${2:-$dir/resume.pdf}"
here="$(cd "$(dirname "$0")" && pwd)"

browser=""
for c in \
  "${CHROME:-}" \
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  "/Applications/Chromium.app/Contents/MacOS/Chromium" \
  "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" \
  "$(command -v google-chrome 2>/dev/null || true)" \
  "$(command -v chromium 2>/dev/null || true)" \
  "$(command -v chromium-browser 2>/dev/null || true)" \
  "$(command -v microsoft-edge 2>/dev/null || true)" \
  "/c/Program Files/Google/Chrome/Application/chrome.exe" \
  "/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe"; do
  if [ -n "$c" ] && [ -x "$c" ]; then browser="$c"; break; fi
done

if [ -z "$browser" ]; then
  echo "No Chrome, Chromium or Edge found. Set CHROME=/path/to/browser, or open"
  echo "$html in a browser and use Print > Save as PDF."
  exit 1
fi

"$browser" --headless=new --disable-gpu --no-pdf-header-footer \
  --print-to-pdf="$pdf" "file://$dir/$(basename "$html")" >/dev/null 2>&1

echo "PDF: $pdf"
python3 "$here/pdf_check.py" "$pdf"
