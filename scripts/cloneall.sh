#!/usr/bin/env bash

# ------------------------------------------------------------------------------
#
# Program: cloneall.sh
# Author:  Vitor Britto
#
# Description:
#   This script is a shortcut to clone all repositories
#   from a specific user or organization
#
#
# Usage: ./cloneall.sh
# Alias: cloneall="bash ~/path/to/script/cloneall.sh"
#
# Important:
#       First of all, define where you want to save your backup
#       then make this script executable to easily run it.
#       $ chmod u+x cloneall.sh
#
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# | VARIABLES                                                                  |
# ------------------------------------------------------------------------------

user="vitorbritto"
dist="$HOME/Dropbox/Github"
repos=(
    "angularjs-studies-todo"
    "beep"
    "biosys"
    "blog"
    "boilerplates"
    "bunker"
    "date-stylish"
    "dev-list"
    "forcefiles"
    "gocaniuse"
    "golang-book"
    "gomdn"
    "gone"
    "gow3c"
    "gruntify"
    "gruntnator"
    "guardian"
    "gulpify"
    "gulpnator"
    "howtostart"
    "i-am-your-father"
    "just"
    "labs"
    "magnetojs"›
    "makefy"
    "managers"
    "markupify"
    "nexus"
    "node-managers"
    "node-skeleton"
    "octolist"
    "optimus"
    "orphanage"
    "papoy"
    "PDFify"
    "pixmap"
    "redux"
    "robotscripts"
    "ruby-skeleton"
    "setup-emacs"
    "setup-subl"
    "setup-vagrant"
    "setup-vim"
    "simhelp"
    "simlog"
    "skeleton"
    "sparkle"
    "sublime-devdocs"
    "tictac"
    "tictac-app"
    "unics"
    "unixify"
    "whotofollow"
    "workflow-guide"
    "yoda"
)


# ------------------------------------------------------------------------------
# | INITIALIZE CLONE                                                           |
# ------------------------------------------------------------------------------

cd ${dist}
echo "→ Clonning..."

for repo in "${repos[@]}"
do
    git clone git://github.com/$user/$repo.git $repo
done

echo -n "✔ done!"
