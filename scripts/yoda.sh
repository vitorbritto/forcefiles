#!/usr/bin/env bash

# ------------------------------------------------------------------------------
#
# Program: yoda.sh
# Author:  Vitor Britto
#
# Description:
#       This is my personal READ LATER method.
#
# Important:
#       First of all, define where you want to save your "readlater" file
#       then make this script executable to easily run it.
#       $ chmod u+x yoda.sh
#
# Usage:
#       INSERT: ./yoda.sh 'NAME' 'http://URL'
#       VIEW:   ./yoda.sh [ -l, --list   ]
#       OPEN:   ./yoda.sh [ -o, --open   ]
#       HELP:   ./yoda.sh [ -h, --help   ]
#       EXPORT: ./yoda.sh [ -e, --export ]
#
# Assumptions:
#       - The url of interest is a simple one.
#
# Alias:
#       alias yoda="bash ~/path/to/script/yoda.sh"
#
# ------------------------------------------------------------------------------
# TODO: regex for grep on export bookmarks
# ------------------------------------------------------------------------------



# ------------------------------------------------------------------------------
# | VARIABLES                                                                  |
# ------------------------------------------------------------------------------

# Set your configurations here
FILE="FAVORITES.md"                         # Recommended: *.md, *.txt
DIR="Desktop"                               # Recommended: /Desktop
BROWSER="Canary"                            # Available: Canary, Chrome

# Core (DO NOT CHANGE)
CANARY_MAC_PATH="$HOME/Library/Application\ Support/Google/Chrome\ Canary/Default/Bookmarks"
CHROME_MAC_PATH="$HOME/Library/Application\ Support/Google/Chrome/Default/Bookmarks"
CANARY_LINUX_PATH="$HOME/.config/google-chrome-canary/Default/Bookmarks"
CHROME_LINUX_PATH="$HOME/.config/google-chrome/Default/Bookmarks"
FULL_PATH="$HOME/${DIR}/${FILE}"
EXT="${FILE##*.}"
OS="lowercase \`uname\`"
OPEN_COMMAND="/usr/bin/open"
CAT_COMMAND="cat -n"




# ------------------------------------------------------------------------------
# | UTILS                                                                      |
# ------------------------------------------------------------------------------

lowercase() {
    echo "${1}" | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/"
}



# ------------------------------------------------------------------------------
# | SPECIFIC OPTIONS                                                           |
# ------------------------------------------------------------------------------

# Browser Options
browser_mac() {
    if [[ "${BROWSER}" == "Canary" ]]; then
        if [[ "${EXT}" == 'md' ]]; then
            grep http: ${CANARY_MAC_PATH} >> ${FULL_PATH}
        else
            grep http: ${CANARY_MAC_PATH} >> ${FULL_PATH}
        fi
    elif [[ "${BROWSER}" == "Chrome" ]]; then
        if [[ "${EXT}" == 'md' ]]; then
            grep http: ${CHROME_MAC_PATH} >> ${FULL_PATH}
        else
            grep http: ${CHROME_MAC_PATH} >> ${FULL_PATH}
        fi
    fi
}

browser_linux() {
    if [[ "${BROWSER}" == "Canary" ]]; then
        if [[ "${EXT}" == 'md' ]]; then
            grep http: ${CANARY_LINUX_PATH} >> ${FULL_PATH}
        else
            grep http: ${CANARY_LINUX_PATH} >> ${FULL_PATH}
        fi
    elif [[ "${BROWSER}" == "Chrome" ]]; then
        if [[ "${EXT}" == 'md' ]]; then
            grep http: ${CHROME_LINUX_PATH} >> ${FULL_PATH}
        else
            grep http: ${CHROME_LINUX_PATH} >> ${FULL_PATH}
        fi
    fi
}

# System Platform
os_type() {
    if [[ "${OS}" == "linux" ]]; then
        browser_linux
    elif [[ "${OS}" == "darwin"* ]]; then
        browser_mac
    else
        echo "Only available for OSX and GNU/Linux."
    fi
}



# ------------------------------------------------------------------------------
# | MAIN FUNCTION                                                              |
# ------------------------------------------------------------------------------

main() {
    #echo "Number of params = $#"

    # View file option
    if [[ "${1}" == "-l" || "${1}" == "--list" ]]; then
        yoda_list ${1}
        exit
    fi

    # Open file option
    if [[ "${1}" == "-o" || "${1}" == "--open" ]]; then
        yoda_open ${1}
        exit
    fi

    # Show export option
    if [[ "${1}" == "-e" || "${1}" == "--export" ]]; then
        yoda_export ${1}
        exit
    fi

    # Show help option
    if [[ "${1}" == "-h" || "${1}" == "--help" ]]; then
        yoda_help ${1}
        exit
    fi

    # Add url option
    if [[ "$*" =~ "http://" || "$*" =~ "https://" ]]; then
        yoda_add $*
        exit
    else
        echo "Sorry, any valid parameter."
    fi
}



# ------------------------------------------------------------------------------
# | MAIN OPTIONS                                                               |
# ------------------------------------------------------------------------------

# Add URL
yoda_add() {
    echo "Saving..."
    if [[ "${EXT}" == 'md' ]]; then
        if [[ $# -gt 1 ]]; then
            echo "- [${@:1:$(($#-1))}](${*: -1})" >> ${FULL_PATH}
        else
            echo "- [${1}](${1})" >> ${FULL_PATH}
        fi
    else
        echo $@ >> ${FULL_PATH}
    fi
    echo "✔ Done!"
}

# Export Bookmarks
yoda_export() {
    echo "Exporting..."
    os_type
    echo "✔ Done!"
}

# View file content
yoda_list() {
    echo "---------------------------------------------------"
    echo "                     FAVORITES                     "
    echo "---------------------------------------------------"
    ${CAT_COMMAND} ${FULL_PATH}
}

# Open file
yoda_open() {
    echo "Opening..."
    ${OPEN_COMMAND} ${FULL_PATH}
    echo "✔ Done!"
}

# Everybody need some help
yoda_help() {

cat <<EOT

------------------------------------------------------------------------------
YODA SAVES - May the Force be with your favorites
------------------------------------------------------------------------------

Usage:
    ./yoda.sh <name> <url> [, options]

Example:
    Add a favorite with name
    $ ./yoda.sh GitHub http://github.com

    Add a favorite without name
    $ ./yoda.sh http://github.com

    Export Bookmarks from Browser
    $ ./yoda.sh --export

Options:
    -h, --help      Print this help text
    -l, --list      Print a list of your favorites
    -o, --open      Open your favorites file
    -e, --export    Export your bookmarks from Chrome (or Chrome Canary)

Documentation can be found at https://github.com/vitorbritto/yoda/

Copyright (c) Vitor Britto
Licensed under the MIT license.

------------------------------------------------------------------------------

EOT

}

# Initialize Yoda
main $*
