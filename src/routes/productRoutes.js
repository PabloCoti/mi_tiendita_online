const express = require('express');
const multer = require("multer");

const router = express.Router();
const productController = require('../controllers/productController');
const authenticateToken = require('../middleware/authMiddleware');

const storage = multer.memoryStorage();
const upload = multer({
    storage: storage,
    limits: { fileSize: 50 * 1024 * 1024 }
});

router.get('/', authenticateToken(['customer']), productController.getProducts);
router.get('/:id', authenticateToken(['customer']), productController.getProductById);

router.post('/', authenticateToken(), upload.single('picture'), productController.createProduct);

router.put('/:id', authenticateToken(), upload.single('picture'), productController.updateProduct);

router.delete('/:id', authenticateToken(), productController.deleteProduct);

module.exports = router;
