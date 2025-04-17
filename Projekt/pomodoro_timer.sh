#!/bin/bash
# Programm: Lerntimer nach Pomodoro-Technik
# Beschreibung: Ein Lerntimer der alle 25 Minuten eine 5 Minuten Pause macht wie bei der Pomodoro-Technik.
#		Nach 4 Lernphasen gibt es eine 25 minütige Pause. Sobald der Benutzer "stop" schreibt wird
#		das Skript angehalten. In einer separaten Datei namens "lernzeit_log.txt". In der Datei
#		werden die Lernzeiten eingetragen. Das Datum der Lernzeit steht auch. Nach einem Sonntag
#		wird die wöchentliche Lernzeit zusammengefasst.
#
#
# Aufruf: ./pomodoro_timer.sh
# Optionen:
# Parameter:
#
# Autor: D. Vignuda
#
# Version: 1.3
# Erstellt: 04-10-2025
#
# Zuletzt Geaendert: 04-17-2025



# DO NOT CHANGE THE SCRIPT BELOW UNLESS YOU KNOW WHAT YOU ARE DOING


POMODORO_TIME=$((25 * 60))
SHORT_BREAK_TIME=$((5 * 60))
LONG_BREAK_TIME=$((25 * 60))
ROUND=1
TOTAL_LEARNED=0
LOGFILE="lernzeit_log.txt"
STATEFILE=".last_logged_week.txt"
FACH=""

TAGE=("Montag" "Dienstag" "Mittwoch" "Donnerstag" "Freitag" "Samstag" "Sonntag")

# Fachauswahl am Anfang
waehle_fach() {
  echo "Für welches Fach lernst du heute?"
  echo "1) Mathematik"
  echo "2) Chemie"
  echo "3) Französisch"
  echo "4) Wirtschaft und Recht"
  echo "5) Geschichte"
  echo "6) Modul"
  read -p "➤ Nummer eingeben (1–6): " fachwahl

  case $fachwahl in
    1) FACH="Mathematik" ;;
    2) FACH="Chemie" ;;
    3) FACH="Französisch" ;;
    4) FACH="Wirtschaft und Recht" ;;
    5) FACH="Geschichte" ;;
    6) 
      read -p "Welches Modul? (3-stellige Nummer): " modulnum
      while ! [[ "$modulnum" =~ ^[0-9]{3}$ ]]; do
        read -p "Ungültig. Bitte eine 3-stellige Zahl eingeben: " modulnum
      done
      FACH="Modul $modulnum"
      ;;
    *) 
      echo "❗ Ungültige Eingabe. Standard: 'Allgemein'"
      exit 1
      ;;
  esac
  echo "Du lernst heute für: $FACH"
}

# Neue Woche einleiten
check_new_week() {
  local current_week=$(date +%Y-%W)
  if [ -f "$STATEFILE" ]; then
    local last_logged_week=$(cat "$STATEFILE")
  else
    local last_logged_week=""
  fi

  if [ "$current_week" != "$last_logged_week" ]; then
    echo "------" >> "$LOGFILE"
    echo "Woche ab Montag, $(date -d "last monday" +%d.%m.%Y)" >> "$LOGFILE"
    echo "$current_week" > "$STATEFILE"
  fi
}

# Log-Eintrag schreiben
log_lernzeit() {
  local minuten=$1
  local datum=$(date "+%d.%m.%Y %H:%M")
  local tag_num=$(date +%u)
  local tag_name=${TAGE[$((tag_num - 1))]}

  check_new_week

  if ! grep -q "^$tag_name:" "$LOGFILE"; then
    echo "$tag_name:" >> "$LOGFILE"
  fi

  echo "$datum - $FACH - Gelernt: $minuten Minuten" >> "$LOGFILE"
}

# Countdown mit STOP-Funktion
countdown_with_stop() {
  local seconds=$1
  local start_time=$(date +%s)

  while [ $seconds -gt 0 ]; do
    printf "\r%02d:%02d remaining... (Tippe 'stop' + Enter zum Abbrechen) " $((seconds / 60)) $((seconds % 60))
    read -t 1 input
    if [[ "$input" == "stop" ]]; then
      echo -e "\nPomodoro wurde gestoppt."
      local now=$(date +%s)
      local elapsed=$((now - start_time))
      local minuten=$((elapsed / 60))
      TOTAL_LEARNED=$((TOTAL_LEARNED + elapsed))
      log_lernzeit "$minuten"
      return 1
    fi
    ((seconds--))
  done

  local now=$(date +%s)
  local elapsed=$((now - start_time))
  local minuten=$((elapsed / 60))
  TOTAL_LEARNED=$((TOTAL_LEARNED + elapsed))
  log_lernzeit "$minuten"
  return 0
}

# Wochenstatistik
zeige_wochenstatistik() {
  local woche=$(date +%Y-%W)
  echo -e "\nWochenstatistik für KW $woche:"
  awk -v woche="Woche ab Montag" '
    $0 ~ "------" { active = 0 }
    $0 ~ woche { active = 1 }
    active && /Gelernt:/ {
      match($0, /- (.+) - Gelernt: ([0-9]+)/, arr)
      fach = arr[1]
      min = arr[2]
      sum[fach] += min
    }
    END {
      for (fach in sum)
        printf "📘 %s: %d Minuten\n", fach, sum[fach]
    }
  ' "$LOGFILE"
}

# START
waehle_fach

while true; do
  echo -e "\nRunde $ROUND – 25 Minuten lernen"
  countdown_with_stop $POMODORO_TIME || break

  if (( ROUND % 4 == 0 )); then
    echo "Lange Pause (25 Minuten)"
    countdown_with_stop $LONG_BREAK_TIME || break
  else
    echo "Kurze Pause (5 Minuten)"
    countdown_with_stop $SHORT_BREAK_TIME || break
  fi

  ((ROUND++))
done

echo -e "\nGesamt-Lernzeit: $((TOTAL_LEARNED / 60)) Minuten"
zeige_wochenstatistik
echo "Beendet. Fortschritt wurde in $LOGFILE gespeichert."
