#!/usr/bin/env bash

# ------------------------------------------------------------------------------
#
# Program: initpost.sh
# Author:  Vitor Britto
# Description: script to create an initial structure for my posts.
#
# Usage: ./initpost.sh [options] <category> <post name>
#
# Options:
#   -h, --help        output instructions
#   -c, --create      create post
#
# Alias: alias ipost="bash ~/path/to/script/initpost.sh"
#
# Example:
#   ./initpost.sh -c TIP How to replace strings with sed
#
# Important Notes:
#   - This script was created to generate new text files to my blog.
#
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# | VARIABLES                                                                  |
# ------------------------------------------------------------------------------

POST_TITLE="${@:3:$(($#-2))}"
POST_NAME="$(echo ${@:3:$(($#-2))} | sed -e 's/ /-/g' | sed "y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/")"
DIST_FOLDER="$HOME/Dropbox/ARQUIVOS/DOCS/Drafts"
CURRENT_DATE="$(date +'%Y-%m-%d')"
FILE_NAME="${CURRENT_DATE}-[${2}]-${POST_NAME}.md"
FULL_PATH="${DIST_FOLDER}/${FILE_NAME}"


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

# Everybody need some help
initpost_help() {

cat <<EOT

------------------------------------------------------------------------------
INIT POST - A shortcut to create an initial structure for my posts.
------------------------------------------------------------------------------

Usage: ./initpost.sh [options] <category> <post name>

Options:
  -h, --help        output instructions
  -c, --create      create post

Example:
  ./initpost.sh -c TIP How to replace strings with sed

Important Notes:
  - This script was created to generate new text files to my blog.


Copyright (c) Vitor Britto
Licensed under the MIT license.

------------------------------------------------------------------------------

EOT

}

# Initial Content
initpost_content() {

echo "---"
echo "layout: post"
echo "title: \"${POST_TITLE}\""
echo "link: \"http://vitorbritto.com/blog/${POST_NAME}\""
echo "date: ${CURRENT_DATE}"
echo "cover: \"assets/images/posts/post-${POST_NAME}.jpg\""
echo "description:"
echo "comments: true"
echo "avatar: \"assets/images/avatar.jpg\""
echo "author: Vitor Britto"
echo "bio: Desenvolvedor Web e Designer, extremamente apaixonado pelo seu trabalho. Descobriu o mundo dos códigos há quase duas decádas e mantém a mesma paixão desde o primeiro dia dessa descoberta. Trabalha como freelancer full time há quase 4 anos desenvolvendo projetos voltados para a web. Também direciona boa parte do seu tempo para pesquisas, projetos colaborativos, desenvolvimento de projetos pessoais e escrever os artigos aqui publicados."
echo "---"

}

# Create file
initpost_file() {

    if [ ! -f "$FILE_NAME" ]; then
        e_header "Creating initial model..."
        initpost_content > "$FULL_PATH"
        e_success "Initial post created successfully!"
    else
        e_warning "File already exist."
        exit 1
    fi

}


# ------------------------------------------------------------------------------
# | INITIALIZE PROGRAM                                                         |
# ------------------------------------------------------------------------------

main() {

    # Show help
    if [[ "${1}" == "-h" || "${1}" == "--help" ]]; then
        initpost_help ${1}
        exit
    fi

    # Create
    if [[ "${1}" == "-c" || "${1}" == "--create" ]]; then
        initpost_file $*
        exit
    fi

}

# Initialize
main $*

