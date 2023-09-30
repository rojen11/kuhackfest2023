const User = require('../models/user');
const bcrypt = require('bcrypt');

const addNewUser = async (req, res, next)=>{
    const auth = req.auth;
    const user_id = auth.sub;
    let user = await User.findOne({auth_id: user_id});
    console.log(auth);
    if(!user){
        try {
            const { username, email } = req.body;
            const user = new User({
              username,
              email,
              user_id
            });
            await user.save();
        } catch (error) {
            console.error('Error creating user:', error);
            res.status(500).json({ error: 'Internal Server Error' });
        }
        req.user = user;
        console.log("LOGGED IN")
        next();
    }
}

module.exports = {addNewUser};