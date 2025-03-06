Linux-Befehle und Shell-Grundlagen - Zusammenfassung
====================================================

1\. Einführung in die Linux-Shell
---------------------------------

Die Linux-Shell ermöglicht die Eingabe und Ausführung von Befehlen direkt im Terminal. Neben einfachen Befehlen unterstützt die Shell auch Programmierstrukturen wie Variablen, Schleifen und Verzweigungen. Dies erlaubt die Automatisierung von Aufgaben durch Skripte.

2\. Der Linux-Prompt
--------------------

Der Standard-Prompt zeigt Informationen zum aktuellen Benutzer, Host und Verzeichnis an. Das Symbol ~ steht für das Heimatverzeichnis des aktuellen Benutzers (/home/), während das Root-Heimatverzeichnis unter /root/ liegt.

Beispiele:

3\. Wichtige Zeichen in der Shell
---------------------------------

*   ; Trennt Befehle in einer Zeile (Sequenz)
    
*   | Verbindet Befehle miteinander (Piping)
    
*   \# Kommentiert eine Zeile
    
*   \\ Setzt eine Befehlszeile in der nächsten Zeile fort
    
*   & Führt einen Befehl im Hintergrund aus
    

4\. Hilfe zu Befehlen
---------------------

*   man zeigt die Handbuchseite eines Befehls an.
    
*   apropos sucht in den Handbuchseiten nach einem Stichwort.
    
*   which zeigt den Speicherort eines installierten Programms.
    

5\. Systemeigene Befehle
------------------------

*   reboot Neustart des Systems
    
*   shutdown -h oder poweroff System herunterfahren
    
*   init 6 Neustart, init 0 System herunterfahren
    

6\. Verzeichnisbefehle
----------------------

*   pwd Zeigt aktuelles Verzeichnis an
    
*   cd Verzeichnis wechseln
    
*   mkdir Neues Verzeichnis erstellen
    
*   rmdir Leeres Verzeichnis löschen
    
*   ls Verzeichnisinhalt anzeigen
    
*   find \-name "\*.txt" Dateien suchen
    

**Absolute Pfade:**

*   /home/user/data/file.txt
    
*   /etc
    

**Relative Pfade:**

*   cd .. Gehe ein Verzeichnis zurück
    
*   cd ../../etc Zwei Ebenen hoch, dann nach /etc
    

7\. Dateibefehle
----------------

*   cp Datei/Verzeichnis kopieren
    
*   rm Datei löschen, rm -r Verzeichnis rekursiv löschen (Vorsicht!)
    
*   mv Datei umbenennen/verschieben
    
*   touch Leere Datei erstellen
    
*   cat Dateiinhalt ausgeben
    
*   wc -l Zeilen zählen, wc -w Wörter zählen
    
*   echo "Text" Gibt eine Zeichenkette aus
    

8\. Aliase
----------

Aliase erlauben die Erstellung von Kurzbefehl-Namen für komplexere Befehle.

**Beispiel:**

9\. Wildcards und Brace Expansion
---------------------------------

### Wildcards

*   \* Beliebige Zeichen (z.B. ls \*.txt listet alle .txt-Dateien auf)
    
*   ? Ein einzelnes Zeichen (z.B. ls file?.txt sucht nach file1.txt, file2.txt etc.)
    

### Brace Expansion

*   {1,2,3} Erstellt mehrere Dateien gleichzeitig (touch file{1,2,3}.txt)
    
*   {1..9} Erstellt eine Datei für jede Zahl im Bereich (touch file{1..9}.txt)
    
*   ! Negiert einen Ausdruck (ls file{!3}.txt listet alle ausser file3.txt)
    

**Verschachtelte Brace Expansion:**

Erstellt: fileoriginal.txt, fileoriginal.bak, filekopie.txt, filekopie.bak

10\. Tilde Expansion
--------------------

*   ~ Heimatverzeichnis des aktuellen Benutzers (cd ~)
    
*   ~BENUTZERNAME Heimatverzeichnis eines bestimmten Benutzers (cd ~myname)
    
*   ~+ Aktuelles Arbeitsverzeichnis (pwd)
    
*   ~- Vorheriges Arbeitsverzeichnis (cd -)
