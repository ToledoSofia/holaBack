const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');


const app = express();

app.use(cors());
app.use(bodyParser.json());
app.get('/', function (req, res, next) {
    res.status(200).json({ message: 'Welcome to Express!' });
  });

module.exports = app;
