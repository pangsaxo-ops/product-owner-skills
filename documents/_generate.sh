#!/bin/bash
# ISO9001-style Thai official document generator with revision tracking
# md → HTML (pandoc) → PDF (Chrome headless) + docx (pandoc)
#
# Usage:
#   ./_generate.sh                                          # auto-bump minor version
#   ./_generate.sh --note "description of change"           # with custom description
#   ./_generate.sh --version "1.0" --note "First release"   # manual version + note

set -e
cd "$(dirname "$0")"

DRAFTS="../drafts"
TEMPLATE="_template.html"
REVISIONS_FILE="_revisions.json"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
DATE_TH=$(date +"%d %B %Y")
NEXT_REVIEW=$(date -v+1y +"%d %B %Y" 2>/dev/null || date -d "+1 year" +"%d %B %Y")

# --- Parse args ---
NOTE=""
FORCE_VERSION=""
while [[ $# -gt 0 ]]; do
  case $1 in
    --note) NOTE="$2"; shift 2 ;;
    --version) FORCE_VERSION="$2"; shift 2 ;;
    *) echo "Unknown arg: $1"; shift ;;
  esac
done

# --- Init revisions file if not exists ---
if [ ! -f "$REVISIONS_FILE" ]; then
  DATE_TH="$DATE_TH" python3 <<'PY' > "$REVISIONS_FILE"
import json, os
print(json.dumps({
    "current_version": "0.1",
    "history": [{
        "date": os.environ["DATE_TH"],
        "version": "0.1",
        "description": "ฉบับแรก (Initial release) — Cover page, doc control, body content",
        "by": "Product Owner"
    }]
}, indent=2, ensure_ascii=False))
PY
  IS_FIRST_RUN=1
else
  IS_FIRST_RUN=0
fi

# --- Compute new version ---
if [ -n "$FORCE_VERSION" ]; then
  NEW_VERSION="$FORCE_VERSION"
elif [ "$IS_FIRST_RUN" = "1" ]; then
  # First run — keep the initial 0.1 entry
  NEW_VERSION=$(python3 -c "import json; print(json.load(open('$REVISIONS_FILE'))['current_version'])")
else
  # Auto-bump minor version
  NEW_VERSION=$(python3 <<PY
import json
data = json.load(open("$REVISIONS_FILE"))
current = data["current_version"]
major, minor = current.split(".")
print(f"{major}.{int(minor) + 1}")
PY
)
fi

# --- If not first run and no note provided, prompt or default ---
if [ "$IS_FIRST_RUN" != "1" ]; then
  if [ -z "$NOTE" ]; then
    NOTE="Regenerated from source markdown (no note specified)"
  fi

  # --- Update revisions file with new entry ---
  NEW_VERSION="$NEW_VERSION" NOTE="$NOTE" DATE_TH="$DATE_TH" python3 <<'PY'
import json, os
data = json.load(open("_revisions.json", encoding="utf-8"))
data["current_version"] = os.environ["NEW_VERSION"]
data["history"].append({
    "date": os.environ["DATE_TH"],
    "version": os.environ["NEW_VERSION"],
    "description": os.environ["NOTE"],
    "by": "Product Owner"
})
with open("_revisions.json", "w", encoding="utf-8") as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
PY
fi

# --- Generate revision HTML rows (newest first) ---
REVISION_ROWS=$(python3 <<'PY'
import json
data = json.load(open("_revisions.json", encoding="utf-8"))
rows = []
for entry in reversed(data["history"]):
    rows.append(
        f'<tr><td>{entry["date"]}</td><td>{entry["version"]}</td>'
        f'<td>{entry["description"]}</td><td>{entry["by"]}</td></tr>'
    )
print("\n".join(rows))
PY
)

# --- Metadata (DRAFT status) ---
export DOC_ORG="DAILY FITNESS COMPANION PROJECT"
export DOC_CLASSIFICATION="DRAFT — INTERNAL USE"
export DOC_VERSION="${NEW_VERSION} DRAFT"
export DOC_STATUS="DRAFT — ยังไม่สมบูรณ์ · อาจมีการปรับแก้ตามความสามารถระบบภายหลัง"
export DOC_PROJECT="Daily Fitness Companion (Phase 1)"
export DOC_PREPARED_BY="Product Owner"
export DOC_REVIEWED_BY="—"
export DOC_APPROVED_BY="—"
export DOC_EFFECTIVE_DATE="$DATE_TH"
export DOC_NEXT_REVIEW="$NEXT_REVIEW"
export DOC_REVISION_ROWS="$REVISION_ROWS"

# --- Documents to generate: source|title|subtitle|code|type ---
# Documents in workflow order: PRD → REQ → WBS → EST → SCH → HND → SRS → Stories
DOCS=(
  "PRD.md|Product Requirements Document|Daily Fitness Companion — AI Fitness Coach + Daily Reminder|DFC-PRD-001|เอกสารกำหนดข้อกำหนดผลิตภัณฑ์"
  "REQ.md|Requirements Document|Phase 1 — Business, Functional, Non-Functional, Regulatory (with traceability)|DFC-REQ-001|เอกสารข้อกำหนดตามรูปแบบ (Requirements Catalog)"
  "WBS.md|Work Breakdown Structure|Phase 1 — Deliverable-oriented hierarchy (Level 1–4, 100% rule)|DFC-WBS-001|โครงสร้างการแบ่งงาน"
  "EST.md|Estimation Document|Phase 1 — Effort estimates per WBS element with confidence levels|DFC-EST-001|เอกสารการประมาณการ"
  "SCH.md|Schedule Framework|Phase 1 — Milestones, dependency graph, scheduling template (owner fills)|DFC-SCH-001|กรอบการวางแผนตารางเวลา"
  "HND.md|Handover Document|Phase 1 — PO/PM to Systems Analyst handoff package + system context|DFC-HND-001|เอกสารส่งมอบต่อ SA"
  "SRS.md|System Requirements Specification|Phase 1 — SA output — system-level requirements extending REQ (IEEE 830-style)|DFC-SRS-001|เอกสารข้อกำหนดระบบ (System Requirements)"
  "stories.md|User Stories & Acceptance Criteria|Phase 1 — 16 Stories with Given/When/Then AC (developer reference)|DFC-STO-001|เอกสารข้อกำหนดเชิงฟังก์ชัน (User Stories)"
)

# --- Generate one doc ---
generate_doc() {
  local source="$1"
  local title="$2"
  local subtitle="$3"
  local code="$4"
  local type="$5"

  local base="${source%.md}"
  local body_tmp="_body_${base}.html"
  local html_tmp="_${base}.html"
  local pdf_out="${base}.pdf"
  local docx_out="${base}.docx"

  echo ">>> ${title}"

  # md → HTML body fragment
  pandoc "${DRAFTS}/${source}" -f markdown -t html --syntax-highlighting=none -o "$body_tmp"

  # Template substitution (Python for multi-line safety)
  export DOC_TITLE="$title"
  export DOC_SUBTITLE="$subtitle"
  export DOC_CODE="$code"
  export DOC_TYPE="$type"
  export BODY_FILE="$body_tmp"
  export TEMPLATE_FILE="$TEMPLATE"

  python3 <<'PY' > "$html_tmp"
import os
template = open(os.environ['TEMPLATE_FILE'], encoding='utf-8').read()
body = open(os.environ['BODY_FILE'], encoding='utf-8').read()
for k in ['DOC_TITLE','DOC_SUBTITLE','DOC_CODE','DOC_TYPE','DOC_ORG',
          'DOC_CLASSIFICATION','DOC_VERSION','DOC_STATUS','DOC_EFFECTIVE_DATE',
          'DOC_NEXT_REVIEW','DOC_PROJECT','DOC_PREPARED_BY','DOC_REVIEWED_BY',
          'DOC_APPROVED_BY','DOC_REVISION_ROWS']:
    template = template.replace(f'{{{{{k}}}}}', os.environ.get(k, ''))
template = template.replace('{{DOC_BODY}}', body)
print(template)
PY

  # HTML → PDF (Chrome headless)
  local abs_html="$(pwd)/${html_tmp}"
  "$CHROME" --headless=new --disable-gpu \
    --print-to-pdf="${pdf_out}" \
    --no-pdf-header-footer \
    --virtual-time-budget=8000 \
    "file://${abs_html}" 2>/dev/null || true

  # md → docx (pandoc)
  pandoc "${DRAFTS}/${source}" \
    -o "${docx_out}" \
    --metadata title="${title}" \
    --metadata subtitle="${subtitle}" \
    -V lang=th 2>/dev/null

  # Cleanup temp
  rm -f "$body_tmp" "$html_tmp"

  local pdf_size=$(du -h "$pdf_out" 2>/dev/null | cut -f1 | tr -d ' ')
  local docx_size=$(du -h "$docx_out" 2>/dev/null | cut -f1 | tr -d ' ')
  local pages=$(mdls -name kMDItemNumberOfPages "$pdf_out" 2>/dev/null | awk '{print $3}')
  echo "    ✓ ${pdf_out}  (${pdf_size}, ${pages:-?} pages)"
  echo "    ✓ ${docx_out} (${docx_size})"
}

# --- Print header ---
echo "========================================================================"
echo "  Daily Fitness Companion — Document Generator"
echo "========================================================================"
echo "  Revision:      ${NEW_VERSION} DRAFT"
echo "  Change note:   ${NOTE:-(initial release)}"
echo "  Date:          ${DATE_TH}"
echo "  Total history: $(python3 -c "import json; print(len(json.load(open('_revisions.json'))['history']))") entries"
echo "========================================================================"
echo ""

# --- Run generation ---
for entry in "${DOCS[@]}"; do
  IFS='|' read -r source title subtitle code type <<< "$entry"
  generate_doc "$source" "$title" "$subtitle" "$code" "$type"
done

# --- Summary ---
echo ""
echo "========================================================================"
echo "  Summary"
echo "========================================================================"
ls -lh *.pdf *.docx 2>/dev/null | awk '{printf "  %-30s %8s\n", $9, $5}'
echo ""
echo "  Revision history now contains $(python3 -c "import json; print(len(json.load(open('_revisions.json'))['history']))") entries"
echo "  See _revisions.json for full history"
echo "========================================================================"
