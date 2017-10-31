# CORS on Apache

To add the CORS authorization to the header using Apache, simply add the following line inside either the <Directory>, <Location>, <Files> or <VirtualHost> sections of your server config (usually located in a *.conf file, such as httpd.conf or apache.conf), or within a .htaccess file:

```
Header set Access-Control-Allow-Origin "*"
```

Altering headers requires the use of mod_headers. Mod_headers is enabled by default in Apache, however, you may want to ensure it's enabled by run

```
sudo a2enmod headers
```


