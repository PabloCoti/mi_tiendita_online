require("dotenv").config();

const { Sequelize } = require('sequelize');

const sequelize = new Sequelize(process.env.DB_NAME, process.env.DB_USER, process.env.DB_PASSWORD, {
  host: process.env.DB_SERVER,
  dialect: 'mssql',
  dialectOptions: {
    options: {
      encrypt: process.env.DB_ENCRYPT || true,
      trustServerCertificate: true,
    },
  },
  logging: false,
});

(async () => {
  try {
    await sequelize.authenticate();
    console.log('SQL server connection successful');
  } catch (error) {
    console.error('Failed connection:', error);
  }
})();

module.exports = sequelize;