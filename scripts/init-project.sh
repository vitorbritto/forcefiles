# Shell Script for Initialize a new project (based on my needs)
# run with alias "letsrock"

# ====================================================
#  WORK IN PROGRESS
# ====================================================
#
# ------------------
# Project Structure
# ------------------
#
#    ./
#    ├── .editorconfig
#    ├── .gitignore
#    ├── assets/
#    │   │   css/
#    │   │   fonts/
#    │   │   images/
#    │   │   ├── icons/
#    │   │   └── libs/
#    │   │   js/
#    │   │   ├── main.js
#    │   │   └── vendor/
#    │   │   sass/
#    │   │   ├── general/
#    │   │   │   ├── base/
#    │   │   │   ├── grid/
#    │   │   │   ├── layout/
#    │   │   │   └── responsive/
#    │   │   ├── modules/
#    │   │   │   ├── addons/
#    │   │   │   ├── functions/
#    │   │   │   └── mixins/
#    │   │   ├── objects/
#    │   │   ├── _defaults.scss
#    │   │   ├── _project.scss
#    │   │   ├── _variables.scss
#    │   │   ├── print.scss
#    │   │   └── style.scss
#    ├── ie/
#    ├── src/
#    │   ├── .bowerrc
#    │   ├── .jshintrc
#    │   ├── .ftppass [for deploy]
#    │   ├── bower.json
#    │   ├── capture.js
#    │   ├── config.rb
#    │   ├── Gruntfile.js
#    │   ├── package.json
#    │   └── README.md
#    ├── 404.php
#    ├── htaccess.txt
#    ├── humans.txt
#    ├── index.php
#    ├── README.md
#    └── robots.txt
#
# ====================================================

BOILERPLATE_DIRECTORY="${HOME}/Sites/boilerplate"
BOILERPLATE_TARBALL_PATH="https://github.com/vitorbritto/boilerplate/tarball/master"
BOILERPLATE_GIT_REMOTE="https://github.com/vitorbritto/boilerplate"

# If missing, download and extract the boilerplate repository
if [[ ! -d ${BOILERPLATE_DIRECTORY} ]]; then
    printf "$(tput setaf 7)Downloading boilerplate...\033[m\n"
    mkdir ${BOILERPLATE_DIRECTORY}
    # Get the tarball
    curl -fsSLo ${HOME}/boilerplate.tar.gz ${BOILERPLATE_TARBALL_PATH}
    # Extract to the boilerplate directory
    tar -zxf ${HOME}/boilerplate.tar.gz --strip-components 1 -C ${BOILERPLATE_DIRECTORY}
    # Remove the tarball
    rm -rf ${HOME}/boilerplate.tar.gz
fi

# Call utils
source ./lib/utils

# Declare my local variables
local app=$@

# This guy will rename the project name for what I want
rename_project() {
    echo "Please enter a name for this project (e.g: my-new-project):"
    read -a $app
    mv -f -v boilerplate $app && cd $app
}

# It will open my editor
open_project() {
    e_header "Opening your editor..."
    subl .
    [[ $? ]] && e_success "Done!"
}

# And finally, we initialize the server (or remote server)
run_project() {

    # Ask for remote server
    seek_confirmation "Do you want to run a remote server?"

    if is_confirmed; then

        seek_confirmation "Do you want to run cross-devices testing?"

        if is_confirmed; then
            # Using localtunnel for cross-devices testing
            localtunnel -k ~/.ssh/id_rsa.pub 8080
            localtunnel 8000
            e_success "Done! Use the generated url to run your cross-devices testing."
        else
            # Using PHP Web Server
            e_header "Please, wait..."
            php -S 0.0.0.0:8000
            e_success "Remote server OK! Redirecting you..."
            open "http://0.0.0.0:8000"
        fi

    else
        e_header "Starting local server..."
        cd ~/Sites && php -S localhost:8000 -t ${app}/
        open "http://localhost/${app}:8000"
    fi
}

# Let's rock!
rename_project
open_project
run_project