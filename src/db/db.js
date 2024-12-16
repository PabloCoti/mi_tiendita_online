// sql files excecution could be automated with fs library

require("dotenv").config();

const sql = require("mssql");

const sqlConfig = {
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  server: process.env.DB_SERVER,
  options: {
    encrypt: false, // set to true if working with Azure
    trustServerCertificate: true,
  },
};

const poolPromise = new sql.ConnectionPool(sqlConfig)
  .connect()
  .then((pool) => {
    console.log("Conexión a SQL Server exitosa");
    return pool;
  })
  .catch((err) => console.error("Conexión fallida:", err));

module.exports = poolPromise;
