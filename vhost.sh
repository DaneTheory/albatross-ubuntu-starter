#!/bin/bash
# This script is used to create virtual hosts.
echo "Enter your linux username"
read un
echo "choose the name of your project NOTE:It helps in overall organization to name it the same as your example.com project"
read projectdir
echo "Enter ServerName (domain.com, microsoft.com, ubuntu.org"
read sn
echo "Enter ServerAlias (www.domain.com, dev.microsoft.com, whatever.ubuntu.org BUT DO NOT INCLUDE THE DOMAIN, JUST ALIAS PREFIX"
read $cool
echo "To install the site:"
echo "  drush site-install standard --db-url=mysql://root:pass@localhost/test --sites-subdir=$projectdir"

# Set the owner and change permissions
sudo chown -R $un:www-data /var/www/$projectdir
sudo chmod -R '750' $projectdir

# Creation the file with VirtualHost configuration in /etc/apache2/site-available/
sudo echo "
<VirtualHost *:80>
  ServerAdmin webmaster@localhost
  DocumentRoot "/var/www/$projectdir"
  ServerName $sn
  ServerAlias $cool.$sn
  <Directory "/var/www/$projectdir">
    Options Indexes FollowSymLinks
    AllowOverride All
    Order allow,deny
    Allow from all
  </Directory>
  ErrorLog /var/www/$projectdir/logs/error.log
  LogLevel warn
  CustomLog /var/www/$projectdir/logs/access.log combined
  <IfModule mpm_peruser_module>
    ServerEnvironment apache apache
  </IfModule>
</VirtualHost>
" > /etc/apache2/sites-available/$sn


# Add the host to the hosts file
sudo echo 127.0.0.1 $cool.$sn >> /etc/hosts
#sudo echo 23.92.28.191 $cool.$sn >> /etc/hosts       <----TODO: Figure out how to call in FQDN IP Address and replacethat for where 127.0.0.1 is

# Enable the site
sudo a2ensite $sn

# Reload Apache2
sudo /etc/init.d/apache2 reload
sudo service apache2 restart

