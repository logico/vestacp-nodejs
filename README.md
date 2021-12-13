# VestaCP with Node.JS support.

With this repo you can run multiples NodeJs Apps at some time.
This template read `.env` file, `.nvm` for Node version, and `package.json` for get info and auto install modules.

![VestaCP](https://logico.com.ar/img/2019/04/21/vestacp_proxy_setup.png)

## Instalation

***Auto "With Script":***
* First download this Git in your `home` directory and run `chmod +x ./install.sh`, `./install.sh`. Script auto install `NVM` and `PM2` 

***Manually:***
* Install PM2 `npm i pm2@latest -g`
* Install NVM see [https://nvm.sh]
* Upload `NodeJS.tpl`, `NodeJS.stpl`, `NodeJS.sh` to `/usr/local/vesta/data/templates/web/nginx/`

## WHERE DEPLOY MY APP?

In VestaCp the user must be a enabled `bash` ssh, if set as `none` this si a cause to stack.
Upload your app with ssh on this path: `/home/<user>/web/<domain>/nodeapp/`.
Here you can use files `.env` with Enviroment variables, `.nvm` or `.node-version` for specify NodeJs version.

In your `package.json` you can specify your index file with 
```js
    ...
    "main": "index.js",
    ...
```

In your `index.js` you need run the express server or http with this parameters:
```js
    ...
    //PORT IS PARSET WITH ENV VARIABLE FOR PROPER RUN IF YOU DON'T SET YOUR APP IS CRASH OR NOT RUN!!
    app.listen(process.env.PORT); 
    ...
```
When your app is launched script create UNIX socket file in `/home/<user>/web/<domain>/nodeapp/app.sock` is set with 0777 permisses for allow access to NGINX.

## DEBUG

Each launch will be copied two logs files `<domain-name>-error.log` and `<domain-name>-out.log` to the `nodeapp` folder.

## BLANK PAGES "NODE DOWN"

When your app is down create simply html file in public folder `/home/<user>/web/<domain>/public_app/index.html`.

### FAQ

* How can restart app?: Select Proxy template as `default` click save button, select NodeJs template option and click save again.
* How I can check if my app is running?: in nodeapp folder run `ls -l` and see if exist `app.sock` file, if yes, run `runuser -l <user> -c "pm2 list"` or `runuser -l <user> -c "pm2 monit"`
* My app is not running, why?: Check setting of user account and set `bash` ssh. 

### Samples

For debug propose you can run script with this arguments `NodeJS.sh <user> <domain> 127.0.0.1 /home` full command: `/usr/local/vesta/data/templates/web/nginx/NodeJS.sh admin default 127.0.0.1 /home`

* ***Remove all instances***: `runuser -l <user> -c "pm2 del all"` for admin `runuser -l admin -c "pm2 del all"`
* ***List all instances***: `runuser -l <user> -c "pm2 list"` for admin `runuser -l admin -c "pm2 list"`
* ***Show monitor of instances***: `runuser -l <user> -c "pm2 monit"` for admin `runuser -l admin -c "pm2 monit"`

#### Documentation

Pm2: [https://pm2.keymetrics.io/docs/usage/quick-start/]
Info about NGINX Proxy [https://serverfault.com/questions/316157/how-do-i-configure-nginx-proxy-pass-node-js-http-server-via-unix-socket]

