#!/bin/bash
# Pomodoro Lern-Timer mit Fächer-Verwaltung
# Beschreibung: Ein Lerntimer der alle 25 Minuten eine 5 Minuten Pause macht wie bei der Pomodoro-Technik.
#               Nach 4 Lernphasen gibt es eine 25 minütige Pause. Sobald der Benutzer "stop" schreibt wird
#               das Skript angehalten. Lernzeiten werden mit Datum in "lernzeit_log.txt" gespeichert.
#               Fächer sind über eine externe Datei anpassbar. Nach einem Sonntag wird die Woche zusammengefasst.
# Autor: D. Vignuda
# Version: 1.6
# Erstellt: 04-10-2025
# Zuletzt geändert: 08-05-2025

# DO NOT CHANGE THE SCRIPT BELOW UNLESS YOU KNOW WHAT YOU ARE DOING
POMODORO_TIME=$((25 * 60))
SHORT_BREAK_TIME=$((5 * 60))
LONG_BREAK_TIME=$((25 * 60))
ROUND=1
TOTAL_LEARNED=0
LOGFILE="lernzeit_log.txt"
STATEFILE=".last_logged_week.txt"
FAECHER_FILE="faecher.txt"
FAECHER=()
FACH=""
TAGE=("Montag" "Dienstag" "Mittwoch" "Donnerstag" "Freitag" "Samstag" "Sonntag")

# Fächerdatei erstellen, falls nicht vorhanden
if [ ! -f "$FAECHER_FILE" ]; then
  echo "Keine Fächerliste gefunden. Neue Fächerliste wird erstellt."

  read -p "Wie viele Fächer möchtest du anlegen? " anzahl
  while ! [[ "$anzahl" =~ ^[1-9][0-9]*$ ]]; do
    read -p "Ungültige Eingabe. Bitte eine positive Zahl eingeben: " anzahl
  done

  > "$FAECHER_FILE"
  for ((i = 1; i <= anzahl; i++)); do
    read -p "Name für Fach $i: " fachname
    while [[ -z "$fachname" ]]; do
      read -p "Fach darf nicht leer sein. Nochmal: " fachname
    done
    echo "$fachname" >> "$FAECHER_FILE"
  done
fi

# Fächer in Array laden
mapfile -t FAECHER < "$FAECHER_FILE"

# Fach auswählen
waehle_fach() {
  echo "Fachauswahl:"

  for i in "${!FAECHER[@]}"; do
    echo "$((i + 1))) ${FAECHER[$i]}"
  done

  read -p "Nummer eingeben (1–${#FAECHER[@]}): " fachwahl

  if [[ "$fachwahl" =~ ^[0-9]+$ ]] && (( fachwahl >= 1 && fachwahl <= ${#FAECHER[@]} )); then
    FACH="${FAECHER[$((fachwahl - 1))]}"
    echo "Lernfach: $FACH"
  else
    echo "Ungültige Eingabe. Das Skript wird abgebrochen."
    exit 1
  fi
}

# Woche prüfen
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

# Lernzeit protokollieren
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

# Wochenstatistik anzeigen
zeige_wochenstatistik() {
  local woche=$(date +%Y-%W)
  echo ""
  echo "Wochenstatistik für KW $woche:"
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
        printf "%s: %d Minuten\n", fach, sum[fach]
    }
  ' "$LOGFILE"
}

# Countdown mit Abbruchmöglichkeit
countdown_with_stop() {
  local seconds=$1
  local start_time=$(date +%s)

  while [ $seconds -gt 0 ]; do
    printf "\r%02d:%02d verbleibend... (stop zum Abbrechen) " $((seconds / 60)) $((seconds % 60))
    read -t 1 input
    if [[ "$input" == "stop" ]]; then
      echo -e "\nTimer gestoppt."
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

# Start
waehle_fach

while true; do
  echo ""
  echo "Runde $ROUND – 25 Minuten lernen"
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

echo ""
echo "Gesamt-Lernzeit: $((TOTAL_LEARNED / 60)) Minuten"
zeige_wochenstatistik
echo "Fortschritt wurde in $LOGFILE gespeichert."
