'use strict';
module.exports = (sequelize, DataTypes) => {
  const Order = sequelize.define('Order', {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true
    },
    customerId: {
      type: DataTypes.INTEGER,
      references: {
        model: 'customers',
        key: 'id'
      }
    },
    status: {
      type: DataTypes.INTEGER,
      defaultValue: 1
    },
    address: {
      type: DataTypes.STRING(545)
    },
    total: {
      type: DataTypes.FLOAT,
      defaultValue: 0
    },
    createdAt: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    },
    updatedAt: {
      type: DataTypes.DATE,
      allowNull: true
    }
  }, {
    tableName: 'orders',
    timestamps: true
  });

  Order.associate = function (models) {
    Order.hasMany(models.ProductOrder, { as: 'products', foreignKey: 'orderId' });
  };

  return Order;
};
