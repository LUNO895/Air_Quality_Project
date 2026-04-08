#!/bin/bash
# ============================================================
# GitHub Auto-Upload Script
# India Air Quality Analysis Project
# ============================================================
# HOW TO USE:
#   1. Open Terminal on your computer
#   2. Place this script in the same folder as your project files
#   3. Run:  bash github_upload.sh
#   4. Enter your GitHub username and Personal Access Token when asked
# ============================================================

set -e  # Exit immediately if any command fails

# ── Colors for output ───────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo ""
echo -e "${CYAN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║     India Air Quality — GitHub Upload Script         ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════╝${NC}"
echo ""

# ── Step 1: Collect credentials ─────────────────────────────
echo -e "${YELLOW}📋 Step 1: Enter your GitHub credentials${NC}"
echo ""
read -p "  GitHub Username       : " GH_USER
read -s -p "  Personal Access Token: " GH_TOKEN
echo ""
REPO_NAME="india-air-quality-analysis"
echo ""
echo -e "  Repo name will be: ${CYAN}${REPO_NAME}${NC}"
echo ""

# ── Step 2: Check git is installed ──────────────────────────
echo -e "${YELLOW}📋 Step 2: Checking prerequisites...${NC}"
if ! command -v git &> /dev/null; then
    echo -e "${RED}  ✗ git is not installed. Install it from https://git-scm.com${NC}"
    exit 1
fi
echo -e "${GREEN}  ✓ git is available${NC}"

if ! command -v curl &> /dev/null; then
    echo -e "${RED}  ✗ curl is not installed.${NC}"
    exit 1
fi
echo -e "${GREEN}  ✓ curl is available${NC}"
echo ""

# ── Step 3: Check required files exist ──────────────────────
echo -e "${YELLOW}📋 Step 3: Checking project files...${NC}"
REQUIRED_FILES=(
    "project.csv"
    "Air_Quality_Project.py"
    "Air_Quality_Presentation.pptx"
    "Air_Quality_Report.docx"
    "README.md"
)
ALL_FOUND=true
for f in "${REQUIRED_FILES[@]}"; do
    if [ -f "$f" ]; then
        echo -e "${GREEN}  ✓ Found: $f${NC}"
    else
        echo -e "${RED}  ✗ Missing: $f${NC}"
        ALL_FOUND=false
    fi
done
if [ "$ALL_FOUND" = false ]; then
    echo ""
    echo -e "${RED}  Some files are missing. Make sure all files are in the same folder as this script.${NC}"
    exit 1
fi
echo ""

# ── Step 4: Create GitHub repository via API ────────────────
echo -e "${YELLOW}📋 Step 4: Creating GitHub repository...${NC}"
API_RESPONSE=$(curl -s -o /tmp/gh_response.json -w "%{http_code}" \
    -X POST \
    -H "Authorization: token ${GH_TOKEN}" \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/user/repos \
    -d "{
        \"name\": \"${REPO_NAME}\",
        \"description\": \"End-to-end Data Science project: India Air Quality Analysis — EDA, visualisations, and Linear Regression across 29 states, 262 cities, 7 pollutants\",
        \"public\": true,
        \"has_issues\": true,
        \"has_projects\": false,
        \"has_wiki\": false,
        \"auto_init\": false
    }")

if [ "$API_RESPONSE" = "201" ]; then
    echo -e "${GREEN}  ✓ Repository created: https://github.com/${GH_USER}/${REPO_NAME}${NC}"
elif [ "$API_RESPONSE" = "422" ]; then
    echo -e "${YELLOW}  ⚠ Repository already exists — will push to existing repo${NC}"
else
    echo -e "${RED}  ✗ Failed to create repo (HTTP $API_RESPONSE)${NC}"
    cat /tmp/gh_response.json
    exit 1
fi
echo ""

# ── Step 5: Initialise git and commit ───────────────────────
echo -e "${YELLOW}📋 Step 5: Initialising git repository...${NC}"

# Remove existing .git if present (fresh start)
if [ -d ".git" ]; then
    rm -rf .git
    echo -e "  Removed existing .git directory"
fi

git init
git config user.email "${GH_USER}@users.noreply.github.com"
git config user.name "${GH_USER}"

# Create .gitignore
cat > .gitignore << 'EOF'
__pycache__/
*.pyc
*.pyo
.DS_Store
Thumbs.db
*.egg-info/
.env
.venv/
*.log
EOF

echo -e "${GREEN}  ✓ Git initialised${NC}"
echo ""

# ── Step 6: Stage and commit all files ──────────────────────
echo -e "${YELLOW}📋 Step 6: Staging files...${NC}"
git add .
git commit -m "🚀 Initial commit: India Air Quality Analysis Project

Complete data science project including:
- project.csv: Raw air quality monitoring dataset
- Air_Quality_Project.py: Full 5-phase Python analysis script
- Air_Quality_Presentation.pptx: 11-slide PowerPoint presentation
- Air_Quality_Report.docx: Detailed project Word document
- README.md: Repository overview and documentation

Covers: EDA across 29 states, 262 cities, 7 pollutants
Model: Linear Regression (PM2.5 prediction)
Tech: pandas, numpy, matplotlib, seaborn, scikit-learn"

echo -e "${GREEN}  ✓ Files committed${NC}"
echo ""

# ── Step 7: Push to GitHub ───────────────────────────────────
echo -e "${YELLOW}📋 Step 7: Pushing to GitHub...${NC}"
REMOTE_URL="https://${GH_USER}:${GH_TOKEN}@github.com/${GH_USER}/${REPO_NAME}.git"
git branch -M main
git remote add origin "${REMOTE_URL}" 2>/dev/null || git remote set-url origin "${REMOTE_URL}"
git push -u origin main --force

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║              ✅  UPLOAD COMPLETE!                    ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "  🔗 Your repository: ${CYAN}https://github.com/${GH_USER}/${REPO_NAME}${NC}"
echo ""
echo -e "  Files uploaded:"
for f in "${REQUIRED_FILES[@]}"; do
    echo -e "  ${GREEN}  ✓${NC} $f"
done
echo ""
echo -e "  ${YELLOW}Tip:${NC} Go to your repo and click 'Add topics' to tag it with:"
echo -e "  ${CYAN}  python, data-science, air-quality, pandas, matplotlib, machine-learning${NC}"
echo ""
