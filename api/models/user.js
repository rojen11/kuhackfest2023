const  mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    username: {
        type: String,
        optional: true,
        maxLength: [50, "User name cannot exceed 50 characters"],
        minLength: [2, "User name should be at least 2 characters Long."]
    },

    email: {
        type: String,
        optional: true,
        unique: [true, "Email already registered."]
    },

    user_oauth_id: {
        type: String,
        required: [true, "This is compulsory."]
    },

    created_at: {
        type: Date,
        default: Date.now,
        optional: true
    }
});


const user = mongoose.model("User", userSchema);

module.exports = user;