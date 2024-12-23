const { ProductCategory } = require('../models');

const getProductCategories = async (req, res) => {
    try {
        const categories = await ProductCategory.findAll();
        res.status(200).json(categories);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
};

const getProductCategoryById = async (req, res) => {
    try {
        const { id } = req.params;
        const category = await ProductCategory.findByPk(id);
        if (category) {
            res.status(200).json(category);
        } else {
            res.status(404).json({ error: 'Category not found' });
        }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}

const createProductCategory = async (req, res) => {
    try {
        const { name } = req.body;
        const newCategory = await ProductCategory.create({ name });
        res.status(201).json(newCategory);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}

const updateProductCategory = async (req, res) => {
    try {
        const { id } = req.params;
        const { name } = req.body;
        const category = await ProductCategory.findByPk(id);
        if (category) {
            category.name = name;
            await category.save();
            res.status(200).json(category);
        } else {
            res.status(404).json({ error: 'Category not found' });
        }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}

const deleteProductCategory = async (req, res) => {
    try {
        const { id } = req.params;
        const category = await ProductCategory.findByPk(id);
        if (category) {
            category.deletedAt = new Date();
            await category.save();
            res.status(200).json({ message: 'Category soft deleted' });
        } else {
            res.status(404).json({ error: 'Category not found' });
        }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
}

module.exports = {
    getProductCategories,
    getProductCategoryById,
    createProductCategory,
    updateProductCategory,
    deleteProductCategory
}

