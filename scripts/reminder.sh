#!/usr/bin/env bash


# -- ABOUT THIS PROGRAM: -------------------------------------------------------------------------------------
#
# Name: reminder.sh
# Author:  Vitor Britto
# Description: This script is a simple reminder for daily tasks!
#
#
# -- INSTRUCTIONS: -------------------------------------------------------------------------------------------
#
# Execute:
#   $ chmod u+x reminder.sh && ./reminder.sh
#
# Options:
#   -h, --help        output help
#   -v, --version     output program version
#
# Alias:
#   alias reminder="bash path/to/script/reminder.sh"
#
# Example:
#   reminder
#
#
# -- CHANGELOG: ----------------------------------------------------------------------------------------------
#
#
#   DESCRIPTION:    First release
#   VERSION:        1.0.0
#   DATE:           24/01/2015
#   AUTHOR:         Vitor Britto
#
# ------------------------------------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# | VARIABLES                                                                  |
# ------------------------------------------------------------------------------

VERSION="1.0.0"
PROGRAM="Reminder"


# ------------------------------------------------------------------------------
# | UTILS                                                                      |
# ------------------------------------------------------------------------------

# Header logging
e_header() {
    printf "$(tput setaf 38)→ %s$(tput sgr0) " "$@"
}

# Success logging
e_success() {
    printf "$(tput setaf 76)✔ %s$(tput sgr0)\n" "$@"
}

# Error logging
e_error() {
    printf "$(tput setaf 1)✖ %s$(tput sgr0)\n" "$@"
}

# Warning logging
e_warning() {
    printf "$(tput setaf 3)! %s$(tput sgr0)\n" "$@"
}

# Ask for confirmation before proceeding
seek_confirmation() {
    printf "\n"
    e_warning "$@"
    read -p "Continue? (y/n) " -n 1
    printf "\n"
}

# Test whether the result of an 'ask' is a confirmation
is_confirmed() {
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
      return 0
    fi
    return 1
}

# Test whether a command exists
# $1 - cmd to test
type_exists() {
    if [ $(type -P $1) ]; then
      return 0
    fi
    return 1
}


# ------------------------------------------------------------------------------
# | MAIN FUNCTIONS                                                             |
# ------------------------------------------------------------------------------

# Reminder Help
reminder_help() {

cat <<EOT

------------------------------------------------------------------------------
REMINDER - A simple reminder for daily tasks!
------------------------------------------------------------------------------

Usage: ./reminder.sh [options]
Example: ./reminder.sh

Options:
    -h, --help        output this help
    -v, --version     output reminder version

Important:
    If you prefer, create an alias: reminder="bash ~/path/to/script/reminder.sh"
    And execute with: reminder


Copyright (c) Vitor Britto
Licensed under the MIT license.

------------------------------------------------------------------------------

EOT

}

# Reminder Version
reminder_version() {
    echo "$PROGRAM: v$VERSION"
}

# Reminder Start
reminder_start() {

    local UNAMESTR=`uname`

    e_header "Remember to:"
    read input_subject

    e_header "Remember at (use \"HH:MM\" format):"
    read input_date

    if [[ "$UNAMESTR" == 'Linux' ]]; then

        if ! type_exists 'notify-send'; then
            seek_confirmation "notify-send is required. Would you like to install it now?"

            if is_confirmed; then
                e_header "Installing notify-send"
                sudo apt-get notify-send
                e_success "Done!"
            else
                e_warning "Sorry! Reminder can't go on!"
            fi

        fi

        CURRENT=$(date +%s)
        SCHEDULE=$(date -j "+%s" $(echo "$input_read" | sed 's%/%%g;s% %%g;s%:..;%%;s%:%%g'))
        WAITFOR=$(($SCHEDULE - $CURRENT))

        e_success "Remind succesfully created!"

        { sleep "$WAITFOR"; notify-send "$input_subject" "$WAITFOR"; } &

    elif [[ "$UNAMESTR" == 'Darwin' ]]; then

        if ! type_exists 'terminal-notifier'; then
            seek_confirmation "terminal-notifier is required. Would you like to install it now?"

            if is_confirmed; then
                e_header "Installing terminal-notifier"
                brew install terminal-notifier
                e_success "Done!"
            else
                e_warning "Sorry! Reminder can't go on!"
            fi

        fi

        CURRENT=$(date +%s)
        SCHEDULE=$(date -j -f date -j -f "%H:%M" "$input_date" +"%s")
        WAITFOR=$(($SCHEDULE - $CURRENT))

        e_success "Remind succesfully created!"

        { sleep "$WAITFOR"; terminal-notifier -message "$input_subject" -sound 'default'; } &

    fi

}

# ------------------------------------------------------------------------------
# | INITIALIZE PROGRAM                                                         |
# ------------------------------------------------------------------------------

main() {

    if [[ "${1}" == "-h" || "${1}" == "--help" ]]; then
        reminder_help ${1}
        exit
    elif [[ "${1}" == "-v" || "${1}" == "--version" ]]; then
        reminder_version ${1}
        exit
    else
        reminder_start
        exit
    fi

}

# Initialize
main $*
