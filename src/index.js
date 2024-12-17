const express = require("express");
const app = express();

app.use(express.json({ limit: '50mb' })); // exagerated limit, mainly for testing
app.use(express.urlencoded({ limit: '50mb', extended: true })); // exagerated limit, mainly for testing

app.use('/auth', require('./routes/authRoutes'));
app.use('/roles', require('./routes/roleRoutes'));
app.use('/users', require('./routes/userRoutes'));
app.use('/orders', require('./routes/orderRoutes'));
app.use('/products', require('./routes/productRoutes'));
app.use('/customers', require('./routes/customerRoutes'));
app.use('/product-categories', require('./routes/productCategoryRoutes'));

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
  console.log(`Server running in http://localhost:${PORT}`);
});
