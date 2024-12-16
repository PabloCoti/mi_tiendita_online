IF EXISTS (SELECT *
FROM sys.databases
WHERE name = 'GDA00594-OT-Pablo-Coti')
BEGIN
    USE [GDA00594-OT-Pablo-Coti];
END
GO

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

CREATE OR ALTER PROCEDURE sp_read_roles_by_id
    @id INT
AS
BEGIN
    SELECT *
    FROM roles
    WHERE id = @id;
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
    DECLARE @updated_at DATETIME = GETDATE();
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
    @status INT,
    @address VARCHAR(545),
    @total FLOAT,
    @products_json NVARCHAR(MAX)
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        INSERT INTO orders
        (customer_id, status, address, total, created_at, updated_at)
    VALUES
        (@customer_id, @status, @address, @total, GETDATE(), NULL);
        
        DECLARE @order_id INT = SCOPE_IDENTITY(); 
        
        INSERT INTO product_orders
        (order_id, product_id, quantity, price, subtotal)
    SELECT
        @order_id,
        product_id,
        quantity,
        price,
        quantity * price
    FROM OPENJSON(@products_json) 
        WITH (
            product_id INT '$.product_id',
            quantity INT '$.quantity',
            price FLOAT '$.price'
        );
        
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO
