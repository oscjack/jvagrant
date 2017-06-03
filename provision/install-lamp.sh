#!/usr/bin/env bash

# Use single quotes instead of double quotes to make it work with special-character passwords
PATH_APACHE='/usr/sbin/apache2'

if [ ! -e "$PATH_APACHE" ]; then
    # update / upgrade
    sudo apt-get update
    sudo apt-get -y upgrade

    # install apache 2.5
    sudo apt-get install -y apache2

    #enable apache module rewrite
    sudo a2enmod rewrite && sudo service apache2 restart

    # php and modules
    sudo apt-get install -y php5
    sudo apt-get install -y php-pear
    sudo apt-get install -y imagemagick
    sudo apt-get install -y php5-imagick
    sudo apt-get install -y php5-curl
    sudo apt-get install -y php5-gd
    sudo apt-get install -y php5-mcrypt

    # enable php modules
    sudo php5enmod mcrypt

    # install mysql and give password to installer
    sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
    sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"
    sudo apt-get install -y  --force-yes mysql-server
    sudo apt-get install -y --force-yes php5-mysql

    mysqladmin -uroot -proot password ''

    # mysql - allow external connections
    echo "Updating mysql configs in /etc/mysql/my.cnf."
    sudo sed -i "s/.*bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
    echo "Updated mysql bind address in /etc/mysql/my.cnf to 0.0.0.0 to allow external connections."

    echo "Assigning mysql user admin access on %."
    sudo mysql -uroot --execute "CREATE USER 'admin'@'%' IDENTIFIED BY 'admin';"
    sudo mysql -uroot --execute "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' IDENTIFIED BY 'admin' with GRANT OPTION; FLUSH PRIVILEGES;"
    echo "Assigned mysql user root access on all hosts."

    sudo service mysql stop
    sudo service mysql start
fi

