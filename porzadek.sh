#!/bin/bash

# Sprawdzenie, czy skrypt jest uruchamiany z prawami administratora
if [ "$(id -u)" -ne 0 ]; then
    echo "Musisz uruchomić ten skrypt jako root!" >&2
    exit 1
fi

# Definicja ścieżek
KATALOG="/home/student/Pulpit"
KATALOG_NIEPORZADEK="$KATALOG/.nieporządek"
SKRYPT="/usr/local/bin/porzadek.sh"
SERVICE_FILE="/etc/systemd/system/porzadek.service"
LOG="/var/log/porzadek.log"

# Tworzenie skryptu do przenoszenia plików
echo "Tworzę skrypt przenoszący pliki..."

cat << 'EOF' > "$SKRYPT"
#!/bin/bash

KATALOG="/home/student/Pulpit"
KATALOG_NIEPORZADEK="$KATALOG/.nieporządek"
LOG="/var/log/porzadek.log"

# Tworzenie katalogu .nieporządek, jeśli nie istnieje
if [ ! -d "$KATALOG_NIEPORZADEK" ]; then
    mkdir "$KATALOG_NIEPORZADEK"
    echo "$(date): Tworzę katalog .nieporządek" >> "$LOG"
fi

# Lista wyjątków (nazwy plików/katalogów z dopuszczalnymi wzorcami)
wyjatki=(
    "Arduino IDE"
    "Dodatek.txt"
    "UGS.sh"
    ".nieporządek"
    "*.desktop"
    "*.html"
    ".directory"
)

# Logowanie rozpoczęcia procesu
echo "$(date): Rozpoczynam przenoszenie plików" >> "$LOG"

# Funkcja sprawdzająca, czy plik lub katalog jest wyjątkiem
is_exception() {
    local item="$1"
    for exception in "${wyjatki[@]}"; do
        # Dopasowanie wzorca za pomocą operatora == z globami
        if [[ "$(basename "$item")" == $exception ]]; then
            return 0  # Jest wyjątkiem
        fi
    done
    return 1  # Nie jest wyjątkiem
}

# Przenoszenie plików, katalogów i dowiązań symbolicznych, które nie pasują do wyjątków
for item in "$KATALOG"/*; do
    if [ -f "$item" ] && ! is_exception "$item"; then
        mv "$item" "$KATALOG_NIEPORZADEK" && echo "$(date): Przeniesiono plik \"$item\"" >> "$LOG"
    elif [ -d "$item" ] && ! is_exception "$item"; then
        mv "$item" "$KATALOG_NIEPORZADEK" && echo "$(date): Przeniesiono katalog $item" >> "$LOG"
    #elif [ -L "$item" ]; then
    #    mv "$item" "$KATALOG_NIEPORZADEK" && echo "$(date): Przeniesiono dowiązanie symboliczne $item" >> "$LOG"
    fi
done

# Logowanie zakończenia procesu
echo "$(date): Zakończyłem przenoszenie plików i katalogów" >> "$LOG"
EOF

# Ustawienie odpowiednich uprawnień do skryptu
chmod +x "$SKRYPT"

# Tworzenie usługi systemd
echo "Tworzę usługę systemd do uruchamiania skryptu przed X..."

cat << EOF > "$SERVICE_FILE"
[Unit]
Description=Skrypt porządkujący pliki przed uruchomieniem X
Before=display-manager.service

[Service]
ExecStart=/usr/local/bin/porzadek.sh
Type=oneshot
User=root
RemainAfterExit=true

[Install]
WantedBy=multi-user.target
EOF

# Ładowanie nowej konfiguracji systemd
systemctl daemon-reload

# Aktywowanie usługi systemd
echo "Aktywuję usługę systemd..."

systemctl enable porzadek.service

# Uruchamianie usługi (opcjonalnie)
# systemctl start porzadek.service

# Informowanie użytkownika o zakończeniu
echo "Skrypt i usługa zostały pomyślnie utworzone."
echo "Skrypt zostanie uruchomiony przed startem X'ów przy każdym uruchomieniu systemu."
