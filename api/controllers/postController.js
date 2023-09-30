const Post = require('../models/post');
const path = require('path');
const fs = require('fs');
const util = require('util')
const deleteFile = util.promisify(fs.unlink);
const imageUpload = require("../utils/imageUpload.js");

// Get all posts
exports.getAllPosts = async (req, res) => {
  try {
    const posts = await Post.find({});
    res.json(posts);
  } catch (error) {
    console.error('Error getting posts:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Get a single post
exports.getPostById = async (req, res) => {
  try {
    const post = await Post.findById(req.params.id);
    if (!post) {
      return res.status(404).json({ error: 'post not found' });
    }
    res.json(post);
  } catch (error) {
    console.error('Error getting post:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Create a new post
exports.createPost = async (req, res) => {
  try {
      const post = new post(req.body);
      let filename = req.files.upload.name;
      //checking image filetype
      const file_extension = path.extname(filename);
      if (!isAcceptedImageFile(file_extension)) {
        return sendErrorResponse(res, "Please use one of the accepted filetypes: .png, .jpeg, .jpg");
      }
      //renaming and saving new profile picture
      filename = `${Date.now()}${file_extension}`;
      let dir = path.join(appRoot, "/storage/posts");
      await uploadImage(req.files.upload, dir, filename);

      post.img_path = filename;
      await Post.save();
      res.json(post);
  } catch (error) {
    console.error('Error creating post:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Update a post
exports.updatePost = async (req, res) => {
  try {
    let post = await Post.findById(req.params.id);
    if (!post) {
      return res.status(404).json({ error: 'post not found' });
    }
    if (req.files) {
        let filename = req.files.avatar.name;
  
        //checking image filetype
        const file_extension = path.extname(filename);
        if (!isAcceptedImageFile(file_extension)) {
          return sendErrorResponse(res, "Please use one of the accepted filetypes: .png, .jpeg, .jpg");
        }
  
        //renaming and saving new profile picture
        filename = `${Date.now()}${file_extension}`;
        let dir = path.join(appRoot, "/storage/posts");
        await uploadImage(req.files.img_path, dir, filename);
  
        req.body.img_path = filename;
  
        //deleting old profile picture if it exists
        let oldFile = path.join(appRoot, "/storage/posts", user.img_path);
        await deleteFile(oldFile);
      }

    updated_post = await Post.findByIdAndUpdate(post._id, req.body, {
      new: true,
      runValidators: true,
    });
    res.json(updated_post);
  } catch (error) {
    console.error('Error updating post:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};

// Delete a post
exports.deletePost = async (req, res) => {
  try {
    const post = await Post.findById(req.params.id);

    if (!post) {
      return res.status(404).json({ error: 'post not found' });
    }
    const oldFile = path.join(appRoot, "/storage/posts", post.img_path);
    await deleteFile(oldFile);
    await Post.deleteOne({ _id: req.params.id });

    res.json({ message: 'post deleted successfully' });
  } catch (error) {
    console.error('Error deleting post:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
};