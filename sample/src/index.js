/*
Author: <Anthony Sychev> (hello at dm211 dot com
index.js (c) 2021
Desc: Sample template for usage 
Created:  2021-12-02T01:09:15.681Z
Modified: !date!
*/

const express = require('express');
const app = express();

const {
	NODE_ENV,
	PORT,
	HOST,
} = process.env;

app.get('*', (req, res) => {
    res.status(200).json({
        status: 200,
        message: "Ok sample done."
    })
});

//run server PORT is parsed by VestaCP for propely run 
app.listen(PORT, () => {
	app.currentServer = {
		host: HOST ? HOST : "127.0.0.1",
		port: PORT,
	};
	console.log(`Server init on: http://:${PORT}`);
});
