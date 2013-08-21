# up to you (me) if you want to run this as a file or copy paste at your leisure

sudo -v

# https://rvm.io
# rvm for the rubiess
curl -L https://get.rvm.io | bash -s stable --ruby

# homebrew!
# you need the code CLI tools YOU FOOL.
ruby <(curl -fsSkL raw.github.com/mxcl/homebrew/go)


# https://github.com/rupa/z
# z, oh how i love you
cd ~/code
git clone https://github.com/rupa/z.git
chmod +x ~/code/z/z.sh
# also consider moving over your current .z file if possible. it's painful to rebuild :)
# z binary is already referenced from .bash_profile


# for the c alias (syntax highlighted cat)
easy_install Pygments

# NPM - node modules
npm install -g nave
npm install -g express
npm install -g socket.io

# HOMEBREW - Upgrade PHP version (from 5.3 to 5.4)
brew tap homebrew/dupes
brew tap josegonzalez/homebrew-php
brew install php54 --with-mysql --wihout-apache
brew install php54-memcached php54-apc php54-xdebug
printf "Done!"
printf "\n"
printf "-------------------------------------------------------------------------"
printf "IMPORTANT NOTE\n"
printf "Remember to change the path in your httpd.conf\n"
printf "1. Execute: sudo nano -w /etc/apache2/httpd.conf\n"
printf "2. Change to this:\n"
printf "#LoadModule php5_module libexec/apache2/libphp5.so\n"
printf "LoadModule php5_module /usr/local/opt/php54/libexec/apache2/libphp5.so\n"
printf "-------------------------------------------------------------------------"
printf "\n"
