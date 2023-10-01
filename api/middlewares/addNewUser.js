const User = require('../models/user');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const addNewUser = async (req, res, next)=>{
    const authHeader = req.headers.authorization || req.headers.Authorization;
    if (!authHeader?.startsWith('Bearer ')){
        return sendErrorResponse(res, "Unauthorized.", {}, 401);
    }
    const token = authHeader.split(' ')[1];
    const payload = jwt.decode(token);
    let user = await User.findOne({user_oauth_id: payload.sub});
    if(!user){
        try {
            user = new User({
              user_oauth_id: payload.sub
            });
            await user.save();
            req.user = user;
            console.log("LOGGED IN")
            next();
        } catch (error) {
            console.error('Error creating user:', error);
            res.status(500).json({ error: 'Internal Server Error' });
        }
    }
    next();
}

module.exports = {addNewUser};