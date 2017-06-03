#!/usr/bin/env bash

if [ ! -e "/etc/php5/apache2/conf.d/xhprof.ini" ]; then
    echo "[vagrant provisioning] Installing xhprof..."
    
    sudo pecl install xhprof-beta 

    sudo echo "extension=xhprof.so" >> /etc/php5/mods-available/xhprof.ini
    sudo echo "xhprof.output_dir=/tmp" >> /etc/php5/mods-available/xhprof.ini
    sudo php5enmod xhprof

    echo "[vagrant provisioning] Installing xhgui..."

    cd /var/www

    git clone https://github.com/perftools/xhgui.git

    cd xhgui

    php install.php
fi


