const express = require('express');
const orderController = require('../controllers/orderController');
const authenticateToken = require('../middleware/authMiddleware');
const router = express.Router();

router.get('/', authenticateToken(['customer']), orderController.getAllOrders);
router.get('/:id', authenticateToken(['customer']), orderController.getOrderById);

router.post('/', authenticateToken(['customer']), orderController.createOrder);

router.put('/:id', authenticateToken(['customer']), orderController.updateOrder);
router.delete('/:id', authenticateToken(), orderController.deleteOrder);

module.exports = router;
