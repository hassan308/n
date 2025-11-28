# 🚀 Git Auto - Automatisk GitHub Integration

Ett kraftfullt automation-script som automatiskt hanterar hela Git-arbetsflödet åt dig!

## ✨ Vad gör scriptet?

Med **ett enda kommando** (`git-auto`) så:

1. ✅ Kollar om du har GitHub credentials
2. ✅ Initialiserar Git repo (om det inte finns)
3. ✅ Kollar om repo finns på GitHub
4. ✅ Skapar nytt repo på GitHub (om det inte finns)
5. ✅ Lägger till remote origin
6. ✅ Commitar alla filer automatiskt
7. ✅ Pushar till GitHub
8. ✅ Visar länk till ditt repo

## 🔧 Installation - KLART! ✅

Allt är redan uppsatt för dig:

- ✅ Script installerat: `~/scripts/git-auto.sh`
- ✅ Credentials konfigurerade i `~/.bashrc`
- ✅ Git-konfiguration satt
- ✅ Alias skapat: `git-auto`

## 💻 Användning

### Snabbstart (från vilken mapp som helst)

```bash
# Gå till din projektmapp
cd /path/till/ditt/projekt

# Kör scriptet - det är ALLT!
wsl bash -c 'source ~/.bashrc && bash ~/scripts/git-auto.sh'
```

### Om du öppnar ny WSL-terminal

```bash
# I din WSL-terminal:
cd /mnt/c/Users/test/Desktop/mitt-projekt

# Kör scriptet
bash ~/scripts/git-auto.sh
```

### Kortare alternativ (kräver ny WSL-session)

Öppna en HELT NY WSL-terminal, då fungerar alias:

```bash
cd /mnt/c/Users/test/Desktop/mitt-projekt
git-auto  # Färdig!
```

## 📋 Exempel på användning

### Scenario 1: Nytt projekt från scratch

```bash
cd /mnt/c/Users/test/Desktop
mkdir mitt-nya-projekt
cd mitt-nya-projekt

# Skapa några filer
echo "# Mitt Projekt" > README.md
echo "console.log('Hello');" > app.js

# Automatisk GitHub-push!
bash ~/scripts/git-auto.sh
```

**Resultat:**
- ✅ Git repo skapad
- ✅ Nytt repo på GitHub: `https://github.com/hassan308/mitt-nya-projekt`
- ✅ Alla filer committade och pushade

### Scenario 2: Befintlig mapp (ingen Git)

```bash
cd /mnt/c/Users/test/Desktop/old-projekt

# Automatisk GitHub-push!
bash ~/scripts/git-auto.sh
```

**Resultat:**
- ✅ Git initialiserad i mappen
- ✅ Repo skapad på GitHub
- ✅ Allt pushat

### Scenario 3: Snabba uppdateringar

```bash
cd /mnt/c/Users/test/Desktop/n

# Gör ändringar...
echo "Ny kod" >> file.txt

# Push med ett kommando!
bash ~/scripts/git-auto.sh
```

**Resultat:**
- ✅ Auto-commit med timestamp
- ✅ Auto-push till GitHub

## 🔐 Säkerhet

Dina GitHub credentials är lagrade i:
- **Plats:** `~/.bashrc` i WSL
- **Aldrig pushade** till GitHub
- **Endast tillgängliga** i din WSL-miljö

Du kan när som helst ändra dem genom att editera:
```bash
wsl nano ~/.bashrc
```

## 🎯 Funktioner

- 🔒 **Säker:** Credentials lagras lokalt i WSL
- 🚀 **Snabb:** Ett kommando - klart!
- 🤖 **Smart:** Skapar repo automatiskt om det inte finns
- 💚 **Användarvänlig:** Färgkodad output
- ⚡ **Effektiv:** Sparar tid varje dag

## 📝 Konfiguration

Alla inställningar finns i `~/.bashrc`:

```bash
export GITHUB_TOKEN="ditt_github_token_här"
export GITHUB_USERNAME="ditt_användarnamn"
alias git-auto="bash ~/scripts/git-auto.sh"
```

## 🐛 Felsökning

### "Credentials saknas"
Kör:
```bash
wsl bash -c 'source ~/.bashrc && echo $GITHUB_TOKEN'
```

Om ingenting visas, ladda om:
```bash
wsl bash -c 'source ~/.bashrc'
```

### "Permission denied"
Ge execute-rättigheter:
```bash
wsl chmod +x ~/scripts/git-auto.sh
```

## 🎉 Bekräftat fungerande!

Scriptet har testats och pushade framgångsrikt till:
**https://github.com/hassan308/n**

Kolla själv! 🚀

---

**Skapad av:** Antigravity AI  
**Datum:** 2025-11-28
