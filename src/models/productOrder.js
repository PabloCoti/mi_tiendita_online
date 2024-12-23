'use strict';
module.exports = (sequelize, DataTypes) => {
  const ProductOrder = sequelize.define('ProductOrder', {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true
    },
    orderId: {
      type: DataTypes.INTEGER,
      references: {
        model: 'orders',
        key: 'id'
      }
    },
    productId: {
      type: DataTypes.INTEGER,
      references: {
        model: 'products',
        key: 'id'
      }
    },
    quantity: {
      type: DataTypes.INTEGER
    },
    price: {
      type: DataTypes.FLOAT
    },
    subtotal: {
      type: DataTypes.FLOAT
    }
  }, {
    tableName: 'product_orders',
    timestamps: false
  });

  ProductOrder.associate = function (models) {
    ProductOrder.belongsTo(models.Order, { foreignKey: 'orderId' });
    ProductOrder.belongsTo(models.Product, { foreignKey: 'productId' });
  };

  return ProductOrder;
};
