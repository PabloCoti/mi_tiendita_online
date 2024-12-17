IF EXISTS (SELECT *
FROM sys.databases
WHERE name = 'GDA00594-OT-Pablo-Coti')
BEGIN
    USE [GDA00594-OT-Pablo-Coti];
END
GO

CREATE OR ALTER PROCEDURE create_role
    @code VARCHAR(45),
    @name VARCHAR(45)
AS
BEGIN
    INSERT INTO roles
        (code, name)
    VALUES
        (@code, @name);

    SELECT *
    FROM roles
    WHERE id = SCOPE_IDENTITY();
END
GO

CREATE OR ALTER PROCEDURE read_roles
AS
BEGIN
    SELECT *
    FROM roles;
END
GO

CREATE OR ALTER PROCEDURE read_roles_by_id
    @id INT
AS
BEGIN
    SELECT *
    FROM roles
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE update_role
    @id INT,
    @name VARCHAR(45)
AS
BEGIN
    UPDATE roles 
    SET name = @name, updated_at = GETDATE()
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE delete_role
    @id INT
AS
BEGIN
    UPDATE roles
    SET deleted_at = GETDATE()
    WHERE id = @id;
END
GO

-- USER
CREATE OR ALTER PROCEDURE create_user
    @role_id INT,
    @full_name VARCHAR(45),
    @email VARCHAR(45),
    @password VARCHAR(45),
    @phone_number VARCHAR(45),
    @birth_date DATE
AS
BEGIN
    INSERT INTO users
        (role_id, full_name, email, password, phone_number, birth_date)
    VALUES
        (@role_id, @full_name, @email, @password, @phone_number, @birth_date);

    SELECT *
    FROM users
    WHERE id = SCOPE_IDENTITY();
END
GO

CREATE OR ALTER PROCEDURE read_users
AS
BEGIN
    SELECT *
    FROM users;
END
GO

CREATE OR ALTER PROCEDURE read_users_by_id
    @id INT
AS
BEGIN
    SELECT *
    FROM users
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE update_user
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

CREATE OR ALTER PROCEDURE create_customer
    @user_id INT,
    @nit VARCHAR(245)
AS
BEGIN
    INSERT INTO customers
        (user_id, nit)
    VALUES
        (@user_id, @nit);

    SELECT *
    FROM customers
    WHERE id = SCOPE_IDENTITY();
END
GO

CREATE OR ALTER PROCEDURE read_customers
AS
BEGIN
    SELECT *
    FROM customers;
END
GO

CREATE OR ALTER PROCEDURE read_customers_by_id
    @id INT
AS
BEGIN
    SELECT *
    FROM customers
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE update_customer
    @id INT,
    @nit VARCHAR(245)
AS
BEGIN
    UPDATE customers
    SET nit = @nit
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE create_order
    @customer_id INT,
    @address VARCHAR(545),
    @total FLOAT
AS
BEGIN
    INSERT INTO orders
        (customer_id, address, total)
    VALUES
        (@customer_id, @address, @total);

    SELECT *
    FROM orders
    WHERE id = SCOPE_IDENTITY();
END
GO

CREATE OR ALTER PROCEDURE read_orders
AS
BEGIN
    SELECT *
    FROM orders;
END
GO

CREATE OR ALTER PROCEDURE read_orders_by_id
    @id INT
AS
BEGIN
    SELECT *
    FROM orders
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE update_order
    @id INT,
    @status INT,
    @address VARCHAR(545)
AS
BEGIN
    UPDATE orders
    SET status = @status, address = @address, updated_at = GETDATE()
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE create_product_category
    @name VARCHAR(45)
AS
BEGIN
    INSERT INTO product_categories
        (name)
    VALUES
        (@name);

    SELECT *
    FROM product_categories
    WHERE id = SCOPE_IDENTITY();
END
GO

CREATE OR ALTER PROCEDURE read_product_categories
AS
BEGIN
    SELECT *
    FROM product_categories;
END
GO

CREATE OR ALTER PROCEDURE read_product_categories_by_id
    @id INT
AS
BEGIN
    SELECT *
    FROM product_categories
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE update_product_category
    @id INT,
    @name VARCHAR(45)
AS
BEGIN
    UPDATE product_categories
    SET name = @name, updated_at = GETDATE()
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE delete_product_category
    @id INT
AS
BEGIN
    UPDATE product_categories
    SET deleted_at = GETDATE()
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE create_product
    @product_category_id INT,
    @name VARCHAR(45),
    @brand VARCHAR(45),
    @code VARCHAR(45),
    @stock FLOAT,
    @price FLOAT,
    @picture BINARY
AS
BEGIN
    INSERT INTO products
        (product_category_id, name, brand, code, stock, price, picture)
    VALUES
        (@product_category_id, @name, @brand, @code, @stock, @price, @picture);

    SELECT *
    FROM products
    WHERE id = SCOPE_IDENTITY();
END
GO

CREATE OR ALTER PROCEDURE read_products
AS
BEGIN
    SELECT *
    FROM products;
END
GO

CREATE OR ALTER PROCEDURE read_products_by_id
    @id INT
AS
BEGIN
    SELECT *
    FROM products
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE update_product
    @id INT,
    @product_category_id INT,
    @name VARCHAR(45),
    @brand VARCHAR(45),
    @code VARCHAR(45),
    @stock FLOAT,
    @price FLOAT,
    @picture BINARY
AS
BEGIN
    UPDATE products
    SET product_category_id = @product_category_id, name = @name, brand = @brand, code = @code, stock = @stock, price = @price, picture = @picture, updated_at = GETDATE()
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE delete_product
    @id INT
AS
BEGIN
    UPDATE products
    SET deleted_at = GETDATE()
    WHERE id = @id;
END
GO

CREATE OR ALTER PROCEDURE create_product_order
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

    SELECT *
    FROM product_orders
    WHERE id = SCOPE_IDENTITY();
END
GO

CREATE OR ALTER PROCEDURE read_product_orders
AS
BEGIN
    SELECT *
    FROM product_orders;
END
GO

CREATE OR ALTER PROCEDURE update_product_order
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

CREATE OR ALTER PROCEDURE delete_product_order
    @id INT
AS
BEGIN
    DELETE FROM product_orders
    WHERE id = @id;
END
GO

