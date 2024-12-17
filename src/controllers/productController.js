const { Product } = require('../models');

const getProducts = async (req, res) => {
    try {
        const products = await Product.findAll();
        res.status(200).json(products);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

const getProductById = async (req, res) => {
    try {
        const { id } = req.params;
        const product = await Product.findByPk(id);
        if (product) {
            res.status(200).json(product);
        } else {
            res.status(404).json({ message: 'Product not found' });
        }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

const createProduct = async (req, res) => {
    try {
        const pictureBuffer = req.file ? req.file.buffer : null;
        const { productCategoryId, name, brand, code, stock, price } = req.body;
        const newProduct = await Product.create({
            productCategoryId,
            name,
            brand,
            code,
            stock,
            price,
            picture: pictureBuffer
        });
        res.status(201).json({ message: 'Product created successfully', product: newProduct });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

const updateProduct = async (req, res) => {
    try {
        const { id } = req.params;
        const pictureBuffer = req.file ? req.file.buffer : null;
        const { productCategoryId, name, brand, code, stock, price } = req.body;
        const product = await Product.findByPk(id);
        if (product) {
            product.productCategoryId = productCategoryId || product.productCategoryId;
            product.name = name || product.name;
            product.brand = brand || product.brand;
            product.code = code || product.code;
            product.stock = stock || product.stock;
            product.price = price || product.price;
            product.picture = pictureBuffer || product.picture;
            await product.save();
            res.status(200).json({ message: 'Product updated successfully', product });
        } else {
            res.status(404).json({ message: 'Product not found' });
        }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

const deleteProduct = async (req, res) => {
    try {
        const { id } = req.params;
        const product = await Product.findByPk(id);
        if (product) {
            product.deletedAt = new Date();
            await product.save();
            res.status(200).json({ message: 'Product deleted successfully' });
        } else {
            res.status(404).json({ message: 'Product not found' });
        }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

module.exports = {
    getProducts,
    getProductById,
    createProduct,
    updateProduct,
    deleteProduct
};
