#!/usr/bin/env bash


# -- ABOUT THIS PROGRAM: -------------------------------------------------------------------------------------
#
# Name: timer.sh
# Author:  Vitor Britto
# Description: This script is a Simple Time Tracking for Tasks (based on Bash shell)
#
#
# -- INSTRUCTIONS: -------------------------------------------------------------------------------------------
#
# Execute:
#   $ chmod u+x timer.sh && ./timer.sh
#
# Options:
#   -h, --help        output help
#   -v, --version     output program version
#
# Alias:
#   alias timer="bash path/to/script/timer.sh"
#
# Example:
#   timer
#
#
# -- CHANGELOG: ----------------------------------------------------------------------------------------------
#
#
#   DESCRIPTION:    First release
#   VERSION:        1.0.0
#   DATE:           23/01/2015
#   AUTHOR:         Vitor Britto
#
# ------------------------------------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# | VARIABLES                                                                  |
# ------------------------------------------------------------------------------

VERSION="1.0.0"
PROGRAM="Timer"


# ------------------------------------------------------------------------------
# | UTILS                                                                      |
# ------------------------------------------------------------------------------

# Header logging
e_header() {
    printf "$(tput setaf 38)→ %s$(tput sgr0)\n" "$@"
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
# | MAIN FUNCTIONS                                                             |
# ------------------------------------------------------------------------------

# Timer Help
timer_help() {

cat <<EOT

------------------------------------------------------------------------------
TIMER - A Simple Time Tracking for Tasks
------------------------------------------------------------------------------

Usage: ./timer.sh [options]
Example: ./timer.sh

Options:
    -h, --help        output this help
    -v, --version     output timer version

Important:
    If you prefer, create an alias: timer="bash ~/path/to/script/timer.sh"
    And execute with: timer


Copyright (c) Vitor Britto
Licensed under the MIT license.

------------------------------------------------------------------------------

EOT

}

# Timer Version
timer_version() {
    echo "$PROGRAM: v$VERSION"
}

# Timer Start
timer_start() {
    echo -n "$(tput setaf 38)→ Task Name: "
    read TASK_NAME
    date "+Starting at: %H:%M:%S"
    e_warning "Press any key to stop"
    read -n 1 -s
    date "+End at: %H:%M:%S"
    e_success "Task ${TASK_NAME} successfully finished!"
}


# ------------------------------------------------------------------------------
# | INITIALIZE PROGRAM                                                         |
# ------------------------------------------------------------------------------

main() {

    if [[ "${1}" == "-h" || "${1}" == "--help" ]]; then
        timer_help ${1}
        exit
    elif [[ "${1}" == "-v" || "${1}" == "--version" ]]; then
        timer_version ${1}
        exit
    else
        timer_start
    fi

}

# Initialize
main $*
