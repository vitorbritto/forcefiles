#!/usr/bin/env bash

# ------------------------------------------------------------------------------
#
# Program: guardian.sh
# Author:  Vitor Britto
#
# Description:
#   Guardian is a simple method to execute your
#   backups with Rsync for external volumes.
#
#
# Usage: ./guardian.sh
# Alias: guardian="bash ~/path/to/script/guardian.sh"
#
# Important:
#       First of all, define where you want to save your backup
#       then make this script executable to easily run it.
#       $ chmod u+x guardian.sh
#
# ------------------------------------------------------------------------------


# Ask for the administrator password upfront
sudo -v


# ------------------------------------------------------------------------------
# | VARIABLES                                                                  |
# ------------------------------------------------------------------------------

# Settings
SRC="$HOME/Sites/"                  # Source directory
MAIN="/Volumes/BACKUP"              # External Volume
DIST="$MAIN/PROJECTS"               # Destination directory
LOGS="_logs"                        # Logs directory
EXCLUDE="$DIST/bkp_excludes.txt"    # Exclude list files on sync

# Core (do not change)
NOW="$(date +'%d/%m/%Y %H:%M:%S')"
BKP="$DIST/$(date +'%d_%m_%Y')"
TAR="$MAIN/bkp_$(date +'%d_%m_%Y').tar.gz"
LOG="$MAIN/$LOGS/backup_log_$(date +'%d_%m_%Y').txt"


# ------------------------------------------------------------------------------
# | MAIN                                                                       |
# ------------------------------------------------------------------------------

# Handle Errors
if [ ! -r "$SRC" ]; then
    echo "Source $SRC not readable - Cannot start the sync process"
    exit
fi

if [ ! -w "$DIST" ]; then
    echo "Destination $DIST not writeable - Cannot start the sync process"
    exit
fi

if [ ! -d "$LOGS" ]; then
    mkdir _logs
    exit
fi

# Backup Function
guardian() {
    echo "→ Initializing backup process"
    echo "→ This could take a while... please wait."

    echo "----------------------------------------------------------" >> "$LOG"
    echo "→ Start backup process in: $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOG"

    echo "→ Copying files..."
    rsync -arq "$SRC" "$BKP"
    echo "→ Compressing files..."
    tar -zcf "$TAR" "$BKP"
    # tar -zcvf "$BKP" | gzip > "$TAR"

    echo "→ End backup process in: $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOG"
    echo "----------------------------------------------------------" >> "$LOG"

    echo "→ Backup completed successfully!"

    exit 0
}

# Initialize
guardian
