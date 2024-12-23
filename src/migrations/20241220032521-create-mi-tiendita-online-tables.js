'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.createTable('roles', {
      id: {
        type: Sequelize.INTEGER,
        autoIncrement: true,
        primaryKey: true
      },
      code: {
        type: Sequelize.STRING(45)
      },
      name: {
        type: Sequelize.STRING(45)
      },
      createdAt: {
        type: Sequelize.DATE,
        defaultValue: Sequelize.literal('GETDATE()')
      },
      updatedAt: {
        type: Sequelize.DATE,
        allowNull: true
      },
      deletedAt: {
        type: Sequelize.DATE,
        allowNull: true
      }
    });

    await queryInterface.createTable('users', {
      id: {
        type: Sequelize.INTEGER,
        autoIncrement: true,
        primaryKey: true
      },
      roleId: {
        type: Sequelize.INTEGER,
        references: {
          model: 'roles',
          key: 'id'
        }
      },
      fullName: {
        type: Sequelize.STRING(45)
      },
      status: {
        type: Sequelize.INTEGER,
        defaultValue: 1
      },
      email: {
        type: Sequelize.STRING(45)
      },
      password: {
        type: Sequelize.STRING(255)
      },
      phoneNumber: {
        type: Sequelize.STRING(8)
      },
      birthDate: {
        type: Sequelize.DATE
      },
      createdAt: {
        type: Sequelize.DATE,
        defaultValue: Sequelize.literal('GETDATE()')
      },
      updatedAt: {
        type: Sequelize.DATE,
        allowNull: true
      }
    });

    await queryInterface.createTable('customers', {
      id: {
        type: Sequelize.INTEGER,
        autoIncrement: true,
        primaryKey: true
      },
      userId: {
        type: Sequelize.INTEGER,
        references: {
          model: 'users',
          key: 'id'
        }
      },
      nit: {
        type: Sequelize.STRING(245)
      }
    });

    await queryInterface.createTable('orders', {
      id: {
        type: Sequelize.INTEGER,
        autoIncrement: true,
        primaryKey: true
      },
      customerId: {
        type: Sequelize.INTEGER,
        references: {
          model: 'customers',
          key: 'id'
        }
      },
      status: {
        type: Sequelize.INTEGER,
        defaultValue: 1
      },
      address: {
        type: Sequelize.STRING(545)
      },
      total: {
        type: Sequelize.FLOAT,
        defaultValue: 0
      },
      createdAt: {
        type: Sequelize.DATE,
        defaultValue: Sequelize.literal('GETDATE()')
      },
      updatedAt: {
        type: Sequelize.DATE,
        allowNull: true
      }
    });

    await queryInterface.createTable('product_categories', {
      id: {
        type: Sequelize.INTEGER,
        autoIncrement: true,
        primaryKey: true
      },
      name: {
        type: Sequelize.STRING(45)
      },
      createdAt: {
        type: Sequelize.DATE,
        defaultValue: Sequelize.literal('GETDATE()')
      },
      updatedAt: {
        type: Sequelize.DATE,
        allowNull: true
      },
      deletedAt: {
        type: Sequelize.DATE,
        allowNull: true
      }
    });

    await queryInterface.createTable('products', {
      id: {
        type: Sequelize.INTEGER,
        autoIncrement: true,
        primaryKey: true
      },
      productCategoryId: {
        type: Sequelize.INTEGER,
        references: {
          model: 'product_categories',
          key: 'id'
        }
      },
      name: {
        type: Sequelize.STRING(45)
      },
      brand: {
        type: Sequelize.STRING(45)
      },
      code: {
        type: Sequelize.STRING(45)
      },
      stock: {
        type: Sequelize.FLOAT
      },
      price: {
        type: Sequelize.FLOAT
      },
      picture: {
        type: Sequelize.BLOB,
        allowNull: true
      },
      createdAt: {
        type: Sequelize.DATE,
        defaultValue: Sequelize.literal('GETDATE()')
      },
      updatedAt: {
        type: Sequelize.DATE,
        allowNull: true
      },
      deletedAt: {
        type: Sequelize.DATE,
        allowNull: true
      }
    });

    await queryInterface.createTable('product_orders', {
      id: {
        type: Sequelize.INTEGER,
        autoIncrement: true,
        primaryKey: true
      },
      orderId: {
        type: Sequelize.INTEGER,
        references: {
          model: 'orders',
          key: 'id'
        }
      },
      productId: {
        type: Sequelize.INTEGER,
        references: {
          model: 'products',
          key: 'id'
        }
      },
      quantity: {
        type: Sequelize.INTEGER
      },
      price: {
        type: Sequelize.FLOAT
      },
      subtotal: {
        type: Sequelize.FLOAT
      }
    });
  },

  async down(queryInterface, Sequelize) {
    await queryInterface.dropTable('product_orders');
    await queryInterface.dropTable('products');
    await queryInterface.dropTable('product_categories');
    await queryInterface.dropTable('orders');
    await queryInterface.dropTable('customers');
    await queryInterface.dropTable('users');
    await queryInterface.dropTable('roles');
  }
};
