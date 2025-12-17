const express = require('express');
const { onboarding } = require('../controllers/onboarding.controller');

const router = express.Router();

router.post('/', onboarding);

module.exports = router;

