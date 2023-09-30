const path = require("path");
const express = require("express");
const mongoose = require("mongoose");
const { auth } = require("express-oauth2-jwt-bearer");
const { addNewUser } = require("./middlewares/addNewUser");
const reminderRouter = require("./routes/reminders");
const postRouter = require("./routes/posts");

require("dotenv").config({
    path:"./.env"
})
global.appRoot = __dirname;

mongoose
.connect("mongodb://127.0.0.1:27017/KUHackFest")
.then(() => console.log("Database connected..."))
.catch((err) => console.log(err.message));
    
const app = express();

const newUser = (req, res, next) => {
    console.log(req.auth)
    next();
}

const validateAccessToken = auth({
    issuerBaseURL: `https://${process.env.AUTH0_DOMAIN}`,
    audience: process.env.AUTH0_AUDIENCE,
});


// Public API endpoints

// Protected API endpoints
app.use(validateAccessToken, addNewUser);
app.use('/reminders', reminderRouter);
app.use('/posts', postRouter);


app.listen(process.env.PORT, ()=>{
    console.log(`Server is running at port ${process.env.PORT}...`);
});