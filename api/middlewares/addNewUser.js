const User = require("../models/user");
const bcrypt = require("bcrypt");

const addNewUser = async (req, res, next) => {
  const auth = req.auth;
  const user_id = auth.sub;
  let user = await User.findOne({ auth_id: user_id });
  console.log(auth);
  if (!user) {
    try {
      const username = auth.username;
      const email = auth.email;
      const user_oauth_id = auth.sub;
      const user = new User({
        username,
        email,
        user_oauth_id,
      });
      await user.save();
      req.user = user;
      console.log("LOGGED IN");
      next();
    } catch (error) {
      console.error("Error creating user:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
  }
};

module.exports = { addNewUser };
