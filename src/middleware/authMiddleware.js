const jwt = require('jsonwebtoken');
const { Role } = require('../models');

const authenticateToken = (requiredRoles = []) => {
    return async (req, res, next) => {
        const token = req.header('Authorization').replace('Bearer ', '');
        if (!token) {
            return res.status(401).send({ error: 'Access denied. No token provided.' });
        }

        try {
            const decoded = jwt.verify(token, process.env.JWT_SECRET);
            req.user = decoded;

            const userRole = await Role.findOne({ _id: req.user.roleId });
            if (!userRole || (!requiredRoles.includes(userRole.code) && userRole.code !== 'admin')) {
                return res.status(403).send({ error: 'Access denied. Insufficient permissions.' });
            }

            next();
        } catch (ex) {
            res.status(400).send({ error: 'Invalid token.' });
        }
    };
};

module.exports = authenticateToken;
