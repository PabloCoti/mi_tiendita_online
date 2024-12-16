require("dotenv").config();

const express = require("express");
const db = require("./db/db");
const app = express();

app.get("/test-db", async (req, res) => {
  try {
    const pool = await db; // Espera la conexión al pool
    const result = await pool.request().query("SELECT 1 AS Test"); // Prueba una consulta
    res.json(result.recordset);
  } catch (error) {
    console.error("Error al conectar a la base de datos:", error);
    res.status(500).send("Error de conexión a la base de datos");
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});
