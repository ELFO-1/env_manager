# env_manager
Python Environment Manager
#
Ein einfaches Bash-Skript, um Python Virtual Environments zu verwalten. Es ermöglicht dir, neue Environments zu erstellen, bestehende zu aktivieren und eine Liste aller verfügbaren Environments anzuzeigen. Das Skript speichert das Verzeichnis, in dem die Environments abgelegt werden, und erlaubt es dir, dieses Verzeichnis bei Bedarf zu ändern.
Features

    Erstellen neuer Python Virtual Environments mit python -m venv.
    Aktivieren bestehender Environments direkt aus dem Skript.
    Anzeigen aller verfügbaren Environments in einem konfigurierbaren Verzeichnis.
    Speichern des zuletzt verwendeten Verzeichnisses für Environments in einer Konfigurationsdatei.
    Standardverzeichnis ist das Home-Verzeichnis (~/env), kann aber geändert werden.

Voraussetzungen

    Python 3 muss installiert sein (inkl. venv-Modul).
    Ein Linux- oder Unix-basiertes Betriebssystem mit Bash.

    Installation

    Klone das Repository:

    bash

git clone https://github.com/DEIN_USERNAME/python-environment-manager.git
cd python-environment-manager

Stelle sicher, dass das Skript ausführbar ist:

chmod +x python_env_manager.sh

Verwendung

    Starte das Skript:

    bash

./python_env_manager.sh

Wähle eine der Optionen:

    1: Neues Environment erstellen
        Gib einen Namen für das neue Environment ein.
        Das Environment wird im aktuellen Verzeichnis für Environments erstellt.
        Du kannst das Environment direkt nach der Erstellung aktivieren.
    2: Bestehendes Environment aktivieren
        Wähle ein Environment aus der Liste aus.
        Das Environment wird aktiviert, und du kannst es mit deactivate wieder verlassen.
    3: Verfügbare Environments anzeigen
        Zeigt eine Liste aller Environments im aktuellen Verzeichnis.

Ändere das Verzeichnis für Environments:

    Beim Start des Skripts wird das aktuelle Verzeichnis angezeigt.
    Du kannst das Verzeichnis ändern, indem du die entsprechende Option auswählst.
    Das neue Verzeichnis wird gespeichert und beim nächsten Start verwendet.

Konfigurationsdatei

Das Skript speichert das zuletzt verwendete Verzeichnis in der Datei ~/.python_env_manager.conf. Diese Datei wird automatisch erstellt und aktualisiert. Du kannst sie manuell bearbeiten, wenn nötig.
