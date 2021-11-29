#!/bin/bash

if ! command -v pm2 &>/dev/null; then
    echo "pm2 not installed"
    npm install -g pm2
fi

if [ ! -f ~/.nvm/nvm.sh ]; then
    # May need to be updated with the latest nvm release
    wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash


    mv ~/.nvm /opt/nvm
    chmod -R 777 /opt/nvm
    
    echo "-> Add this lines to the end your ~/.bashrc file"
    echo 'export NVM_DIR="/opt/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion'
    echo "-----"

    source /opt/nvm/nvm.sh
fi



cp -R ./NodeJS.* /usr/local/vesta/data/templates/web/nginx/