const jwt = require('jsonwebtoken');

const roleMiddleware = (requiredRole) => {
  return (req, res, next) => {
    const token = req.header('Authorization').replace('Bearer ', '');
    if (!token) {
      return res.status(401).send({ error: 'Access denied. No token provided.' });
    }

    try {
      const decoded = jwt.verify(token, process.env.JWT_SECRET);
      req.user = decoded;

      if (req.user.role !== requiredRole) {
        return res.status(403).send({ error: 'Access denied. Insufficient permissions.' });
      }

      next();
    } catch (ex) {
      res.status(400).send({ error: 'Invalid token.' });
    }
  };
};

module.exports = roleMiddleware;
