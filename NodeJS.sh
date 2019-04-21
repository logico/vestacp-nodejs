#!/bin/bash

user=$1
domain=$2
ip=$3
home=$4
docroot=$5

rm "$home/$user/web/$domain/nodeapp/app.sock"
runuser -l $user -c "NODE_ENV=production pm2 restart $home/$user/web/$domain/nodeapp/app"
sleep 5
chmod a+w "$home/$user/web/$domain/nodeapp/app.sock"

