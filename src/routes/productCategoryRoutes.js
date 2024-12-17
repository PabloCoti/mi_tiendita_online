const router = require('express').Router();
const productCategoryController = require('../controllers/productCategoryController');

router.get('/', productCategoryController.getProductCategories);
router.get('/:id', productCategoryController.getProductCategoryById);

router.post('/', productCategoryController.createProductCategory);

router.put('/:id', productCategoryController.updateProductCategory);

router.delete('/:id', productCategoryController.deleteProductCategory);

module.exports = router;

