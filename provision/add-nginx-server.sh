#!/usr/bin/env bash

if [ -n "$1" ]; then
cat > "/etc/nginx/sites-available/$1" <<EOF
server {
    listen 80 ;

    root $2;
    index index.html index.htm index.php;

    server_name $1 www.$1;

    location / {
        try_files \$uri \$uri/ =404;
    }

    #error_page 404 /404.html;

    # redirect server error pages to the static page /50x.html
    #
    #error_page 500 502 503 504 /50x.html;
    #location = /50x.html {
    #   root /usr/share/nginx/html;
    #}

    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    location ~ \.php\$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
    #   # NOTE: You should have "cgi.fix_pathinfo = 0;" in php.ini
    #
    #   # With php5-cgi alone:
    #   fastcgi_pass 127.0.0.1:9000;
    #   # With php5-fpm:
        fastcgi_pass unix:/var/run/php5-fpm.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }
}
EOF


ln -fs "/etc/nginx/sites-available/$1" "/etc/nginx/sites-enabled/$1"
fi
