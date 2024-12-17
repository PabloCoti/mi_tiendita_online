const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const authenticateToken = require('../middleware/authMiddleware');

router.get('/', authenticateToken(), userController.getUsers);
router.get('/:id', authenticateToken(['customer']), userController.getUserById);

router.post('/', userController.createUser);

router.put('/:id', authenticateToken(['customer']), userController.updateUser);

router.delete('/:id', authenticateToken(), userController.deleteUser);

module.exports = router;
