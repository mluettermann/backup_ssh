#!/bin/bash

# SSH-Ordner-Sicherungsskript

# Funktion zum Schreiben von INFO-Logs
log_info() {
    echo "$(date "+%Y-%m-%d %H:%M:%S") [INFO] $1"
}

# Funktion zum Schreiben von ERROR-Logs
log_error() {
    echo "$(date "+%Y-%m-%d %H:%M:%S") [ERROR] $1" >&2
}

# Aktuelles Datum als Variable für den Dateinamen
CURRENT_DATE=$(date +"%Y%m%d")

# Sicherungsverzeichnis erstellen, falls es noch nicht existiert
BACKUP_DIR="$HOME/Nextcloud2/Documents/Backup/ssh"
mkdir -p "${BACKUP_DIR}"

# Der Name der Sicherungsdatei
BACKUP_FILE="${BACKUP_DIR}/ssh_backup_${CURRENT_DATE}.tar.gz"

# Start des Skripts
log_info "Backup-Skript gestartet."

# Überprüfen, ob der .ssh-Ordner existiert
if [ -d "$HOME/.ssh" ]; then
    # Erstellen einer komprimierten Tarball-Datei des .ssh-Verzeichnisses
    tar czf "${BACKUP_FILE}" --exclude='*.sock' -C "$HOME" .ssh

    # Erfolgsmeldung mit Dateinamen ausgeben
    log_info "Dein SSH-Ordner wurde erfolgreich gesichert in: ${BACKUP_FILE}"

    # Alte Sicherungen löschen und nur die neuesten 5 behalten
    find "${BACKUP_DIR}" -maxdepth 1 -name "ssh_backup_*.tar.gz" -type f | sort | head -n -5 | xargs rm --

else
    log_error "Fehler: Der SSH-Ordner existiert nicht in deinem Home-Verzeichnis."
    exit 1
fi