# ⚡ SNABBGUIDE - Git Auto

## 🎯 Ett-kommando lösning

```bash
wsl bash -c 'source ~/.bashrc && bash ~/scripts/git-auto.sh'
```

## 📱 Ännu enklare - Skapa Windows alias

Om du vill köra från PowerShell/CMD i Windows:

### Steg 1: Skapa PowerShell Profile
Öppna PowerShell och kör:
```powershell
notepad $PROFILE
```

### Steg 2: Lägg till denna funktion:
```powershell
function git-auto {
    wsl bash -c 'source ~/.bashrc && bash ~/scripts/git-auto.sh'
}
```

### Steg 3: Ladda om
```powershell
. $PROFILE
```

### Steg 4: Använd!
```powershell
cd C:\Users\test\Desktop\n
git-auto
```

## 🚀 Workflow exempel

### Nytt projekt på 3 sekunder:

```bash
# Windows PowerShell:
cd C:\Users\test\Desktop
mkdir awesome-project
cd awesome-project
echo "# Hello World" > README.md

git-auto  # KLART! 🎉
```

### Uppdatera befintligt projekt:

```bash
cd C:\Users\test\Desktop\n
# ... gör ändringar ...
git-auto  # Auto-commit + push! ✅
```

## 🔥 Pro Tips

### Tip 1: Commit-meddelanden
Scriptet skapar automatiska commits med timestamp:
```
Auto commit - 2025-11-28 22:47:01
```

### Tip 2: Se vad som händer
Scriptet visar färgkodad output:
- 🔵 Blå = Information
- 🟢 Grön = Framgång
- 🟡 Gul = Varning

### Tip 3: Flera projekt samtidigt
```bash
# Terminal 1
cd projekt-1 && git-auto

# Terminal 2  
cd projekt-2 && git-auto
```

## 📊 Tidsbesparingar

**Före:**
```bash
git init
git add .
git commit -m "Initial commit"
# Gå till GitHub, skapa repo manuellt
git remote add origin https://...
git push -u origin main
```
**Tid: ~5 minuter**

**Efter:**
```bash
git-auto
```
**Tid: ~3 sekunder** ⚡

---

**Sparad tid per projekt: 4 minuter 57 sekunder!**
