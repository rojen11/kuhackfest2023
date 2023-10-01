const path = require("path");
const express = require("express");
const mongoose = require("mongoose");
const reminderRouter = require('./routes/reminders');
const postRouter = require('./routes/posts');
const feedRouter = require('./routes/feed');
const { auth } = require("express-oauth2-jwt-bearer");
const { addNewUser } = require("./middlewares/addNewUser");

require("dotenv").config({
    path:"./.env"
})
global.appRoot = __dirname;

mongoose
.connect("mongodb://127.0.0.1:27017/KUHackFest")
.then(() => console.log("Database connected..."))
.catch((err) => console.log(err.message));
    
const app = express();

const validateAccessToken = auth({
    issuerBaseURL: `https://${process.env.AUTH0_DOMAIN}`,
    audience: process.env.AUTH0_AUDIENCE,
});
app.use(express.json());
// Protected API endpoints
app.use(validateAccessToken);
app.use(addNewUser);
app.use('/feed', feedRouter);
app.use('/reminders', reminderRouter);
app.use('/posts', postRouter);

app.listen(process.env.PORT, ()=>{
    console.log(`Server is running at port ${process.env.PORT}...`);
});