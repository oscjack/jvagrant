#!/bin/bash

#create new user
CREATE USER 'jeffrey'@'localhost' IDENTIFIED BY 'new_password';

#To give the user access to the database from any host, type the following command:

grant select on database_name.* to 'read-only_user_name'@'%' identified by 'password';

#If the collector will be installed on the same host as the database, type the following command:

grant select on database_name.* to 'read-only_user_name' identified by 'password';

#This command gives the user read-only access to the database from the local host only.

#If you know the host name or IP address of the host that the collector is will be installed on, type the following command:

grant select on database_name.* to 'read-only_user_name'@'host_name or IP_address' identified by 'password';