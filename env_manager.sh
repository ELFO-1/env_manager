#!/bin/bash
# Author :  ELFO

# Konfigurationsdatei für das ENV-Verzeichnis
CONFIG_FILE="$HOME/.python_env_manager.conf"

# Funktion zum Laden des ENV-Verzeichnisses
load_env_directory() {
    if [ -f "$CONFIG_FILE" ]; then
        ENV_DIR=$(cat "$CONFIG_FILE")
    else
        # Standardmäßig ein 'env' Verzeichnis im Home-Verzeichnis
        ENV_DIR="$HOME/env"
        echo "$ENV_DIR" > "$CONFIG_FILE"
    fi
}

# Lade das Verzeichnis
load_env_directory

# Zeige aktuelles Verzeichnis und frage nach Änderung
echo ""
echo "Aktuelles Environment-Verzeichnis: $ENV_DIR"
read -p "Möchten Sie das Environment-Verzeichnis ändern? (j/n): " change_dir

if [ "$change_dir" = "j" ] || [ "$change_dir" = "J" ]; then
    read -p "Bitte geben Sie das neue Verzeichnis ein: " new_dir
    if [ ! -d "$new_dir" ]; then
        read -p "Verzeichnis existiert nicht. Soll es erstellt werden? (j/n): " create_dir
        if [ "$create_dir" = "j" ] || [ "$create_dir" = "J" ]; then
            mkdir -p "$new_dir"
        else
            echo "Behalte bisheriges Verzeichnis: $ENV_DIR"
            echo ""
        fi
    fi
    if [ -d "$new_dir" ]; then
        ENV_DIR="$new_dir"
        echo "$ENV_DIR" > "$CONFIG_FILE"
        echo "Verzeichnis wurde auf $ENV_DIR geändert."
        echo ""
    fi
fi

# Stelle sicher, dass das Verzeichnis existiert
mkdir -p "$ENV_DIR"

# Funktion zum Auflisten der Environments
list_environments() {
    echo "Verfügbare Environments:"
    echo "----------------------"
    if [ -d "$ENV_DIR" ]; then
        envs=($(ls "$ENV_DIR"))
        if [ ${#envs[@]} -eq 0 ]; then
            echo "Keine Environments gefunden!"
        else
            for env in "${envs[@]}"; do
                echo "- $env"
            done
        fi
    else
        echo "Verzeichnis nicht gefunden!"
    fi
    echo "----------------------"
}

echo ""
echo "========================="
echo "Python Environment Manager"
echo ""
echo "by ELFO"
echo "========================="
echo ""
echo "1: Neues Environment erstellen"
echo "2: Bestehendes Environment aktivieren"
echo "3: Verfügbare Environments anzeigen"
echo ""
read -p "Bitte wähle eine Option (1/2/3): " choice

case $choice in
    1)
        echo ""
        read -p "Bitte gib einen Namen für das neue Environment ein: " env_name

        # Überprüfe ob Environment bereits existiert
        if [ -d "$ENV_DIR/$env_name" ]; then
            echo "Ein Environment mit diesem Namen existiert bereits!"
            exit 1
        fi

        # Erstelle das neue Environment
        python -m venv "$ENV_DIR/$env_name"

        if [ $? -eq 0 ]; then
            echo "Environment erfolgreich erstellt!"
            read -p "Möchtest du das Environment jetzt aktivieren? (j/n): " activate

            if [[ $activate == "j" || $activate == "J" ]]; then
                source "$ENV_DIR/$env_name/bin/activate"
                echo "Environment wurde aktiviert. Benutze 'deactivate' zum Deaktivieren."
                exec $SHELL
            fi
        else
            echo "Fehler beim Erstellen des Environments!"
            exit 1
        fi
        ;;

    2)
        echo ""
        echo "Verfügbare Environments:"
        echo "----------------------"

        # Liste alle Environments auf
        envs=($(ls "$ENV_DIR"))

        if [ ${#envs[@]} -eq 0 ]; then
            echo "Keine Environments gefunden!"
            exit 1
        fi

        for i in "${!envs[@]}"; do
            echo "$((i+1)): ${envs[$i]}"
        done

        echo ""
        read -p "Wähle ein Environment (1-${#envs[@]}): " env_choice

        # Überprüfe ob Eingabe gültig ist
        if ! [[ "$env_choice" =~ ^[0-9]+$ ]] || [ $env_choice -lt 1 ] || [ $env_choice -gt ${#envs[@]} ]; then
            echo "Ungültige Auswahl!"
            exit 1
        fi

        selected_env="${envs[$((env_choice-1))]}"
        source "$ENV_DIR/$selected_env/bin/activate"
        echo "Environment '$selected_env' wurde aktiviert. Benutze 'deactivate' zum Deaktivieren."
        exec $SHELL
        ;;

    3)
        echo ""
        list_environments
        ;;

    *)
        echo "Ungültige Auswahl!"
        exit 1
        ;;
esac
