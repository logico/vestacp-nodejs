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

nodeVersion=""
nvmDir="/opt/nvm"
nodeInterpreter=""
envFile=""

#if are installed .nvm on the system
if [ -d "$nvmDir" ]; then
    
    #check files .naverc .node-version .nvm
    if [ -f "$nodeDir/.nvm" ]; then
        nodeVersion=$(cat $nodeDir/.nvm)
    elif [ -f "$nodeDir/.node-version" ]; then
        nodeVersion=$(cat $nodeDir/.node-version)
    fi

    echo "Needs Node version: $nodeVersion"

    export NVM_DIR="/opt/nvm/"
    source "$NVM_DIR/nvm.sh"

    if [ ! -d "/opt/nvm/versions/node/$nodeVersion" ]; then
        echo "Install this version"
        nvm install $nodeVersion

        chmod -R 777 /opt/nvm
    else
        echo "Error on install Node version on NVM"
    fi

    nodeInterpreter="--interpreter /opt/nvm/versions/node/$nodeVersion/bin/node"
fi

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

#apply enviroment variables from .env file
if [ -f "$nodeDir/.env" ]; then
    echo ".env file in folder, applying"
    envFile=$(grep -v '^#' $nodeDir/.env | xargs)
fi

#remove blank spaces
pmPath=$(echo "$nodeDir/$mainScript" | tr -d ' ')
runuser -l $user -c "$envFile PWD=$nodeDir NODE_ENV=production pm2 start $pmPath --name $scriptName $nodeInterpreter"

sleep 5
chmod 777 "$nodeDir/app.sock"