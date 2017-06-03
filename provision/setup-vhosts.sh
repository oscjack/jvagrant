#!/usr/bin/env bash

SITE_PATH="/etc/apache2/sites-available/$1.conf"

BLOCK="
<VirtualHost *:80>
    ServerName $1
    ServerAlias www.$1

    ServerAdmin webmaster@localhost
    DocumentRoot $2

    ErrorLog /var/log/apache2/${1}.error.log
    CustomLog /var/log/apache2/${1}.access.log combined

    <Directory "$2">
         Options Indexes FollowSymLinks MultiViews
         AllowOverride All
         Order deny,allow
         Allow from all
         Require all granted
    </Directory>
</VirtualHost>
"

echo "$BLOCK" > "/etc/apache2/sites-available/$1.conf"

ln -fs "/etc/apache2/sites-available/$1.conf" "/etc/apache2/sites-enabled/$1.conf"

