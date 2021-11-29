#!/bin/bash

user=$1
domain=$2
ip=$3
home=$4
docroot=$5

#default script name
mainScript="app.js"
nodeDir="$home/$user/web/$domain/nodeapp"

mkdir $nodeDir
chown -R $user:$user $nodeDir

#auto install dependences
if [ ! -d "$nodeDir/node_modules" ]; then
    echo "No modules found."
    cd $nodeDir && npm i
fi

#get init script form package.json
package="$nodeDir/package.json"

if [ -e $package ]
then
    mainScript=$(cat $package \
                | grep main \
                | head -1 \
                | awk -F: '{ print $2 }' \
                | sed 's/[",]//g' \
                | sed 's/ *$//g')

    scriptName=$(cat $package \
                | grep name \
                | head -1 \
                | awk -F: '{ print $2 }' \
                | sed 's/[",]//g' \
                | sed 's/ *$//g')
fi

rm "$nodeDir/app.sock"
runuser -l $user -c "pm2 del $scriptName"

#remove blank spaces
pmPath=$(echo "$nodeDir/$mainScript" | tr -d ' ')
runuser -l $user -c "pm2 start $pmPath --name $scriptName"

sleep 5
chmod 777 "$nodeDir/app.sock"