#!/usr/bin/env bash

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


# SETTINGS
# -------------------------------------------------------

DBUSER=root
DBPASS=root
DBHOST=localhost
DBNAME=$1
DBEMAIL=$2



# EXECUTE SCRIPT
# -------------------------------------------------------

# Access
e_header "Accessing MySQL..."
mysql --user=${DBUSER} -p${DBPASS}

# Create
e_header "Creating Database..."
create database ${DBNAME};
e_success "Database ${DBNAME} successfully created!"

# Privileges
e_header "Grantting privileges for user ${DBNAME}..."
GRANT usage ON *.* TO ${DBEMAIL} IDENTIFIED BY ${DBPASS};
GRANT CREATE, DROP, SELECT, INSERT, UPDATE, DELETE ON ${DBNAME}.* TO ${DBEMAIL};
flush privileges;
e_success "Privileges for ${DBUSER} successfully granted!"

# View Table
e_header "Rendering data..."
mysql -u ${DBUSER} -e "show tables" ${DBNAME}
