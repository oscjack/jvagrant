#!/usr/bin/env bash

if [ ! -e "/usr/bin/mongo" ]; then
    echo "[vagrant provisioning] Installing mongodb..."

    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927

    echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

    sudo apt-get update

    #This is to install the latest stable version
    sudo apt-get install -y mongodb

    #php 5 mongodb driver
    sudo pecl install mongodb

    sudo su
    echo "extension=mongodb.so" >> /etc/php5/mods-available/mongodb.ini

    ln -s /etc/php5/mods-available/mongodb.ini /etc/php5/apache2/conf.d/20-mongodb.ini

    php5enmod mongodb
fi


#run following command in the virtual machine to set index
#$ mongo

#> use xhprof
#db.results.ensureIndex( { 'meta.SERVER.REQUEST_TIME' : -1 } )
#db.results.ensureIndex( { 'profile.main().wt' : -1 } )
#db.results.ensureIndex( { 'profile.main().mu' : -1 } )
#db.results.ensureIndex( { 'profile.main().cpu' : -1 } )
#db.results.ensureIndex( { 'meta.url' : 1 } )





