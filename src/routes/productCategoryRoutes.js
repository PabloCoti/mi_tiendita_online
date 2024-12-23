const express = require('express');
const router = express.Router();
const productCategoryController = require('../controllers/productCategoryController');
const authenticateToken = require('../middleware/authMiddleware');

router.get('/', authenticateToken(['customer']), productCategoryController.getProductCategories);
router.get('/:id', authenticateToken(), productCategoryController.getProductCategoryById);

router.post('/', authenticateToken(), productCategoryController.createProductCategory);

router.put('/:id', authenticateToken(), productCategoryController.updateProductCategory);

router.delete('/:id', authenticateToken(), productCategoryController.deleteProductCategory);

module.exports = router;

