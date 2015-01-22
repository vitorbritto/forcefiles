#!/usr/bin/env bash

# ------------------------------------------------------------------------------
#
# Program: nexus.sh
# Author:  Vitor Britto
#
# Description:
#       Nexus is a simple and fast method to start a web server
#
# Important:
#       Make this script executable to easily run it.
#       $ chmod u+x nexus.sh
#
# Usage:
#       ./nexus.sh [options]
#
# Options:
#       --php           start a webserver with PHP
#       --py            start a webserver with Python
#       --help, -h      output instructions
#
# Example:
#       Start a PHP webserver
#       $ ./nexus.sh --php
#
# Alias:
#       alias nexus="bash ~/path/to/script/nexus.sh"
#
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# | FUNCTIONS                                                                  |
# ------------------------------------------------------------------------------

# Help Function
nexus_help() {

cat <<EOT

------------------------------------------------------------------------------
NEXUS - Simple and fast method to start a web server
------------------------------------------------------------------------------

Usage:
    ./nexus.sh [options]

Example:
    Start a PHP webserver
    $ ./nexus.sh --php

Options:
    --php           start a webserver with PHP
    --py            start a webserver with Python
    --help, -h      output instructions

Documentation can be found at https://github.com/vitorbritto/nexus/

Copyright (c) Vitor Britto
Licensed under the MIT license.

------------------------------------------------------------------------------

EOT

}

# Start an HTTP server with Python
nexus_python() {

    echo "HINT: Press CTRL+C to stop webserver"
    sleep 1 && open "http://localhost:8000/"
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();'

}

# Start an HTTP server with PHP
nexus_php() {

    local IP=$(ipconfig getifaddr en1)
    echo "HINT: Press CTRL+C to stop webserver"
    sleep 1 && open "http://${IP}:4000/"
    php -S "${IP}:4000"

}

# Set Main Function
nexus_main() {

    if [[ "${1}" == "--php" ]]; then
        nexus_php
        exit
    fi

    if [[ "${1}" == "--py" ]]; then
        nexus_python
        exit
    fi

    # List Classes
    if [[ "${1}" == "-h" || "${1}" == "--help" ]]; then
        nexus_help
        exit
    fi

}

# Initialize Nexus
nexus_main $*
