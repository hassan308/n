#!/bin/bash

# ================================================================
# GIT AUTO - Automatisk GitHub Repository Hantering
# ================================================================
# Detta script:
# 1. Kollar om repo finns på GitHub
# 2. Skapar nytt repo om det inte finns
# 3. Commitar och pushar all kod automatiskt
# ================================================================

set -e  # Avsluta vid fel

# Färger för output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# ================================================================
# STEG 1: Kolla credentials
# ================================================================
echo -e "${BLUE}🔐 Kollar GitHub credentials...${NC}"

if [ -z "$GITHUB_TOKEN" ] || [ -z "$GITHUB_USERNAME" ]; then
    echo -e "${RED}❌ ERROR: GitHub credentials saknas!${NC}"
    echo -e "${YELLOW}Lägg till följande i din ~/.bashrc:${NC}"
    echo ""
    echo 'export GITHUB_TOKEN="ditt_token"'
    echo 'export GITHUB_USERNAME="ditt_username"'
    echo ""
    echo -e "${YELLOW}Kör sedan: source ~/.bashrc${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Credentials hittade för användare: $GITHUB_USERNAME${NC}"

# ================================================================
# STEG 2: Hitta repo-namn från nuvarande mapp
# ================================================================
REPO_NAME=$(basename "$PWD")
echo -e "${BLUE}📁 Nuvarande mapp: $REPO_NAME${NC}"

# ================================================================
# STEG 3: Kolla om vi är i en git-repo
# ================================================================
if [ ! -d ".git" ]; then
    echo -e "${YELLOW}⚠️  Ingen git-repo hittad. Initialiserar...${NC}"
    git init
    git branch -M main
    echo -e "${GREEN}✅ Git repo initialiserad${NC}"
fi

# ================================================================
# STEG 4: Kolla om repo finns på GitHub
# ================================================================
echo -e "${BLUE}🔍 Kollar om repo finns på GitHub...${NC}"

HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" \
    -H "Authorization: token $GITHUB_TOKEN" \
    "https://api.github.com/repos/$GITHUB_USERNAME/$REPO_NAME")

if [ "$HTTP_STATUS" = "200" ]; then
    echo -e "${GREEN}✅ Repo finns redan på GitHub${NC}"
    REPO_EXISTS=true
else
    echo -e "${YELLOW}⚠️  Repo finns INTE på GitHub${NC}"
    REPO_EXISTS=false
fi

# ================================================================
# STEG 5: Skapa repo på GitHub om det inte finns
# ================================================================
if [ "$REPO_EXISTS" = false ]; then
    echo -e "${BLUE}🚀 Skapar nytt repo på GitHub...${NC}"
    
    RESPONSE=$(curl -s -X POST \
        -H "Authorization: token $GITHUB_TOKEN" \
        -H "Accept: application/vnd.github.v3+json" \
        https://api.github.com/user/repos \
        -d "{\"name\":\"$REPO_NAME\",\"private\":false}")
    
    if echo "$RESPONSE" | grep -q '"id"'; then
        echo -e "${GREEN}✅ Repo skapat på GitHub!${NC}"
    else
        echo -e "${RED}❌ Kunde inte skapa repo. Svar från GitHub:${NC}"
        echo "$RESPONSE"
        exit 1
    fi
fi

# ================================================================
# STEG 6: Lägg till remote om den inte finns
# ================================================================
if ! git remote | grep -q "origin"; then
    echo -e "${BLUE}🔗 Lägger till remote origin...${NC}"
    git remote add origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
    echo -e "${GREEN}✅ Remote tillagd${NC}"
else
    echo -e "${GREEN}✅ Remote origin finns redan${NC}"
    # Uppdatera remote URL för säkerhets skull
    git remote set-url origin "https://github.com/$GITHUB_USERNAME/$REPO_NAME.git"
fi

# ================================================================
# STEG 7: Commit alla ändringar
# ================================================================
echo -e "${BLUE}📦 Commitar alla filer...${NC}"

git add .

# Kolla om det finns något att commita
if git diff --staged --quiet; then
    echo -e "${YELLOW}⚠️  Inga ändringar att commita${NC}"
else
    COMMIT_MSG="Auto commit - $(date '+%Y-%m-%d %H:%M:%S')"
    git commit -m "$COMMIT_MSG"
    echo -e "${GREEN}✅ Commit skapad: $COMMIT_MSG${NC}"
fi

# ================================================================
# STEG 8: Pusha till GitHub
# ================================================================
echo -e "${BLUE}🚀 Pushar till GitHub...${NC}"

# Använd token för autentisering i push URL
git push -u https://$GITHUB_TOKEN@github.com/$GITHUB_USERNAME/$REPO_NAME.git main 2>&1 || {
    echo -e "${YELLOW}⚠️  Main branch finns inte, försöker med master...${NC}"
    git push -u https://$GITHUB_TOKEN@github.com/$GITHUB_USERNAME/$REPO_NAME.git master 2>&1
}

echo -e "${GREEN}✅ Push lyckades!${NC}"

# ================================================================
# STEG 9: Visa resultat
# ================================================================
echo ""
echo -e "${GREEN}═══════════════════════════════════════════════${NC}"
echo -e "${GREEN}✨ KLART! Ditt repo finns nu på GitHub ✨${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════${NC}"
echo ""
echo -e "${BLUE}📍 Repo URL:${NC} https://github.com/$GITHUB_USERNAME/$REPO_NAME"
echo -e "${BLUE}🌿 Branch:${NC} main"
echo ""
