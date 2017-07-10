#!/usr/bin/env bash

sudo apt-get install -y php5-geoip

cd /usr/share/GeoIP
sudo wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz
sudo gunzip GeoLiteCity.dat.gz
sudo mv GeoLiteCity.dat GeoIPCity.dat

