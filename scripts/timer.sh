#!/usr/bin/env bash

# -- ABOUT THIS PROGRAM: -------------------------------------------------------------------------------------
#
# Name: unixify.sh
# Author:  Vitor Britto
# Description: This script is a set of general utilities for Unix (based on Bash shell)
#
# -- FIRST OF ALL: -------------------------------------------------------------------------------------------
#
# Create an alias, like the following one:
# alias uify="bash path/to/script/unixify.sh"
#
# -- INSTRUCTIONS: -------------------------------------------------------------------------------------------
#
# Usage:    uify [options] <manpage, letter, command>
# Example:  uify -e "ls -la" -> Explain "ls -la" command
#
# Options:
#           -h, --help        output help
#           -V, --version     output program version
#
# ------------------------------------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# | VARIABLES                                                                  |
# ------------------------------------------------------------------------------

VERSION="0.1.1"
PROGRAM="timer"


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
TIMER - A Simple Timer for Tasks
------------------------------------------------------------------------------

Usage: ./timer.sh [options]
Example: ./timer.sh

Options:
      -h, --help        output help

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
