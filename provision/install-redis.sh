#!/usr/bin/env bash

# install redis server
sudo apt-get -y install redis-server

 # allow external connections
echo "Updating redis configs in /etc/redis/redis.conf."
sudo sed -i "s/.*bind.*/bind 0.0.0.0/" /etc/redis/redis.conf
echo "Updated redis bind address in /etc/redis/redis.conf to 0.0.0.0 to allow external connections."

sudo service redis-server restart


# install phpredis client
sudo apt-get -y install php5-dev

# install phpredis client
sudo pecl install redis

# add module ini
sudo echo 'extension=redis.so' > /etc/php5/mods-available/redis.ini

#enable the module
sudo php5enmod redis