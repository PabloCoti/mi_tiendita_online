const { poolPromise, sql } = require("../db/db");

const getProducts = async (req, res) => {
    try {
        const pool = await poolPromise;
        const result = await pool.request().execute('read_products');

        res.json(result.recordset);
    } catch (err) {
        console.error(err);
        res.status(500).send('Error al obtener los productos');
    }
}

const getProductById = async (req, res) => {
    const { id } = req.params;

    try {
        const pool = await poolPromise;
        const result = await pool.request()
            .input('id', sql.Int, id)
            .execute('read_products_by_id');

        if (result.recordset.length > 0) {
            res.json(result.recordset[0]);
        } else {
            res.status(404).json({ message: 'Producto no encontrado' });
        }
    } catch (err) {
        console.error(err);
        res.status(500).send('Error al obtener el producto por id');
    }
}

const createProduct = async (req, res) => {
    const { product_category_id, name, brand, code, stock, price, picture } = req.body;

    try {
        const pool = await poolPromise;
        const result = await pool.request()
            .input('product_category_id', sql.Int, product_category_id)
            .input('name', sql.VarChar(45), name)
            .input('brand', sql.VarChar(45), brand)
            .input('code', sql.VarChar(45), code)
            .input('stock', sql.Float, stock)
            .input('price', sql.Float, price)
            .input('picture', sql.VarBinary, picture || null) // optional (specially for testing)
            .execute('create_product');

        res.status(201).json({ message: 'Producto creado exitosamente', product: result.recordset[0].id });
    } catch (err) {
        console.error(err);
        res.status(500).send('Error al crear el producto');
    }
}

const updateProduct = async (req, res) => {
    const { id } = req.params;
    const { product_category_id, name, brand, code, stock, price, picture } = req.body;

    try {
        let pool = await poolPromise;

        const result = await pool.request()
            .input('id', sql.Int, id)
            .input('product_category_id', sql.Int, product_category_id)
            .input('name', sql.VarChar(45), name)
            .input('brand', sql.VarChar(45), brand)
            .input('code', sql.VarChar(45), code)
            .input('stock', sql.Float, stock)
            .input('price', sql.Float, price)
            .input('picture', sql.VarBinary, picture || null) // optional (specially for testing)
            .execute('update_product');

        res.status(200).json({ message: 'Producto actualizado exitosamente' });
    } catch (err) {
        console.error(err);
        res.status(500).send('Error al actualizar el producto');
    }
}

const deleteProduct = async (req, res) => {
    const { id } = req.params;

    try {
        const pool = await poolPromise;
        const result = await pool.request()
            .input('id', sql.Int, id)
            .execute('delete_product');

        if (result.rowsAffected[0] > 0) {
            res.json({ message: 'Producto eliminado exitosamente' });
        } else {
            res.status(404).json({ message: 'Producto no encontrado' });
        }
    } catch (err) {
        console.error(err);
        res.status(500).send('Error al eliminar el producto');
    }
}

module.exports = {
    getProducts,
    getProductById,
    createProduct,
    updateProduct,
    deleteProduct
};
