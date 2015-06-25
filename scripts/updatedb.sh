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


# ------------------------------------------------------------------------------
# | INITIALIZE PROGRAM                                                         |
# ------------------------------------------------------------------------------

main() {

    sudo -v
    pushd . > /dev/null
    cd /usr/libexec
    e_header "Updating locate database"
    ./locate.updatedb
    e_succes "Updating complete!"
    popd > /dev/null

}

main $*
