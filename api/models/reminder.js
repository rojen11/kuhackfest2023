const  mongoose = require('mongoose');
const User = require('../models/user');

const reminderSchema = new mongoose.Schema({
    user_id:{
        type: [mongoose.Types.ObjectId],
        ref: User,
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
    start_time:{
        type: Date,
        required: true
    },
    end_time:{
        type: Date,
        required: true
    },
    created_at: {
        type: Date,
        default: Date.now
    }
});

const reminder = mongoose.model("Reminder", reminderSchema);

module.exports = reminder;