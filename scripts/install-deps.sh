# up to you (me) if you want to run this as a file or copy paste at your leisure

# Upgrade PHP5.3 -> PHP 5.4
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


# https://github.com/rupa/z
# z, oh how i love you
cd ~/code
git clone https://github.com/rupa/z.git
chmod +x ~/code/z/z.sh
# also consider moving over your current .z file if possible. it's painful to rebuild :)


# z binary is already referenced from .bash_profile

# for the c alias (syntax highlighted cat)
sudo easy_install Pygments