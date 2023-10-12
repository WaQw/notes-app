const express = require('express');
const fs = require('fs');

const app = express();

app.get('/notes', (req, res) => {
    fs.readFile(`${__dirname}/notes.json`, 'utf-8', (err, data) => {
        if(err) {
            return console.log(err);
        }
        res.send(data);
    })
})

app.listen(3000, () => {
    console.log("Server is up on port 3000");
})