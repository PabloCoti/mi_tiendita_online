IF NOT EXISTS (SELECT *
FROM sys.databases
WHERE name = 'GDA00594-OT-Pablo-Coti')
BEGIN
    CREATE DATABASE [GDA00594-OT-Pablo-Coti];
END
GO

IF EXISTS (SELECT *
FROM sys.databases
WHERE name = 'GDA00594-OT-Pablo-Coti')
BEGIN
    USE [GDA00594-OT-Pablo-Coti];
END
GO

-- TABLES CREATION

IF NOT EXISTS (SELECT *
FROM sys.tables
WHERE name = 'roles' AND type = 'U')
BEGIN
    CREATE TABLE roles
    (
        id INT IDENTITY(1, 1) PRIMARY KEY,
        name VARCHAR(45),
    );
END

IF NOT EXISTS (SELECT *
FROM sys.tables
WHERE name = 'users' AND type = 'U')
BEGIN
    CREATE TABLE users
    (
        id INT IDENTITY(1, 1) PRIMARY KEY,
        role_id INT FOREIGN KEY REFERENCES roles(id),
        full_name VARCHAR(45),
        status INT,
        email VARCHAR(45),
        password VARCHAR(45),
        phone_number VARCHAR(45),
        birth_date DATE,
        created_at DATETIME,
        updated_at DATETIME NULL,
    );
END

IF NOT EXISTS (SELECT *
FROM sys.tables
WHERE name = 'customers' AND type = 'U')
BEGIN
    CREATE TABLE customers
    (
        id INT IDENTITY(1, 1) PRIMARY KEY,
        user_id INT FOREIGN KEY REFERENCES users(id),
        nit VARCHAR(245),
        full_name VARCHAR(345),
        phone_number VARCHAR(45),
        email VARCHAR(45),
    );
END

IF NOT EXISTS (SELECT *
FROM sys.tables
WHERE name = 'orders' AND type = 'U')
BEGIN
    CREATE TABLE orders
    (
        id INT IDENTITY(1, 1) PRIMARY KEY,
        customer_id INT FOREIGN KEY REFERENCES customers(id),
        status INT,
        address VARCHAR(545),
        total FLOAT,
        created_at DATETIME,
        updated_at DATETIME NULL,
    );
END

IF NOT EXISTS (SELECT *
FROM sys.tables
WHERE name = 'product_categories' AND type = 'U')
BEGIN
    CREATE TABLE product_categories
    (
        id INT IDENTITY(1, 1) PRIMARY KEY,
        name VARCHAR(45),
        created_at DATETIME,
        updated_at DATETIME NULL,
        deleted_at DATETIME NULL,
    );
END

IF NOT EXISTS (SELECT *
FROM sys.tables
WHERE name = 'products' AND type = 'U')
BEGIN
    CREATE TABLE products
    (
        id INT IDENTITY(1, 1) PRIMARY KEY,
        product_category_id INT FOREIGN KEY REFERENCES product_categories(id),
        name VARCHAR(45),
        brand VARCHAR(45),
        code VARCHAR(45),
        stock FLOAT,
        price FLOAT,
        picture BINARY,
        created_at datetime,
        updated_at datetime NULL,
        deleted_at datetime NULL,
    );
END

IF NOT EXISTS (SELECT *
FROM sys.tables
WHERE name = 'product_orders' AND type = 'U')
BEGIN
    CREATE TABLE product_orders
    (
        id INT IDENTITY(1, 1) PRIMARY KEY,
        order_id INT FOREIGN KEY REFERENCES orders(id),
        product_id INT FOREIGN KEY REFERENCES products(id),
        quantity INT,
        price FLOAT,
        subtotal FLOAT
    );
END
GO