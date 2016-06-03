#!/bin/bash

/usr/bin/supervisord -c /supervisord.conf

mysql -u root -e "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY '' WITH GRANT OPTION;"
