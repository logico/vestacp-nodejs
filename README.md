# VestaCP with Node.JS support.

Run Node.JS web apps automatically using NGINX reverse proxy, UNIX sockets and PM2.

## Usage.

- PM2 must be installed.
- The app must be installed in `/home/user/web/domain/nodeapp/`
- The app entry point must be `/home/user/web/domain/nodeapp/app.js`
- The app must listen on a UNIX socket in `/home/user/web/domain/nodeapp/app.sock`
- Upload `NodeJS.tpl`, `NodeJS.stpl`, `NodeJS.sh` to `/usr/local/vesta/data/templates/web/nginx/`
- In the control panel, select NodeJS from Proxy Template

![VestaCP](https://logico.com.ar/img/2019/04/21/vestacp_proxy_setup.png)