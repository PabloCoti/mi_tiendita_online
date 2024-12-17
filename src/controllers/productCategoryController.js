const { pooPromise, sql } = require('../db/db');

const getProductCategories = async (req, res) => {
    try {
        const pool = await pooPromise;
        const result = await pool.request().query('read_product_categories');

        res.json(result.recordset);
    } catch (error) {
        res.status(500).send(error.message);
    }
};

const getProductCategoryById = async (req, res) => {
    const { id } = req.params;

    try {
        const pool = await pooPromise;
        const result = await pool.request()
            .input('id', sql.Int, id)
            .query('read_product_categories_by_id');

        if (result.recordset.length > 0) {
            res.json(result.recordset);
        }
        else {
            res.status(404).json({ message: 'Categoría no encontrada' });
        }
    } catch (error) {
        res.status(500).send(error.message);
    }
}

const createProductCategory = async (req, res) => {
    const { name } = req.body;

    try {
        const pool = await pooPromise;
        const result = await pool.request()
            .input('name', sql.VarChar(45), name)
            .query('create_product_category');

        res.status(201).json({ message: 'Categoría creada exitosamente', category: result.recordset[0].id });
    } catch (error) {
        res.status(500).send(error.message);
    }
}

const updateProductCategory = async (req, res) => {
    const { id } = req.params;
    const { name } = req.body;

    try {
        const pool = await pooPromise;
        const result = await pool.request()
            .input('id', sql.Int, id)
            .input('name', sql.VarChar(45), name)
            .query('update_product_category');

        if (result.rowsAffected[0] > 0) {
            res.json({ message: 'Categoría actualizada exitosamente' });
        }
        else {
            res.status(404).json({ message: 'Categoría no encontrada' });
        }
    } catch (error) {
        res.status(500).send(error.message);
    }
}

const deleteProductCategory = async (req, res) => {
    const { id } = req.params;

    try {
        const pool = await pooPromise;
        const result = await pool.request()
            .input('id', sql.Int, id)
            .query('delete_product_category');

        if (result.rowsAffected[0] > 0) {
            res.json({ message: 'Categoría eliminada exitosamente' });
        }
        else {
            res.status(404).json({ message: 'Categoría no encontrada' });
        }
    } catch (error) {
        res.status(500).send(error.message);
    }
}

module.exports = {
    getProductCategories,
    getProductCategoryById,
    createProductCategory,
    updateProductCategory,
    deleteProductCategory
}

