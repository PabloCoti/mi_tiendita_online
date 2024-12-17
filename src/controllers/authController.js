const { User } = require('../models');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');

const login = async (req, res) => {
  const { email, password } = req.body;
  try {
    const user = await User.findOne({ where: { email } });
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    const isPasswordValid = await bcrypt.compare(password, user.password);
    if (!isPasswordValid) {
      return res.status(401).json({ message: 'Wrong password' });
    }

    const token = jwt.sign({ id: user.id, roleId: user.roleId }, process.env.JWT_SECRET, {
      expiresIn: '24h'
    });

    res.status(200).json({ token });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

const register = async (req, res) => {
  const { fullName, email, password, phoneNumber, birthDate, roleId } = req.body;
  try {
    const formattedBirthDate = new Date(birthDate).toISOString().split("T")[0];
    const hashedPassword = await bcrypt.hash(password, 10);
    const newUser = await User.create({
      fullName,
      email,
      password: hashedPassword,
      phoneNumber,
      birthDate: formattedBirthDate,
      roleId
    });

    const token = jwt.sign({ id: newUser.id, roleId: newUser.roleId }, process.env.JWT_SECRET, {
      expiresIn: '24h'
    });

    res.status(201).json({ token });
  } catch (error) {
    res.status(500).json({ error: error });
  }
};

module.exports = {
  login,
  register
};
