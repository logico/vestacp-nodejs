#!/bin/bash

user=$1
domain=$2
ip=$3
home=$4
docroot=$5

mkdir "$home/$user/web/$domain/nodeapp"
chown -R $user:$user "$home/$user/web/$domain/nodeapp"
rm "$home/$user/web/$domain/nodeapp/app.sock"
runuser -l $user -c "pm2 start $home/$user/web/$domain/nodeapp/app.js"
sleep 5
chmod 777 "$home/$user/web/$domain/nodeapp/app.sock"
