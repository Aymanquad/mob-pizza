const express = require('express');
const userController = require('../controllers/user.controller');

const router = express.Router();

// GET /api/v1/users/:phone - Get user profile
router.get('/:phone', userController.getProfile);

// PUT /api/v1/users/:phone - Update user profile
router.put('/:phone', userController.updateProfile);

module.exports = router;

