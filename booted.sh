#!/bin/sh

#Could not reliably determine the server's fully qualified domain name
if [ $(grep -c "ServerName localhost" /etc/apache2/apache2.conf) -eq 0 ]
then
        sudo su
        echo "ServerName localhost" >> /etc/apache2/apache2.conf
fi

#restart apache again to ensure the virtural host added will work as espected
sudo service apache2 restart
