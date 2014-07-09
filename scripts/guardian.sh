#!/usr/bin/env bash

# ------------------------------------------------------------------------------
#
# Program: guardian.sh
# Author:  Vitor Britto
#
# Description:
#       Guardian is a simple method to execute your
#       backups with Rsync for external volumes.
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
#
# CRONTAB:
#
#       Example:
#       - First of all, create a text file named backup.txt
#       - Insert "00 6 * * 1 /path/to/script/guardian.sh && bash guardian.sh" in "backup.txt" file
#       - Now, simply execute "crontab backup.txt"
#       - All done! Your cron job will work fine every week at 6:00 AM!
#
#       Options:
#       - crontab -e: edit the current job or create a new one
#       - crontab -l: list cron jobs
#       - crontab -r: remove a cron job
#
# ------------------------------------------------------------------------------


# Ask for the administrator password upfront
sudo -v


# ------------------------------------------------------------------------------
# | VARIABLES                                                                  |
# ------------------------------------------------------------------------------

# Settings
MAIN="/Volumes/Colossus"    # Source
SRC="$HOME/Sites/"          # Source
DIST="${MAIN}/BACKUP"       # Destination directory
LOGS="${MAIN}/LOGS"         # Logs directory

# Core (do not change)
NOW="$(date +'%d/%m/%Y %H:%M:%S')"
BKP="$DIST/$(date +'%d_%m_%Y')"
TAR="$DIST/bkp_$(date +'%d_%m_%Y').tar.gz"
LOG="$LOGS/backup_log_$(date +'%d_%m_%Y').txt"


# ------------------------------------------------------------------------------
# | MAIN                                                                       |
# ------------------------------------------------------------------------------



# Handle Errors
if [ ! -d "$LOGS" ]; then
    echo "→ Creating log directory"
    mkdir -p $LOGS
fi

if [ ! -d "$DIST" ]; then
    echo "→ Creating backup directory"
    mkdir -p $DIST
fi

if [ ! -r "$SRC" ]; then
    chmod u+r $SRC
    echo "→ Source $SRC is now readable"
fi

if [ ! -w "$DIST" ]; then
    chmod u+w $DIST
    echo "→ Destination $DIST is now writeable"
fi

# Backup Function
guardian() {
    echo "→ Starting backup process..."
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

    exit
}

# Initialize
guardian
