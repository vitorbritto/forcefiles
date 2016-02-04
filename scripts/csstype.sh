#!/usr/bin/env bash

# ------------------------------------------------------------------------------------------------------------
#
# Program: csstype.sh
# Author:  Vitor Britto
# Description: This script convert pre-processors files.
#
# Usage: ./some/path/to/csstype.sh <input type> <output type>
#
# Alias: alias csstype="bash ~/path/to/script/csstype.sh"
#
# Example:
#
#   Convert the current directory from Sass to Stylus
#   $ csstype sass styl
#
# ------------------------------------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# | VARIABLES                                                                  |
# ------------------------------------------------------------------------------

sass2less() {
    for FILE in *."$1"; do
        mv $FILE `basename $FILE ."$1"`."$2";
        if [[ ${FILE: -4} == ".less" ]]; then
            rename 's/ /_/g' *
        fi
    done;
}

less2styl() {
    for FILE in *."$1"; do
        mv $FILE `basename $FILE ."$1"`."$2";
        if [[ ${FILE: -4} == ".less" ]]; then
            rename 's/ /_/g' *
        fi
    done;
}
sass2styl() {
    for FILE in *."$1"; do
        mv $FILE `basename $FILE ."$1"`."$2";
        if [[ ${FILE: -4} == ".less" ]]; then
            rename 's/ /_/g' *
        fi
    done;

}

# ---------------------------------------------
# TO-DO: PARSE USING NPM
# ---------------------------------------------

# less2styl() {
#     # Convert LESS to Stylus using AST
#     # LOCAL: less2stylus "$1"/**/*.less "$1"/styl
# }
# sass2styl() {
#     # LOCAL: sass2stylus "$1"/**/*.scss "$1"/styl
#     curl -F file=@/**/*.scss http://sass2stylus.com/api > styl/
# }
