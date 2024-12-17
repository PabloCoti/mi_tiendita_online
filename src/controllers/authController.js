const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const db = require("../db");

exports.login = async (req, res) => {
  const { email, password } = req.body;
  const [users] = await db.query("SELECT * FROM users WHERE email = ?", [
    email,
  ]);

  if (users.length === 0) return res.status(404).send("Usuario no encontrado");

  const user = users[0];
  const match = await bcrypt.compare(password, user.password);

  if (!match) return res.status(401).send("Credenciales inválidas");

  const token = jwt.sign(
    { id: user.id, email: user.email },
    process.env.JWT_SECRET,
    { expiresIn: "24h" }
  );
  res.json({ token });
};
