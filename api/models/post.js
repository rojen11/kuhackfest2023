const  mongoose = require('mongoose');
const User = require('../models/user');

const postSchema = new mongoose.Schema({
    user_id:{
        type: [mongoose.Types.ObjectId],
        ref: User,
        required: true
    },
    caption: {
        type: String ,
        required: true
    },
    longitude: {
        type: Number,
        required: true
    },
    latitude: {
        type: Number,
        required: true
    },
    img_path: {
        type: String,
        required: true
    },
    created_at: {
        type: Date,
        default: Date.now
    }
});

const post = mongoose.model("Post", postSchema);

module.exports = post;