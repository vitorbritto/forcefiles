#!/usr/bin/env bash

# ------------------------------------------------------------------------------
#
# Program: markupify.sh
# Author:  Vitor Britto
#
# Description:
#       This is my personal method to extract some parts fo HTML files.
#
# Important:
#       First of all, make this script executable to easily run it.
#       $ chmod u+x markupify.sh
#
# Usage: ./markupify.sh [ options ] <LOCAL_FILE, FILE_URL>
#
# Options:
#       -c, --class        output classes
#       -i, -id            output ids
#       -u, --url          output urls from href
#
# Example:
#       ./markupify -c index.html
#
#
# Assumptions:
#       - The url of interest is a simple one.
#
# Alias:
#       alias markupify="bash ~/path/to/script/markupify.sh"
#
# ------------------------------------------------------------------------------



# ------------------------------------------------------------------------------
# | MAIN FUNCTION                                                              |
# ------------------------------------------------------------------------------

markupify() {

    # List Classes
    if [[ "${1}" == "-c" || "${1}" == "--class" ]]; then
        mify_class ${1} ${2}
        exit
    fi

    # List IDs
    if [[ "${1}" == "-i" || "${1}" == "--id" ]]; then
        mify_id ${1} ${2}
        exit
    fi

    # List href URL
    if [[ "${1}" == "-u" || "${1}" == "--url" ]]; then
        mify_href ${1} ${2}
        exit
    fi

}

mify_class() {
    echo "→ Extracting"
    cat ${2} | grep class= | cut -d \" -f2
}

mify_id() {
    echo "→ Extracting"
    cat ${2} | grep id= | cut -d \" -f2
}

mify_href() {
    echo "→ Extracting"
    cat ${2} | grep -o '<a .*href=.*>' | sed -e 's/<a /\<a /g' | sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d'
}

# Extract classes or IDs from file or URL
markupify $*
