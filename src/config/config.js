const path = require('path');
require('dotenv').config({ path: path.resolve(__dirname, '../../.env') });

const defaultConfig = {
  username: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  server: process.env.DB_SERVER,
  dialect: 'mssql',
};

module.exports = {
  local: defaultConfig,
  dev: defaultConfig,
  stage: defaultConfig,
  prod: defaultConfig,
};
