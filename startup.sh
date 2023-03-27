#! /bin/bash

cd /var/html/auth-service
pm2 start pm2.json   

cd /var/html/media-service
pm2 start pm2.json 

pm2 status
pm2 logs
