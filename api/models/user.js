const  mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    username: {
        type: String,
        required: [true, "You Must enter a Name"],
        maxLength: [50, "User name cannot exceed 50 characters"],
        minLength: [2, "User name should be at least 2 characters Long."]
    },

    email: {
        type: String,
        required: [true, "Email is a required parameter."],
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


userSchema.pre('save', async function save(next) {
    if (!this.isModified('password')) return next();
    try {
        this.password = await bcrypt.hash(this.password, 10);
        return next();
    } catch (err) {
        return next(err);
    }
});

const user = mongoose.model("User", userSchema);

module.exports = user;