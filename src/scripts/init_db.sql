-- DB CREATION

/* 
DIFFERENCE BETWEEN DELETED_AT AND STATUS

Both can be used for "deletion" keeping the record in the database but they have different purposes:
- deleted_at: is for soft delete, HIDES the record from the user.
- status: is for logical delete, keeps the record VISIBLE to the user but with a status that indicates that the record is not active. 

 */

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
        code VARCHAR(45),
        name VARCHAR(45),
        created_at DATETIME DEFAULT GETDATE(),
        updated_at DATETIME DEFAULT NULL,
        deleted_at DATETIME DEFAULT NULL,
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
        status INT DEFAULT 1,
        email VARCHAR(45),
        password VARCHAR(45),
        phone_number VARCHAR(45),
        birth_date DATE,
        created_at DATETIME DEFAULT GETDATE(),
        updated_at DATETIME DEFAULT NULL,
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
        status INT DEFAULT 1,
        address VARCHAR(545),
        total FLOAT,
        created_at DATETIME DEFAULT GETDATE(),
        updated_at DATETIME DEFAULT NULL,
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
        created_at DATETIME DEFAULT GETDATE(),
        updated_at DATETIME DEFAULT NULL,
        deleted_at DATETIME DEFAULT NULL,
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
        picture BINARY NULL,
        created_at datetime DEFAULT GETDATE(),
        updated_at datetime DEFAULT NULL,
        deleted_at datetime DEFAULT NULL,
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