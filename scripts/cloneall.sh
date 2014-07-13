#!/usr/bin/env bash

# ------------------------------------------------------------------------------------------------------------
#
# Program: cloneall.sh
# Author:  Vitor Britto
# Description: This script is a shortcut to clone all repositories from a specific user or organization
#
# Usage: ./cloneall.sh [options] <username> <page number>
#
# Options:
#   -h, --help        output instructions
#   -c, --clone       clone repositories
#
# Alias: alias cloneall="bash ~/path/to/script/cloneall.sh"
#
# Example:
#   ./cloneall.sh -c vitorbritto 1
#
# Test:
#   curl "https://api.github.com/users/vitorbritto/repos?per_page=100&page=1" | grep '"name": ' | cut -d \" -f4
#
# Important Notes:
#   - Define where you want to clone your repositories
#   - Make this script executable to easily run it. Execute: $ chmod u+x cloneall.sh
#   - You can edit the "_username_repos.txt" file in user path to clone specific repositories.
# ------------------------------------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# | VARIABLES                                                                  |
# ------------------------------------------------------------------------------

user="$2"
page="$3"
dist="$HOME/Dropbox/Github"
file="_${user}_repos_[page_${page}].txt"
line=1


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

# Test whether a directory exists
# $1 - cmd to test
dir_exists() {

    if [ $(-d $1) ]; then
      return 0
    fi
    return 1

}


# ------------------------------------------------------------------------------
# | MAIN FUNCTIONS                                                             |
# ------------------------------------------------------------------------------

# Everybody need some help
call_help() {

cat <<EOT

------------------------------------------------------------------------------
CLONE ALL - Clone user or organization repositories
------------------------------------------------------------------------------

Usage: ./cloneall.sh [option] <username> <page number>
Example: ./cloneall.sh -c vitorbritto 1

Options:
      -h, --help        output help
      -c, --clone       clone repositories

Important:
    If you prefer, create an alias: cloneall="bash ~/path/to/script/cloneall.sh"
    And execute with: cloneall -c vitorbritto 1


Copyright (c) Vitor Britto
Licensed under the MIT license.

------------------------------------------------------------------------------

EOT

}

# Clone repositories
call_clone() {

    # Get repositories
    curl "https://api.github.com/users/${user}/repos?per_page=100&page=${page}" | grep '"name": ' | cut -d \" -f4 > ${file}

    # Show warning message before continue
    e_warning "Before continue, you could edit the generated file to clone specific repositories and then continue."

    # Ask before clone repositories
    seek_confirmation "Would you like to clone repositories now?"

    if is_confirmed; then
        cd ${dist}
        e_header "Initializing..."

        while read line
        do
            name=$line
            git clone git://github.com/$user/$name.git $name
        done < ../$file

        e_success "Repositories cloned successfully!"
    else
        e_error "Aborting..."
        exit 1
    fi

}


# ------------------------------------------------------------------------------
# | INITIALIZE PROGRAM                                                         |
# ------------------------------------------------------------------------------

main() {

    # Show help
    if [[ "${1}" == "-h" || "${1}" == "--help" ]]; then
        call_help ${1}
        exit
    fi

    # Clone repositories
    if [[ "${1}" == "-c" || "${1}" == "--clone" ]]; then
        call_clone ${1}
        exit
    fi

}

# Initialize Clone All Script
main $*
