'use strict';
module.exports = (sequelize, DataTypes) => {
  const Product = sequelize.define('Product', {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true
    },
    productCategoryId: {
      type: DataTypes.INTEGER,
      references: {
        model: 'product_categories',
        key: 'id'
      }
    },
    name: {
      type: DataTypes.STRING(45)
    },
    brand: {
      type: DataTypes.STRING(45)
    },
    code: {
      type: DataTypes.STRING(45)
    },
    stock: {
      type: DataTypes.FLOAT
    },
    price: {
      type: DataTypes.FLOAT
    },
    picture: {
      type: DataTypes.BLOB,
      allowNull: true
    },
    createdAt: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    },
    updatedAt: {
      type: DataTypes.DATE,
      allowNull: true
    },
    deletedAt: {
      type: DataTypes.DATE,
      allowNull: true
    }
  }, {
    tableName: 'products',
    timestamps: true,
    paranoid: true
  });

  Product.associate = function(models) {
    Product.belongsTo(models.ProductCategory, { foreignKey: 'productCategoryId' });
    Product.hasMany(models.ProductOrder, { foreignKey: 'productId' });
  };

  return Product;
};
