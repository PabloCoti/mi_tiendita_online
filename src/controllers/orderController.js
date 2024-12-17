const { Order, ProductOrder, Product } = require('../models');

exports.createOrder = async (req, res) => {
    try {
        const { products } = req.body;

        if (!products || products.length === 0) {
            return res.status(400).json({ error: 'No products provided' });
        }

        const productOrders = await Promise.all(products.map(async (productOrder) => {
            const product = await Product.findByPk(productOrder.productId);

            if (!product) {
                throw new Error(`Product with id ${productOrder.productId} not found`);
            }

            const price = product.price;
            const subtotal = productOrder.quantity * price;

            return {
                ...productOrder,
                price,
                subtotal
            };
        }));

        const orderData = {
            ...req.body,
            products: productOrders
        };

        const order = await Order.create(orderData, {
            include: [{ model: ProductOrder, as: 'products' }]
        });

        const total = productOrders.reduce((accumulator, productOrder) => accumulator + productOrder.subtotal, 0);
        await order.update({ total });

        res.status(201).json(order);
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
};

exports.getAllOrders = async (req, res) => {
    try {
        const orders = await Order.findAll({
            include: [{ model: ProductOrder, as: 'products' }]
        });
        res.status(200).json(orders);
    } catch (error) {
        res.status(500).json({ error: error.message, details: error });
    }
};

exports.getOrderById = async (req, res) => {
    try {
        const order = await Order.findByPk(req.params.id, {
            include: [{ model: ProductOrder, as: 'products' }]
        });
        if (order) {
            res.status(200).json(order);
        } else {
            res.status(404).json({ error: 'Order not found' });
        }
    } catch (error) {
        res.status(500).json({ error: error.message, details: error });
    }
};

exports.updateOrder = async (req, res) => {
    try {
        const [updated] = await Order.update(req.body, {
            where: { id: req.params.id }
        });
        if (updated) {
            const updatedOrder = await Order.findByPk(req.params.id, {
                include: [{ model: ProductOrder, as: 'products' }]
            });
            res.status(200).json(updatedOrder);
        } else {
            res.status(404).json({ error: 'Order not found' });
        }
    } catch (error) {
        res.status(500).json({ error: error.message, details: error });
    }
};

exports.deleteOrder = async (req, res) => {
    try {
        const deleted = await Order.destroy({
            where: { id: req.params.id }
        });
        if (deleted) {
            res.status(204).json();
        } else {
            res.status(404).json({ error: 'Order not found' });
        }
    } catch (error) {
        res.status(500).json({ error: error.message, details: error });
    }
};
