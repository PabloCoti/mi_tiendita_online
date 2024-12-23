-- GDA00594-OT
-- Pablo Andrés Cotí Arredondo

-- CREATE DATABASE GDA00594-OT-Pablo-Coti

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

-- PROCEDURES CREATION

-- ROLES
CREATE OR ALTER PROCEDURE sp_create_role
    @name VARCHAR(45)
AS
BEGIN
    INSERT INTO roles
        (name)
    VALUES
        (@name);
END
GO

CREATE OR ALTER PROCEDURE sp_read_roles
AS
BEGIN
    SELECT *
    FROM roles;
END
GO

CREATE OR ALTER PROCEDURE sp_update_role
    @id INT,
    @name VARCHAR(45)
AS
BEGIN
    UPDATE roles 
    SET name = @name 
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE sp_delete_role
    @id INT
AS
BEGIN
    DELETE FROM roles WHERE id = @id;
END
GO

-- USER
CREATE OR ALTER PROCEDURE sp_create_user
    @role_id INT,
    @full_name VARCHAR(45),
    @email VARCHAR(45),
    @password VARCHAR(45),
    @phone_number VARCHAR(45),
    @birth_date DATE
AS
BEGIN
    DECLARE @created_at DATETIME = GETDATE();
    DECLARE @status INT = 1;

    INSERT INTO users
        (role_id, full_name, status, email, password, phone_number, birth_date, created_at, updated_at)
    VALUES
        (@role_id, @full_name, @status, @email, @password, @phone_number, @birth_date, @created_at, @updated_at);
END
GO

CREATE OR ALTER PROCEDURE sp_read_users
AS
BEGIN
    SELECT *
    FROM users;
END
GO

CREATE OR ALTER PROCEDURE sp_update_user
    @id INT,
    @role_id INT,
    @full_name VARCHAR(45),
    @status INT,
    @email VARCHAR(45),
    @password VARCHAR(45),
    @phone_number VARCHAR(45),
    @birth_date DATE
AS
BEGIN
    DECLARE @updated_at DATETIME = GETDATE();

    UPDATE users SET role_id = @role_id, full_name = @full_name, status = @status, email = @email, password = @password, phone_number = @phone_number, birth_date = @birth_date, updated_at = @updated_at WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE sp_create_customer
    @user_id INT,
    @nit VARCHAR(245),
    @full_name VARCHAR(345),
    @phone_number VARCHAR(45),
    @email VARCHAR(45)
AS
BEGIN
    INSERT INTO customers
        (user_id, nit, full_name, phone_number, email)
    VALUES
        (@user_id, @nit, @full_name, @phone_number, @email);
END
GO

CREATE OR ALTER PROCEDURE sp_read_customers
AS
BEGIN
    SELECT *
    FROM customers;
END
GO

CREATE OR ALTER PROCEDURE sp_update_customer
    @id INT,
    @user_id INT,
    @nit VARCHAR(245),
    @full_name VARCHAR(345),
    @phone_number VARCHAR(45),
    @email VARCHAR(45)
AS
BEGIN
    UPDATE customers
    SET user_id = @user_id, nit = @nit, full_name = @full_name, phone_number = @phone_number, email = @email
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE sp_delete_customer
    @id INT
AS
BEGIN
    DELETE FROM customers
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE sp_create_order
    @customer_id INT,
    @status INT,
    @address VARCHAR(545),
    @total FLOAT,
    @created_at DATETIME,
    @updated_at DATETIME
AS
BEGIN
    INSERT INTO orders
        (customer_id, status, address, total, created_at, updated_at)
    VALUES
        (@customer_id, @status, @address, @total, @created_at, @updated_at);
END
GO

CREATE OR ALTER PROCEDURE sp_read_orders
AS
BEGIN
    SELECT *
    FROM orders;
END
GO

CREATE OR ALTER PROCEDURE sp_update_order
    @id INT,
    @customer_id INT,
    @status INT,
    @address VARCHAR(545),
    @total FLOAT,
    @updated_at DATETIME
AS
BEGIN
    UPDATE orders
    SET customer_id = @customer_id, status = @status, address = @address, total = @total, updated_at = @updated_at
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE sp_create_product_category
    @name VARCHAR(45),
    @created_at DATETIME,
    @updated_at DATETIME,
    @deleted_at DATETIME
AS
BEGIN
    INSERT INTO product_categories
        (name, created_at, updated_at, deleted_at)
    VALUES
        (@name, @created_at, @updated_at, @deleted_at);
END
GO

CREATE OR ALTER PROCEDURE sp_read_product_categories
AS
BEGIN
    SELECT *
    FROM product_categories;
END
GO

CREATE OR ALTER PROCEDURE sp_update_product_category
    @id INT,
    @name VARCHAR(45),
    @updated_at DATETIME,
    @deleted_at DATETIME
AS
BEGIN
    UPDATE product_categories
    SET name = @name, updated_at = @updated_at, deleted_at = @deleted_at
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE sp_delete_product_category
    @id INT
AS
BEGIN
    DELETE FROM product_categories
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE sp_create_product
    @product_category_id INT,
    @name VARCHAR(45),
    @brand VARCHAR(45),
    @code VARCHAR(45),
    @stock FLOAT,
    @price FLOAT,
    @picture BINARY,
    @created_at DATETIME,
    @updated_at DATETIME,
    @deleted_at DATETIME
AS
BEGIN
    INSERT INTO products
        (product_category_id, name, brand, code, stock, price, picture, created_at, updated_at, deleted_at)
    VALUES
        (@product_category_id, @name, @brand, @code, @stock, @price, @picture, @created_at, @updated_at, @deleted_at);
END
GO

CREATE OR ALTER PROCEDURE sp_read_products
AS
BEGIN
    SELECT *
    FROM products;
END
GO

CREATE OR ALTER PROCEDURE sp_update_product
    @id INT,
    @product_category_id INT,
    @name VARCHAR(45),
    @brand VARCHAR(45),
    @code VARCHAR(45),
    @stock FLOAT,
    @price FLOAT,
    @picture BINARY,
    @updated_at DATETIME,
    @deleted_at DATETIME
AS
BEGIN
    UPDATE products
    SET product_category_id = @product_category_id, name = @name, brand = @brand, code = @code, stock = @stock, price = @price, picture = @picture, updated_at = @updated_at, deleted_at = @deleted_at
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE sp_delete_product
    @id INT
AS
BEGIN
    DELETE FROM products
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE sp_create_product_order
    @order_id INT,
    @product_id INT,
    @quantity INT,
    @price FLOAT,
    @subtotal FLOAT
AS
BEGIN
    INSERT INTO product_orders
        (order_id, product_id, quantity, price, subtotal)
    VALUES
        (@order_id, @product_id, @quantity, @price, @subtotal);
END
GO

CREATE OR ALTER PROCEDURE sp_read_product_orders
AS
BEGIN
    SELECT *
    FROM product_orders;
END
GO

CREATE OR ALTER PROCEDURE sp_update_product_order
    @id INT,
    @order_id INT,
    @product_id INT,
    @quantity INT,
    @price FLOAT,
    @subtotal FLOAT
AS
BEGIN
    UPDATE product_orders
    SET order_id = @order_id, product_id = @product_id, quantity = @quantity, price = @price, subtotal = @subtotal
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE sp_delete_product_order
    @id INT
AS
BEGIN
    DELETE FROM product_orders
    WHERE id = @id;
END
GO

-- Mixture of tables

CREATE OR ALTER PROCEDURE sp_create_order_with_details
    @customer_id INT,
    @address VARCHAR(545),
    @total FLOAT,
    @order_details dbo.OrderDetails READONLY
AS
BEGIN
    DECLARE @order_id INT;
    DECLARE @status INT = 1;
    DECLARE @created_at DATETIME = GETDATE();

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO orders
        (customer_id, status, address, total, created_at, updated_at)
    VALUES
        (@customer_id, @status, @address, @total, @created_at, @updated_at);

        SET @order_id = SCOPE_IDENTITY();

        INSERT INTO product_orders
        (order_id, product_id, quantity, price, subtotal)
    SELECT @order_id, product_id, quantity, price, subtotal
    FROM @order_details;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO

-- INSERTS

-- Insert roles
INSERT INTO roles
    (name)
VALUES
    ('Admin'),
    ('User'),
    ('Guest');

-- Insert users
INSERT INTO users
    (role_id, full_name, status, email, password, phone_number, birth_date, created_at, updated_at)
VALUES
    (1, 'John Doe', 1, 'john.doe@example.com', 'password123', '1234567890', '1980-01-01', GETDATE(), GETDATE()),
    (2, 'Jane Smith', 1, 'jane.smith@example.com', 'password123', '0987654321', '1990-02-02', GETDATE(), GETDATE()),
    (2, 'Alice Johnson', 1, 'alice.johnson@example.com', 'password123', '1111111111', '1985-03-03', GETDATE(), GETDATE()),
    (3, 'Bob Brown', 1, 'bob.brown@example.com', 'password123', '2222222222', '1986-04-04', GETDATE(), GETDATE()),
    (1, 'Charlie Davis', 1, 'charlie.davis@example.com', 'password123', '3333333333', '1987-05-05', GETDATE(), GETDATE()),
    (2, 'David Evans', 1, 'david.evans@example.com', 'password123', '4444444444', '1988-06-06', GETDATE(), GETDATE()),
    (3, 'Eve Foster', 1, 'eve.foster@example.com', 'password123', '5555555555', '1989-07-07', GETDATE(), GETDATE()),
    (1, 'Frank Green', 1, 'frank.green@example.com', 'password123', '6666666666', '1990-08-08', GETDATE(), GETDATE()),
    (2, 'Grace Harris', 1, 'grace.harris@example.com', 'password123', '7777777777', '1991-09-09', GETDATE(), GETDATE()),
    (3, 'Hank Irving', 1, 'hank.irving@example.com', 'password123', '8888888888', '1992-10-10', GETDATE(), GETDATE()),
    (1, 'Ivy Johnson', 1, 'ivy.johnson@example.com', 'password123', '9999999999', '1993-11-11', GETDATE(), GETDATE()),
    (2, 'Jack King', 1, 'jack.king@example.com', 'password123', '1010101010', '1994-12-12', GETDATE(), GETDATE()),
    (3, 'Karen Lee', 1, 'karen.lee@example.com', 'password123', '1212121212', '1995-01-13', GETDATE(), GETDATE()),
    (1, 'Larry Moore', 1, 'larry.moore@example.com', 'password123', '1313131313', '1996-02-14', GETDATE(), GETDATE()),
    (2, 'Mona Nelson', 1, 'mona.nelson@example.com', 'password123', '1414141414', '1997-03-15', GETDATE(), GETDATE()),
    (3, 'Nina Owens', 1, 'nina.owens@example.com', 'password123', '1515151515', '1998-04-16', GETDATE(), GETDATE()),
    (1, 'Oscar Perry', 1, 'oscar.perry@example.com', 'password123', '1616161616', '1999-05-17', GETDATE(), GETDATE()),
    (2, 'Paul Quinn', 1, 'paul.quinn@example.com', 'password123', '1717171717', '2000-06-18', GETDATE(), GETDATE()),
    (3, 'Quincy Roberts', 1, 'quincy.roberts@example.com', 'password123', '1818181818', '2001-07-19', GETDATE(), GETDATE()),
    (1, 'Rachel Smith', 1, 'rachel.smith@example.com', 'password123', '1919191919', '2002-08-20', GETDATE(), GETDATE()),
    (2, 'Steve Turner', 1, 'steve.turner@example.com', 'password123', '2020202020', '2003-09-21', GETDATE(), GETDATE()),
    (3, 'Tina Underwood', 1, 'tina.underwood@example.com', 'password123', '2121212121', '2004-10-22', GETDATE(), GETDATE()),
    (1, 'Uma Vance', 1, 'uma.vance@example.com', 'password123', '2222222222', '2005-11-23', GETDATE(), GETDATE()),
    (2, 'Victor White', 1, 'victor.white@example.com', 'password123', '2323232323', '2006-12-24', GETDATE(), GETDATE()),
    (3, 'Wendy Xander', 1, 'wendy.xander@example.com', 'password123', '2424242424', '2007-01-25', GETDATE(), GETDATE()),
    (1, 'Xander Young', 1, 'xander.young@example.com', 'password123', '2525252525', '2008-02-26', GETDATE(), GETDATE()),
    (2, 'Yara Zane', 1, 'yara.zane@example.com', 'password123', '2626262626', '2009-03-27', GETDATE(), GETDATE()),
    (3, 'Zack Allen', 1, 'zack.allen@example.com', 'password123', '2727272727', '2010-04-28', GETDATE(), GETDATE()),
    (1, 'Amy Baker', 1, 'amy.baker@example.com', 'password123', '2828282828', '2011-05-29', GETDATE(), GETDATE()),
    (2, 'Brian Clark', 1, 'brian.clark@example.com', 'password123', '2929292929', '2012-06-30', GETDATE(), GETDATE()),
    (3, 'Cathy Davis', 1, 'cathy.davis@example.com', 'password123', '3030303030', '2013-07-31', GETDATE(), GETDATE());

-- Insert customers
INSERT INTO customers
    (user_id, nit, full_name, phone_number, email)
VALUES
    (1, '123456789', 'John Doe', '1234567890', 'john.doe@example.com'),
    (2, '987654321', 'Jane Smith', '0987654321', 'jane.smith@example.com'),
    (3, '111111111', 'Alice Johnson', '1111111111', 'alice.johnson@example.com'),
    (4, '222222222', 'Bob Brown', '2222222222', 'bob.brown@example.com'),
    (5, '333333333', 'Charlie Davis', '3333333333', 'charlie.davis@example.com'),
    (6, '444444444', 'David Evans', '4444444444', 'david.evans@example.com'),
    (7, '555555555', 'Eve Foster', '5555555555', 'eve.foster@example.com'),
    (8, '666666666', 'Frank Green', '6666666666', 'frank.green@example.com'),
    (9, '777777777', 'Grace Harris', '7777777777', 'grace.harris@example.com'),
    (10, '888888888', 'Hank Irving', '8888888888', 'hank.irving@example.com'),
    (11, '999999999', 'Ivy Johnson', '9999999999', 'ivy.johnson@example.com'),
    (12, '101010101', 'Jack King', '1010101010', 'jack.king@example.com'),
    (13, '121212121', 'Karen Lee', '1212121212', 'karen.lee@example.com'),
    (14, '131313131', 'Larry Moore', '1313131313', 'larry.moore@example.com'),
    (15, '141414141', 'Mona Nelson', '1414141414', 'mona.nelson@example.com'),
    (16, '151515151', 'Nina Owens', '1515151515', 'nina.owens@example.com'),
    (17, '161616161', 'Oscar Perry', '1616161616', 'oscar.perry@example.com'),
    (18, '171717171', 'Paul Quinn', '1717171717', 'paul.quinn@example.com'),
    (19, '181818181', 'Quincy Roberts', '1818181818', 'quincy.roberts@example.com'),
    (20, '191919191', 'Rachel Smith', '1919191919', 'rachel.smith@example.com'),
    (21, '202020202', 'Steve Turner', '2020202020', 'steve.turner@example.com'),
    (22, '212121212', 'Tina Underwood', '2121212121', 'tina.underwood@example.com'),
    (23, '222222222', 'Uma Vance', '2222222222', 'uma.vance@example.com'),
    (24, '232323232', 'Victor White', '2323232323', 'victor.white@example.com'),
    (25, '242424242', 'Wendy Xander', '2424242424', 'wendy.xander@example.com'),
    (26, '252525252', 'Xander Young', '2525252525', 'xander.young@example.com'),
    (27, '262626262', 'Yara Zane', '2626262626', 'yara.zane@example.com'),
    (28, '272727272', 'Zack Allen', '2727272727', 'zack.allen@example.com'),
    (29, '282828282', 'Amy Baker', '2828282828', 'amy.baker@example.com'),
    (30, '292929292', 'Brian Clark', '2929292929', 'brian.clark@example.com');

-- Insert orders
INSERT INTO orders
    (customer_id, status, address, total, created_at, updated_at)
VALUES
    (1, 1, '123 Main St', 100.50, GETDATE(), GETDATE()),
    (2, 2, '456 Elm St', 200.75, GETDATE(), GETDATE()),
    (3, 1, '789 Pine St', 150.00, GETDATE(), GETDATE()),
    (4, 2, '101 Maple St', 250.25, GETDATE(), GETDATE()),
    (5, 1, '202 Oak St', 300.50, GETDATE(), GETDATE()),
    (6, 2, '303 Birch St', 400.75, GETDATE(), GETDATE()),
    (7, 1, '404 Cedar St', 500.00, GETDATE(), GETDATE()),
    (8, 2, '505 Walnut St', 600.25, GETDATE(), GETDATE()),
    (9, 1, '606 Chestnut St', 700.50, GETDATE(), GETDATE()),
    (10, 2, '707 Spruce St', 800.75, GETDATE(), GETDATE()),
    (11, 1, '808 Fir St', 900.00, GETDATE(), GETDATE()),
    (12, 2, '909 Redwood St', 1000.25, GETDATE(), GETDATE()),
    (13, 1, '1010 Cypress St', 1100.50, GETDATE(), GETDATE()),
    (14, 2, '1111 Palm St', 1200.75, GETDATE(), GETDATE()),
    (15, 1, '1212 Willow St', 1300.00, GETDATE(), GETDATE()),
    (16, 2, '1313 Poplar St', 1400.25, GETDATE(), GETDATE()),
    (17, 1, '1414 Ash St', 1500.50, GETDATE(), GETDATE()),
    (18, 2, '1515 Beech St', 1600.75, GETDATE(), GETDATE()),
    (19, 1, '1616 Elm St', 1700.00, GETDATE(), GETDATE()),
    (20, 2, '1717 Maple St', 1800.25, GETDATE(), GETDATE()),
    (21, 1, '1818 Oak St', 1900.50, GETDATE(), GETDATE()),
    (22, 2, '1919 Birch St', 2000.75, GETDATE(), GETDATE()),
    (23, 1, '2020 Cedar St', 2100.00, GETDATE(), GETDATE()),
    (24, 2, '2121 Walnut St', 2200.25, GETDATE(), GETDATE()),
    (25, 1, '2222 Chestnut St', 2300.50, GETDATE(), GETDATE()),
    (26, 2, '2323 Spruce St', 2400.75, GETDATE(), GETDATE()),
    (27, 1, '2424 Fir St', 2500.00, GETDATE(), GETDATE()),
    (28, 2, '2525 Redwood St', 2600.25, GETDATE(), GETDATE()),
    (29, 1, '2626 Cypress St', 2700.50, GETDATE(), GETDATE()),
    (30, 2, '2727 Palm St', 2800.75, GETDATE(), GETDATE());

-- Insert product categories
INSERT INTO product_categories
    (name, created_at, updated_at, deleted_at)
VALUES
    ('Electronics', GETDATE(), GETDATE(), NULL),
    ('Clothing', GETDATE(), GETDATE(), NULL),
    ('Home Appliances', GETDATE(), GETDATE(), NULL),
    ('Books', GETDATE(), GETDATE(), NULL),
    ('Toys', GETDATE(), GETDATE(), NULL),
    ('Furniture', GETDATE(), GETDATE(), NULL),
    ('Sports', GETDATE(), GETDATE(), NULL),
    ('Beauty', GETDATE(), GETDATE(), NULL),
    ('Automotive', GETDATE(), GETDATE(), NULL),
    ('Garden', GETDATE(), GETDATE(), NULL),
    ('Music', GETDATE(), GETDATE(), NULL),
    ('Office Supplies', GETDATE(), GETDATE(), NULL),
    ('Pet Supplies', GETDATE(), GETDATE(), NULL),
    ('Groceries', GETDATE(), GETDATE(), NULL),
    ('Health', GETDATE(), GETDATE(), NULL),
    ('Jewelry', GETDATE(), GETDATE(), NULL),
    ('Shoes', GETDATE(), GETDATE(), NULL),
    ('Tools', GETDATE(), GETDATE(), NULL),
    ('Video Games', GETDATE(), GETDATE(), NULL),
    ('Watches', GETDATE(), GETDATE(), NULL),
    ('Baby Products', GETDATE(), GETDATE(), NULL),
    ('Movies', GETDATE(), GETDATE(), NULL),
    ('Stationery', GETDATE(), GETDATE(), NULL),
    ('Crafts', GETDATE(), GETDATE(), NULL),
    ('Travel', GETDATE(), GETDATE(), NULL),
    ('Outdoors', GETDATE(), GETDATE(), NULL),
    ('Luggage', GETDATE(), GETDATE(), NULL),
    ('Software', GETDATE(), GETDATE(), NULL),
    ('Musical Instruments', GETDATE(), GETDATE(), NULL),
    ('Industrial', GETDATE(), GETDATE(), NULL),
    ('Art', GETDATE(), GETDATE(), NULL),
    ('Collectibles', GETDATE(), GETDATE(), NULL);

-- Insert products
INSERT INTO products
    (product_category_id, name, brand, code, stock, price, picture, created_at, updated_at, deleted_at)
VALUES
    (1, 'Smartphone', 'BrandA', 'SP123', 50, 299.99, NULL, GETDATE(), GETDATE(), NULL),
    (2, 'T-Shirt', 'BrandB', 'TS456', 100, 19.99, NULL, GETDATE(), GETDATE(), NULL),
    (1, 'Laptop', 'BrandC', 'LP789', 30, 799.99, NULL, GETDATE(), GETDATE(), NULL),
    (2, 'Jeans', 'BrandD', 'JN012', 60, 49.99, NULL, GETDATE(), GETDATE(), NULL),
    (3, 'Refrigerator', 'BrandE', 'RF345', 20, 999.99, NULL, GETDATE(), GETDATE(), NULL),
    (4, 'Novel', 'BrandF', 'NV678', 150, 14.99, NULL, GETDATE(), GETDATE(), NULL),
    (5, 'Action Figure', 'BrandG', 'AF901', 80, 24.99, NULL, GETDATE(), GETDATE(), NULL),
    (6, 'Sofa', 'BrandH', 'SF234', 10, 499.99, NULL, GETDATE(), GETDATE(), NULL),
    (7, 'Basketball', 'BrandI', 'BB567', 40, 29.99, NULL, GETDATE(), GETDATE(), NULL),
    (8, 'Lipstick', 'BrandJ', 'LS890', 70, 9.99, NULL, GETDATE(), GETDATE(), NULL),
    (9, 'Car Tire', 'BrandK', 'CT123', 25, 119.99, NULL, GETDATE(), GETDATE(), NULL),
    (10, 'Lawn Mower', 'BrandL', 'LM456', 15, 299.99, NULL, GETDATE(), GETDATE(), NULL),
    (11, 'Guitar', 'BrandM', 'GT789', 35, 199.99, NULL, GETDATE(), GETDATE(), NULL),
    (12, 'Notebook', 'BrandN', 'NB012', 90, 2.99, NULL, GETDATE(), GETDATE(), NULL),
    (13, 'Dog Food', 'BrandO', 'DF345', 50, 39.99, NULL, GETDATE(), GETDATE(), NULL),
    (14, 'Cereal', 'BrandP', 'CR678', 100, 4.99, NULL, GETDATE(), GETDATE(), NULL),
    (15, 'Vitamins', 'BrandQ', 'VT901', 60, 19.99, NULL, GETDATE(), GETDATE(), NULL),
    (16, 'Necklace', 'BrandR', 'NK234', 40, 49.99, NULL, GETDATE(), GETDATE(), NULL),
    (17, 'Running Shoes', 'BrandS', 'RS567', 30, 89.99, NULL, GETDATE(), GETDATE(), NULL),
    (18, 'Hammer', 'BrandT', 'HM890', 50, 14.99, NULL, GETDATE(), GETDATE(), NULL),
    (19, 'Video Game', 'BrandU', 'VG123', 70, 59.99, NULL, GETDATE(), GETDATE(), NULL),
    (20, 'Wristwatch', 'BrandV', 'WW456', 20, 149.99, NULL, GETDATE(), GETDATE(), NULL),
    (21, 'Baby Stroller', 'BrandW', 'BS789', 15, 199.99, NULL, GETDATE(), GETDATE(), NULL),
    (22, 'DVD', 'BrandX', 'DVD012', 100, 9.99, NULL, GETDATE(), GETDATE(), NULL),
    (23, 'Pen', 'BrandY', 'PN345', 200, 1.99, NULL, GETDATE(), GETDATE(), NULL),
    (24, 'Glue', 'BrandZ', 'GL678', 150, 2.49, NULL, GETDATE(), GETDATE(), NULL),
    (25, 'Travel Bag', 'BrandAA', 'TB901', 25, 79.99, NULL, GETDATE(), GETDATE(), NULL),
    (26, 'Tent', 'BrandBB', 'TN234', 20, 129.99, NULL, GETDATE(), GETDATE(), NULL),
    (27, 'Suitcase', 'BrandCC', 'SC567', 30, 99.99, NULL, GETDATE(), GETDATE(), NULL),
    (28, 'Antivirus Software', 'BrandDD', 'AS890', 50, 49.99, NULL, GETDATE(), GETDATE(), NULL),
    (29, 'Drum Set', 'BrandEE', 'DS123', 10, 499.99, NULL, GETDATE(), GETDATE(), NULL),
    (30, 'Welding Machine', 'BrandFF', 'WM456', 15, 299.99, NULL, GETDATE(), GETDATE(), NULL);

-- Insert product orders
INSERT INTO product_orders
    (order_id, product_id, quantity, price, subtotal)
VALUES
    (1, 1, 2, 299.99, 599.98),
    (2, 2, 5, 19.99, 99.95),
    (3, 3, 1, 799.99, 799.99),
    (4, 4, 3, 49.99, 149.97),
    (5, 5, 1, 999.99, 999.99),
    (6, 6, 2, 14.99, 29.98),
    (7, 7, 4, 24.99, 99.96),
    (8, 8, 5, 9.99, 49.95),
    (9, 9, 2, 119.99, 239.98),
    (10, 10, 1, 299.99, 299.99),
    (11, 11, 3, 199.99, 599.97),
    (12, 12, 10, 2.99, 29.90),
    (13, 13, 4, 39.99, 159.96),
    (14, 14, 6, 4.99, 29.94),
    (15, 15, 2, 19.99, 39.98),
    (16, 16, 1, 49.99, 49.99),
    (17, 17, 3, 89.99, 269.97),
    (18, 18, 5, 14.99, 74.95),
    (19, 19, 2, 59.99, 119.98),
    (20, 20, 1, 149.99, 149.99),
    (21, 21, 1, 199.99, 199.99),
    (22, 22, 8, 9.99, 79.92),
    (23, 23, 15, 1.99, 29.85),
    (24, 24, 7, 2.49, 17.43),
    (25, 25, 2, 79.99, 159.98),
    (26, 26, 1, 129.99, 129.99),
    (27, 27, 3, 99.99, 299.97),
    (28, 28, 2, 49.99, 99.98),
    (29, 29, 1, 499.99, 499.99),
    (30, 30, 1, 299.99, 299.99),
    (1, 3, 2, 799.99, 1599.98),
    (2, 4, 1, 49.99, 49.99);

GO

-- VIEWS CREATION

IF NOT EXISTS (SELECT *
FROM sys.views
WHERE name = 'vw_total_active_products_in_stock')
    BEGIN
    EXEC('CREATE VIEW vw_total_active_products_in_stock AS SELECT 1 AS dummy');
    EXEC('ALTER VIEW vw_total_active_products_in_stock AS SELECT COUNT(*) AS total_active_products FROM products WHERE stock > 0');
END
    GO

IF NOT EXISTS (SELECT *
FROM sys.views
WHERE name = 'vw_total_quetzales_august_2024')
    BEGIN
    EXEC('CREATE VIEW vw_total_quetzales_august_2024 AS SELECT 1 AS dummy');
    EXEC('ALTER VIEW vw_total_quetzales_august_2024 AS SELECT SUM(total) AS total_quetzales FROM orders WHERE MONTH(created_at) = 8 AND YEAR(created_at) = 2024');
END
    GO

IF NOT EXISTS (SELECT *
FROM sys.views
WHERE name = 'vw_top_10_customers_by_orders')
    BEGIN
    EXEC('CREATE VIEW vw_top_10_customers_by_orders AS SELECT 1 AS dummy');
    EXEC('ALTER VIEW vw_top_10_customers_by_orders AS SELECT TOP 1000 c.full_name, SUM(o.total) AS total_consumption FROM customers c JOIN orders o ON c.id = o.customer_id GROUP BY c.full_name ORDER BY total_consumption DESC');
END
    GO

IF NOT EXISTS (SELECT *
FROM sys.views
WHERE name = 'vw_top_10_products_sold')
    BEGIN
    EXEC('CREATE VIEW vw_top_10_products_sold AS SELECT 1 AS dummy');
    EXEC('ALTER VIEW vw_top_10_products_sold AS SELECT TOP 1000 p.name, SUM(po.quantity) AS total_sold FROM products p JOIN product_orders po ON p.id = po.product_id GROUP BY p.name ORDER BY total_sold ASC');
END
    GO

-- Execute views

SELECT *
FROM vw_total_active_products_in_stock;

SELECT *
FROM vw_total_quetzales_august_2024;

SELECT *
FROM vw_top_10_customers_by_orders;

SELECT *
FROM vw_top_10_products_sold;
