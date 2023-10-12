const express = require('express');
const fs = require('fs');
require('./db/mongoose')
const Note = require('./models/notes')

const app = express();
app.use(express.json());

app.get('/notes', (req, res) => {
    fs.readFile(`${__dirname}/notes.json`, 'utf-8', (err, data) => {
        if(err) {
            return console.log(err);
        }
        res.send(data);
    })
})

app.post('/notes', async (req, res) => {
    const note = new Note(req.body);
    try {
        await note.save();
        res.status(200).send(note);
    } catch (error) {
        res.status(400).send(error);
    }
})

app.listen(3000, () => {
    console.log("Server is up on port 3000");
})