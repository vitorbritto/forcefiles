#!/usr/bin/env bash

# ------------------------------------------------------------------------------------------------------------
#
# Program: sshkey.sh
# Author:  Vitor Britto
# Description: This script is a shortcut to create a SSH Key
#
# Usage: ./sshkey.sh [options] <email> <host>
#
# Options:
#   -h, --help        output instructions
#   -c, --create      create a new SSH key
#
# Alias: alias ssk="bash ~/path/to/script/sshkey.sh"
#
# Example:
#   ./sshkey.sh [options] <email> <host>
#   ssk -c email@domain.com git@github.com
#
#
# Important Notes:
#   - Make this script executable to easily run it. Execute: $ chmod u+x sshkey.sh
# ------------------------------------------------------------------------------------------------------------


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



# ------------------------------------------------------------------------------
# | MAIN FUNCTIONS                                                             |
# ------------------------------------------------------------------------------

# Everybody need some help
call_help() {

cat <<EOT

------------------------------------------------------------------------------
SSH KEY - Create a SSH Key
------------------------------------------------------------------------------

Usage: ./sshkey.sh [options] <email> <host>

Options:
  -h, --help        output instructions
  -c, --create      create a new SSH key

Example:
  ./sshkey.sh [options] <email> <host>

Important:
    If you prefer, create an alias ssk="bash ~/path/to/script/sshkey.sh"
    And execute with: ssk -c email@domain.com git@github.com


Copyright (c) Vitor Britto
Licensed under the MIT license.

------------------------------------------------------------------------------

EOT

}

# Generate SSH Key
call_generate() {

    # Creates a new ssh key, using the provided email as a label
    e_header "Creating new SSH Key"
    ssh-keygen -t rsa -C "$2"
    && e_success "SSH Key successfully created!"

    # start the ssh-agent in the background
    e_header "Starting the SSH Agent"
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa
    && e_success "SSH Agent successfully started!"

    # Copies the contents of the id_rsa.pub file to your clipboard
    e_header "Copying the SHH Key contents"
    pbcopy < ~/.ssh/id_rsa.pub
    && e_success "Public SHH Key contents successfully copied!"

    # Ask before continue
    seek_confirmation "Please, copy the SSH Key on your host before continue."

    if is_confirmed; then
        e_header "Testing your SSH Key..."
        ssh -T "$3"
        e_success "Everything is working!"
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
    if [[ "${1}" == "-c" || "${1}" == "--create" ]]; then
        call_generate ${1}
        exit
    fi

}

# Initialize Script
main $*
