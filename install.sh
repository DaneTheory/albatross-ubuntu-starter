#!/bin/bash

# LAMP with xdebug
sudo apt-get install -y apache2 php5-xdebug php5-dev php5-mysql php5-gd mysql-server libapache2-mod-php5 php5-curl php5-imagick php5-ffmpeg php5-cli php5-mcrypt php5-imap php-pear
sudo a2enmod rewrite
sudo service apache2 restart

#Install MariaDB Repositories
sudo apt-get install python-software-properties
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
sudo add-apt-repository 'deb http://mirror.jmu.edu/pub/mariadb/repo/10.0/ubuntu precise main'

#Install MariaDB Server
sudo apt-get update
sudo apt-get install mariadb-server

# drush
pear channel-discover pear.drush.org
pear install drush/drush

# install latest node.js
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install nodejs

# install grunt and dependancies
sudo npm install -g grunt
sudo npm install -g grunt-cli
sudo npm install

# meteor (node.js framework)
sudo wget https://install.meteor.com -O meteor.sh
sudo bash meteor.sh

# set up workspace
sudo mkdir -p /var/www/RENAMEME.com
sudo mkdir -p /var/www/RENAMEME.com/logs
cp vhost.sh /etc/apache2/sites-available/vhost.sh

echo
echo "To install a new site:"
echo "  cd /var/www"
echo "  sudo nano RENAMEME.com to the new site domain name"
echo "  cd into your new domain file"
echo "  drush dl --drupal-project-rename=test"
echo "  cd test"
echo "  drush site-install standard --db-url=mysql://root:pass@localhost/test --sites-subdir=test.test"
echo "  sudo bash vhost.sh"



