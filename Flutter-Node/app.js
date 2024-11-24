const express = require('express');
const body_parser = require('body-parser');
const cors = require('cors');

const app = express();

const userRouter = require('../Flutter-Node/routers/user.router');
const childRouter = require('../Flutter-Node/routers/child.router');

app.use(express.json());
app.use(cors());
app.use(body_parser.json());

app.use('/',userRouter);
app.use('/',childRouter);

module.exports = app;