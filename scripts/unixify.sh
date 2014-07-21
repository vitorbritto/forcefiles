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
#           -l, --list        list man pages with specific letter
#           -v, --view        view specific man pag
#           -g, --generate    generate specific man page to PDF
#           -e, --explain     explain a specific command for Unix Shell
#           -s, --system      dynamic real-time view of a running system
#           -p, --process     view current process
#           -m, --mail        email an snapshot from current command to admin
#           -A, --append      append a new path to global variable PATH
#           -P, --prepend     prepend a new path to global variable PATH
#           -o, --offline     shutdown the system
#           -i, --info        show system info
#
# ------------------------------------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# | VARIABLES                                                                  |
# ------------------------------------------------------------------------------


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

# List man pages with specific letter
uify_list() {
    e_header "Listing man pages with letter: $2"
    ls /usr/share/man/man1/ | egrep ^[$2].* | more
}

# Explain command for Unix
uify_explain() {
    e_header "Redirecting"
    open http://explainshell.com/
}

# Generate PDF for specific man page
uify_generate() {
    mkdir -p .manpdf
    e_header "Generating PDF for man page: $2"
    local dest=$HOME/.manpdf/
    cd "$dest"
    man -t "$2" | pstopdf -i -o "$2".pdf
    open $HOME/.manpdf/"$2".pdf
    e_success "Done!"
}

uify_process() {
    e_header "Listing running processes"
    ps -efl $time
    e_success "Done!"
}

uify_pid() {
    ps aux | grep "$2"
    if [[ "$2" != 0 ]]; then
        e_success "Find $2 process"
    fi
    e_error "No process found"
}

uify_kill() {
    e_header "Killing processes: $2"
    kill -$3 $2
    e_success "Done!"
}

# View of running system
uify_system() {
    e_header "View of running system"
    top
}

# Send email to system admin
# TODO: try ssmtp package
uify_mail() {
    local log="log"
    local admin=$(whoami)
    local domain="com.br"
    local input="${@:2}"
    e_header "Sending email to system admin"
    "${input}" | mail -s 'Snapshot' "${log}@${admin}.${domain}"
    e_success "Email has been sent!"
}

uify_shutdown() {
    e_header "Shuting down the system"
    sudo shutdown -h now
}


uify_sys_info() {

    local name=$(whoami)
    local os=$(uname)
    local since=$(uptime)
    local memory=$(ps aux -l | sort -nr -k 4 | head -1)
    local cpu=$(ps aux -l | sort -nr -k 3 | head -1)
    local cpustat=$(iostat)

    e_header "--------------------"
    e_header "SYSTEM INFORMATION: "
    e_header "--------------------"
    e_header "User: ${name}"
    e_header "System: ${os}"
    e_header "Uptime: ${since}"
    e_header ""
    e_header "CPU Statitcs:"
    e_header "${cpustat}"
    e_header "High Memory Usage:"
    e_header "$memory"
    e_header "High CPU Usage:"
    e_header "$cpu"
    e_header "--------------------"

}

# Everybody need some help
uify_help() {

cat <<EOT

-----------------------------------------------------------------------------
UNIXIFY - General utilities for Unix
-----------------------------------------------------------------------------

-- FIRST OF ALL: ------------------------------------------------------------

Create an alias, like the following one:
alias uify="bash path/to/script/unixify.sh"

-- INSTRUCTIONS: ------------------------------------------------------------

Usage:   uify [options] <manpage, letter, command>
Example: uify -e "ls -la" -> Explain "ls -la" command

Options:
         -h, --help        output help
         -l, --list        list man pages with specific letter
         -v, --view        view specific man pag
         -g, --generate    generate specific man page to PDF
         -e, --explain     explain a specific command for Unix Shell
         -s, --system      dynamic real-time view of a running system
         -p, --process     view current process
         -m, --mail        email an snapshot from current command to admin
         -A, --append      append a new path to global variable PATH
         -P, --prepend     prepend a new path to global variable PATH
         -o, --offline     shutdown the system
         -i, --info        show system info

Copyright (c) Vitor Britto
Licensed under the MIT license.

------------------------------------------------------------------------------

EOT

}


# ------------------------------------------------------------------------------
# | INITIALIZE PROGRAM                                                         |
# ------------------------------------------------------------------------------

main() {

    case $1 in
        -h | --help ) uify_help $*; exit 0; ;;          # output help
        -l | --list ) uify_list $*; exit 0; ;;          # list man pages with specific letter
        -v | --view ) uify_view $*; exit 0; ;;          # view specific man page
        -g | --generate ) uify_generate $*; exit 0; ;;  # generate specific man page to PDF
        -e | --explain ) uify_explain $*; exit 0; ;;    # explain a specific command for Unix Shell
        -s | --system ) uify_system $*; exit 0; ;;      # dynamic real-time view of a running system
        -p | --process ) uify_process $*; exit 0; ;;    # view current processes
        -m | --mail ) uify_mail $*; exit 0; ;;          # run a specif command and send an email to admin
        -A | --append ) uify_append $*; exit 0; ;;      # append a new path to global variable PATH
        -P | --prepend ) uify_prepend $*; exit 0; ;;    # prepend a new path to global variable PATH
        -o | --offline ) uify_offline $*; exit 0; ;;    # shutdown the system
        -i | --info ) uify_sys_info $*; exit 0; ;;      # show system info
        * ) e_error "Invalid option!"; exit 1; ;;
    esac

}

# Initialize Script
main $*
