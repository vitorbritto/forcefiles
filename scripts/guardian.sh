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
MAIN="/Volumes/Colossus"    # Dist
SRC="$HOME/Sites/"          # Source Files
DIST="${MAIN}/BACKUP"       # Backup directory
LOGS="${MAIN}/LOGS"         # Logs directory

# Database
DBUSER=root
DBPASS=root

# Core (do not change)
DATABASE=`mysql --user=${DBUSER} -p${DBPASS} -e "SHOW DATABASES;" | grep -Ev "Database"`
TIMESTAMP="$(date +'%d_%m_%Y')"
FILES="${DIST}/${TIMESTAMP}/files/"
SQL="${DIST}/${TIMESTAMP}/mysql"
TAR="${FILES}/bkp_$(date +'%d_%m_%Y').tar.gz"
LOG="${LOGS}/backup_log_$(date +'%d_%m_%Y').txt"



# ------------------------------------------------------------------------------
# | MAIN                                                                       |
# ------------------------------------------------------------------------------


# Handle Errors
if [ ! -d "$LOGS" ]; then
    echo "→ Creating log directory"
    mkdir -p $LOGS
fi

if [ ! -d "$FILES" ]; then
    echo "→ Creating files directory"
    mkdir -p $FILES
fi

if [ ! -d "$SQL" ]; then
    echo "→ Creating database directory"
    mkdir -p $SQL
fi

if [ ! -r "$SRC" ]; then
    chmod u+r $SRC
    echo "→ Source $SRC is now readable"
fi

if [ ! -w "$DIST" ]; then
    chmod u+w $DIST
    echo "→ Destination $DIST is now writeable"
fi



# ------------------------------------------------------------------------------
# | BACKUP FUNCTIONS                                                           |
# ------------------------------------------------------------------------------


# Backup - Databases
guardian_database() {

    echo "→ Starting backup..."
    echo "→ This could take a while... please wait."

    echo "----------------------------------------------------------" >> "$LOG"
    echo "→ DATABASE: Start backup process in: $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOG"

    for db in $DATABASE; do
        if [[ "$db" != "information_schema" ]] && [[ "$db" != "performance_schema" ]] && [[ "$db" != "mysql" ]] && [[ "$db" != "test" ]] && [[ "$db" != _* ]] ; then

            echo "→ Dumping database: $db"
            mysqldump --force --opt --user=$DBUSER -p$DBPASS --databases $db > "$SQL/$db.sql"

            echo "→ $SQL was successfully dumped!" >> "$LOG"

        fi
    done

    echo "→ End backup process in: $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOG"
    echo "----------------------------------------------------------" >> "$LOG"

    echo "→ Backup successfully completed!"
}

# Backup - Project Files
guardian_file() {
    echo "→ Starting backup..."
    echo "→ This could take a while... please wait."

    echo "----------------------------------------------------------" >> "$LOG"
    echo "→ FILES: Start backup process in: $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOG"

    echo "→ Copying files..."
    rsync -arq "$SRC" "$FILES"

    echo "→ Compressing files..."
    tar -zcf "$TAR" "$DIST/"

    echo "→ End backup process in: $(date +'%d-%m-%Y %H:%M:%S')" >> "$LOG"
    echo "----------------------------------------------------------" >> "$LOG"

    echo "→ Backup successfully completed!"
}

# Initialize
guardian_database
guardian_file
