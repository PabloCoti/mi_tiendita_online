const express = require("express");
const app = express();

app.use(express.json());

// TODO
// user management
// Soft deleted items management

app.use('/products', require('./routes/productRoutes'));
app.use('/product-categories', require('./routes/productCategoryRoutes'));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
