#!/usr/bin/env bash

# ------------------------------------------------------------------------------------------------------------
#
# Program:      gone.sh
# Author:       Vitor Britto
# Description:  This script is a shortcut to deployments
#
# Usage:        ./gone.sh [options]
# Example:      ./gone.sh -f
#
# Options:
#       --help, -h           output help instructions
#       --ftp, -f            deploy to FTP
#       --git, -g            push to GitHub or Bitbucket
#
# Important:
#     If you prefer, create an alias: gone="bash ~/path/to/script/gone.sh"
#     And execute with: gone -u http://www.vitorbritto.com.br -r 5
#
# Copyright (c) Vitor Britto
# Licensed under the MIT license.
# ------------------------------------------------------------------------------------------------------------


# TODO
# -----------------------------------------------
# DEPLOY TO BITBUCKET OR GIT
# DEPLOY TO HOST (USING FTP OR SSH/RSYNC)


# PROCESS
# -----------------------------------------------
# 1. MAKE CHANGES
# 2. COMMIT
# 3. PUSH TO REMOTE REPOSITORY
# 4. DEPLOY TO HOST (USING FTP OR RSYNC)

# CHECKS
# -----------------------------------------------
# WHICH GIT
# WHICH FTP
# WHICH RSYNC
