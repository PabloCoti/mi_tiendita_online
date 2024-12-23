const express = require('express');
const router = express.Router();
const roleController = require('../controllers/roleController');
const authenticateToken = require('../middleware/authMiddleware');

router.get('/', authenticateToken(), roleController.getRoles);
router.get('/:id', authenticateToken(), roleController.getRoleById);

router.post('/', authenticateToken(), roleController.createRole);

router.put('/:id', authenticateToken(), roleController.updateRole);

router.delete('/:id', authenticateToken(), roleController.deleteRole);

module.exports = router;
