'use strict';

module.exports = {
  async up(queryInterface, Sequelize) {
    await queryInterface.bulkInsert('roles', [
      {
        code: 'admin',
        name: 'Administrador',
        createdAt: new Date(),
        updatedAt: new Date()
      },
      {
        code: 'customer',
        name: 'Cliente',
        createdAt: new Date(),
        updatedAt: new Date()
      }
    ], {});
  },

  async down(queryInterface, Sequelize) {
    await queryInterface.bulkDelete('roles', null, {});
  }
};
