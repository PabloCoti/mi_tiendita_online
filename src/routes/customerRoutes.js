const express = require('express');
const router = express.Router();
const customerController = require('../controllers/customerController');
const authenticateToken = require('../middleware/authMiddleware');

router.get('/', authenticateToken(), customerController.getAllCustomers);
router.get('/:id', authenticateToken(['customer']), customerController.getCustomerById);

router.post('/', authenticateToken(['customer']), customerController.createCustomer);

router.put('/:id', authenticateToken(['customer']), customerController.updateCustomer);

router.delete('/:id', authenticateToken(), customerController.deleteCustomer);

module.exports = router;
