Teil 2: Shellprogrammierung
===========================


Mein erstes Script
------------------

Ein Bash-Script wird unter Linux folgendermassen erstellt:

1.  touch meinscript.sh
    
2.  nano meinscript.sh
    
3.  #!/bin/bashDadurch wird festgelegt, dass das Script mit Bash ausgeführt wird.
    
4.  #!/bin/bashecho "Das ist mein erstes Script"
    
5.  Speichern und den Editor verlassen: Strg + X, dann J (oder Y) und Enter.
    
6.  chmod +x meinscript.sh
    
7.  ./meinscript.sh
    

Falls es nicht funktioniert, prüfen mit:
```sh
which bash  $SHELL  bash --version   `
```

-----------------------

Neben nano sind folgende Editoren empfehlenswert:

*   **Geany**, **GEdit**, **Atom**: Komfortable Editoren (müssen evtl. installiert werden)
    
*   **Vim/Vi**: Standardeditor auf fast allen Linux-Systemen
    
*   **VS Code**: Installation auf Debian/Ubuntu, Raspberry Pi OS möglich
    

Variablen in Bash
-----------------

*   name="Hans"
    
*   echo $name
    
*   Variablen sind **case-sensitive** ($VAR ≠ $var).
    
*   unset name
    
*   readonly var="fester\_Wert"
    
*   datum=$(date +%Y\_%m\_%d)
    
*   datum2=$datum
    

### Automatische Variablen

*   $0 → Name des aufgerufenen Scripts
    
*   $1 - $9, ${10} → Parameter des Scripts
    
*   $# → Anzahl der Parameter
    
*   $$ → Prozessnummer des Scripts
    
*   $? → Rückgabewert des letzten Befehls
    

Arithmetische Berechnungen
--------------------------

Bash unterstützt nur Integer-Arithmetik. Berechnungen erfolgen mit $(( )) oder $\[ \]:
```sh
a=5  b=3  
ergebnis=$(( a + b ))  
echo $ergebnis   `
```
Operatoren:

*   \+ Addition
    
*   \- Subtraktion
    
*   \* Multiplikation
    
*   / Ganzzahldivision
    
*   % Modulo
    
*   \*\* Potenz
    

Kontrollstrukturen
------------------

### **If-Else Bedingung**
```sh
#!/bin/bash

echo -n "Enter a number: "
read VAR

if [ "$VAR" -gt 10 ]; then
    echo "The variable is greater than 10."
elif [ "$VAR" -eq 10 ]; then
    echo "The variable is equal to 10."
else 
    echo "The variable is less than 10."
fi
```
### **Schleifen (while, until, for)**
```sh
#!/bin/bash  for i in {1..5}  do      
echo "Durchlauf Nummer $i" 
done   `
```
Informationskanäle (STDIN, STDOUT, STDERR)
------------------------------------------

*   **STDIN (0):** Eingabekanal (z. B. Tastatur)
    
*   **STDOUT (1):** Standardausgabe
    
*   **STDERR (2):** Fehlerausgabe
    

### **Umleitung von Ausgaben**
```sh
ls -la > liste.txt     # Ausgabe in Datei schreiben  
ls -la >> liste.txt    # Ausgabe an Datei anhängen 
ls -la 2> fehler.txt   # Fehlerausgabe umleiten  
ls -la &> gesamt.txt   # Beide Kanäle umleiten   `
```
### **Eingabe umleiten**
```sh
cat < meinFile.txt  # Datei als Eingabe verwenden   `
```
**Pipelines & Textverarbeitung**
--------------------------------

*   cat meinFile.txt | grep "hallo" | sort | uniq
    
*   cat /etc/passwd | cut -d ':' -f 1 | grep -v irc
    

**Remote-Scripting mit SCP & SSH**
----------------------------------

### **Skript auf Linux-Server kopieren und ausführen**

```sh
scp script.sh user@server:/home/user/  
ssh user@server "bash /home/user/script.sh"   `
```
