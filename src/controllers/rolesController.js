const { poolPromise, sql } = require("../db/db");

const getRoles = async (req, res) => {
    try {
        const pool = await poolPromise;
        const result = await pool.request().execute("read_roles");
        res.json(result.recordset);
    } catch (error) {
        console.error("Error al obtener roles:", error.message);
        res.status(500).json({ message: "Error al obtener roles" });
    }
};

const getRolById = async (req, res) => {
    const { id } = req.params;
    try {
        const pool = await poolPromise;
        const result = await pool
            .request()
            .input("id", sql.Int, id)
            .execute("read_roles_by_id");
        if (result.recordset.length > 0) {
            res.json(result.recordset[0]);
        } else {
            res.status(404).json({ message: "Rol no encontrado" });
        }
    } catch (error) {
        console.error("Error al obtener rol:", error.message);
        res.status(500).json({ message: "Error en el servidor" });
    }
};

const createRol = async (req, res) => {
    const { nombre, descripcion } = req.body;
    try {
        const pool = await poolPromise;
        await pool
            .request()
            .input("nombre", sql.NVarChar, nombre)
            .input("descripcion", sql.NVarChar, descripcion)
            .execute("CreateRol");
        res.status(201).json({ message: "Rol creado exitosamente" });
    } catch (error) {
        console.error("Error al crear rol:", error.message);
        res.status(500).json({ message: "Error al crear rol" });
    }
};

const updateRol = async (req, res) => {
    const { id } = req.params;
    const { nombre, descripcion } = req.body;
    try {
        const pool = await poolPromise;
        const result = await pool
            .request()
            .input("id", sql.Int, id)
            .input("nombre", sql.NVarChar, nombre)
            .input("descripcion", sql.NVarChar, descripcion)
            .execute("UpdateRol");

        if (result.rowsAffected[0] > 0) {
            res.json({ message: "Rol actualizado exitosamente" });
        } else {
            res.status(404).json({ message: "Rol no encontrado" });
        }
    } catch (error) {
        console.error("Error al actualizar rol:", error.message);
        res.status(500).json({ message: "Error al actualizar rol" });
    }
};

const deleteRol = async (req, res) => {
    const { id } = req.params;
    try {
        const pool = await poolPromise;
        const result = await pool
            .request()
            .input("id", sql.Int, id)
            .execute("DeleteRol");
        if (result.rowsAffected[0] > 0) {
            res.json({ message: "Rol eliminado exitosamente" });
        } else {
            res.status(404).json({ message: "Rol no encontrado" });
        }
    } catch (error) {
        console.error("Error al eliminar rol:", error.message);
        res.status(500).json({ message: "Error al eliminar rol" });
    }
};

module.exports = {
    getRoles,
    getRolById,
    createRol,
    updateRol,
    deleteRol,
};
