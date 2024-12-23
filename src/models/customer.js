'use strict';
module.exports = (sequelize, DataTypes) => {
  const Customer = sequelize.define('Customer', {
    id: {
      type: DataTypes.INTEGER,
      autoIncrement: true,
      primaryKey: true
    },
    userId: {
      type: DataTypes.INTEGER,
      references: {
        model: 'users',
        key: 'id'
      }
    },
    nit: {
      type: DataTypes.STRING(245)
    }
  }, {
    tableName: 'customers',
    timestamps: false
  });

  Customer.associate = function(models) {
    Customer.belongsTo(models.User, { foreignKey: 'userId' });
  };

  return Customer;
};
