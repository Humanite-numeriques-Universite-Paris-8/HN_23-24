const express = require('express');
const request = require('request');
const app = express();

app.use((req, res, next) => {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});

app.get('/proxy', (req, res) => {
    const url = req.query.url;
    req.pipe(request(url)).pipe(res);
});

app.listen(3000, () => {
    console.log('Proxy CORS actif sur le port 3000');
});
