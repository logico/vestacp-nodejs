# VestaCP with Node.JS support.

Run Node.JS web apps automatically using NGINX reverse proxy, UNIX sockets and PM2.

## Usage.

- PM2 must be installed.
- The app must be copied in `/home/user/web/<domain>/nodeapp/`
- The app entry point must be specify in `package.json` file, with `"main":"<you_init_script.js>"` if your file are not have this entry, script use default one `/home/user/web/domain/nodeapp/app.js`
- The app must listen on a UNIX socket in `/home/user/web/domain/nodeapp/app.sock`
- Upload `NodeJS.tpl`, `NodeJS.stpl`, `NodeJS.sh` to `/usr/local/vesta/data/templates/web/nginx/` or run `install.sh`
- In the control panel, select NodeJS from Proxy Template

![VestaCP](https://logico.com.ar/img/2019/04/21/vestacp_proxy_setup.png)

### Sample

`admin <domain> 127.0.0.1 /home`
`/usr/local/vesta/data/templates/web/nginx/NodeJS.sh admin default 127.0.0.1 /home`

#### Sudo commands

* Remove all instances: `runuser -l <user> -c "pm2 del all"` for admin `runuser -l admin -c "pm2 del all"`
* List all instances: `runuser -l <user> -c "pm2 list"` for admin `runuser -l admin -c "pm2 list"`


#### Documentation

Pm2: [https://pm2.keymetrics.io/docs/usage/quick-start/]