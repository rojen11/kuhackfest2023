const express = require('express');
const router = express.Router();
const feedController = require('../controllers/feedController');

router.get('/', feedController.showFeed);

module.exports = router;