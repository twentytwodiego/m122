
# Shell-Scripting & Terminal-Basics

## Modul 122: Prozesse mit Skriptsprachen automatisieren

### 20.02.2025

Heute habe ich zum ersten Mal VirtualBox installiert und gelernt, wie man eine virtuelle Maschine mit Ubuntu Server erstellt. Ich habe mich auf der Plattform registriert und bin nun bereit, beim nächsten Mal tiefer in die Welt der Ubuntu-Server einzusteigen.

---

### 27.02.2025 – Erste Schritte mit dem Terminal

#### 1. Aufbau des Linux-Terminals

- Der Prompt zeigt den aktuellen Benutzer, Rechnernamen und Ordnerpfad an.
- `~` steht für das eigene Home-Verzeichnis.
- Einige wichtige Zeichen:
  - `;` trennt mehrere Befehle.
  - `|` verbindet Befehle, sodass die Ausgabe des ersten an den zweiten übergeben wird.
  - `#` kennzeichnet Kommentare.
  - `&` führt einen Prozess im Hintergrund aus.

#### 2. Hilfe zu Befehlen finden

- `man befehl` zeigt das Handbuch zum Befehl.
- `apropos stichwort` sucht in allen Manpages nach dem Stichwort.
- `which befehl` zeigt den Speicherort eines Befehls an.

#### 3. Navigation und Dateien verwalten

- `pwd` zeigt das aktuelle Verzeichnis.
- `cd verzeichnis` wechselt in ein anderes Verzeichnis.
- `mkdir verzeichnis` legt einen neuen Ordner an.
- `rmdir verzeichnis` entfernt einen leeren Ordner.
- `ls verzeichnis` zeigt den Inhalt eines Ordners.
- `find pfad -name dateiname` sucht nach einer Datei.

#### 4. Dateioperationen

- `cp quelle ziel` kopiert Dateien oder Ordner.
- `rm datei/ordner` entfernt Dateien oder Ordner.
- `mv alt neu` verschiebt oder benennt um.
- `touch datei` erzeugt eine neue leere Datei.
- `cat datei` zeigt den Inhalt an.
- `wc -l datei` zählt die Zeilen.
- `echo "Text"` gibt Text aus.

---

## 5. Eigene Kurzbefehle (Aliase)

```bash
alias ll='ls -alFG'
```

Mit Aliases kann man sich eigene Abkürzungen für lange Befehle erstellen.

---

## 6. Platzhalterzeichen

| Zeichen    | Bedeutung                                  |
| ---------- | ------------------------------------------ |
| `*`        | beliebige Anzahl an Zeichen                |
| `?`        | genau ein Zeichen                          |
| `{1,2,3}`  | erstellt mehrere Dateien                   |
| `{1..5}`   | erstellt eine fortlaufende Folge           |

---

## 7. Nutzung der Tilde

| Ausdruck          | Bedeutung                            |
| ----------------- | ------------------------------------ |
| `~` oder `$HOME`  | Heimatverzeichnis                    |
| `~benutzer`       | Heimatverzeichnis eines anderen      |
| `~-` oder `$OLDPWD` | vorheriger Ordner                  |
| `~+` oder `$PWD`  | aktueller Ordner                     |

---

## 05.03.2025 – Rückblick

Ich habe heute die Grundlagen des Terminals verstanden. Die Konzepte waren dank früherer Erfahrungen mit `cmd` und `Git-Bash` gut nachvollziehbar. Besonders die Erklärung zu Dateisystemen (z. B. `/`, `sda1`, `sdb1`) war hilfreich.

---

## 06.03.2025 – Einstieg in Shell-Skripte

### 1. Skript schreiben und starten

```bash
touch script.sh
nano script.sh
chmod +x script.sh
./script.sh
```

### 2. Variablen und Systemvariablen

```bash
name="Hans"
echo $name
datum=$(date +%Y-%m-%d)
echo $datum
```

Beispiele für Systemvariablen: `$USER`, `$HOME`, `$PWD`

### 3. Rechnen und Bedingungen

```bash
zahl=$((5 + 3))
if [ $zahl -eq 8 ]; then
  echo "Richtig!"
fi
```

### 4. Schleifen nutzen

**for-Schleife:**

```bash
for file in *.txt; do
  echo "$file"
done
```

**while-Schleife:**

```bash
i=1
while [ $i -le 5 ]; do
  echo "Zahl $i"
  i=$((i+1))
done
```

### 5. Umleitungen von Ein- und Ausgaben

- `>` überschreibt eine Datei.
- `>>` fügt etwas an eine Datei an.
- `2>` speichert Fehlermeldungen.

```bash
ls /nichtvorhanden > ausgabe.txt 2>&1
```

### Standardkanäle

- **0** = stdin (Eingabe)
- **1** = stdout (Ausgabe)
- **2** = stderr (Fehler)

### Weitere Beispiele

```bash
./skript > ausgabe.txt 2> fehler.txt
./skript > alles.txt 2>&1
./skript > ausgabe.txt 2>/dev/null
```

### Eingabe von Datei

```bash
cat < eingabe.txt
cat < eingabe.txt > kopie.txt
```

### Heredoc

```bash
sort << ENDE
Z
B
A
ENDE
```

### Pipelines

```bash
cat datei.txt | grep "hallo" | uniq | sort
```

---

## Remote-Skripting

### Mit SCP kopieren

```bash
scp script.sh user@host.local:~
```

### Skript auf entfernten Server ausführen

```bash
chmod +x script.sh
./script.sh
```

---

## Rechte und Benutzerverwaltung

### Dateirechte anzeigen

```bash
ls -al
```

Beispiel: `-rwxr-xr--` bedeutet: Besitzer darf alles, Gruppe darf lesen & ausführen, andere dürfen nur lesen.

### Rechte ändern

```bash
chmod u+x datei.sh
chmod 755 datei.sh
```

### Besitzer ändern

```bash
chown benutzer datei
chgrp gruppe datei
```

### Benutzerbefehle

```bash
whoami
who
groups
id
su - benutzer
useradd benutzer
userdel benutzer
passwd benutzer
logout
```

---

## Hilfreiche Tools

- `grep`: Textsuche
- `cut`: Spalten extrahieren
- `paste`: Zeilen kombinieren
- `sed`: Texte bearbeiten
- `tr`: Zeichen umwandeln
- `awk`: komplexe Textverarbeitung
- `curl`: Daten abrufen
- `xargs`: Argumente übergeben
