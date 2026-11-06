--Creating the database

Create database Agre_Market_Flow;
Use Agre_Market_Flow;

----------------------------------------------------------------
--Creating tables

CREATE TABLE Users(
user_id INT NOT NULL PRIMARY KEY,
user_name Varchar(20),
password Varchar(10) NOT NULL,
email Varchar(50) UNIQUE,
phone_number INT,
role_name Varchar(10));

CREATE TABLE Farmers(
first_name Varchar(25),
last_name Varchar(25),
farmer_id INT NOT NULL PRIMARY KEY,
user_id INT NOT NULL, 
FOREIGN KEY(user_id) REFERENCES Users(user_id));

CREATE TABLE Retailers(
retailer_id INT NOT NULL PRIMARY KEY,
first_name Varchar(25),
Last_name Varchar(25),
user_id INT NOT NULL, 
FOREIGN KEY(user_id) REFERENCES Users(user_id));

CREATE TABLE Transporters(
transporter_id INT NOT NULL PRIMARY KEY,
first_name Varchar(25),
last_name Varchar(25),
license_plate Varchar(10),
user_id INT NOT NULL,
FOREIGN KEY(user_id) REFERENCES Users (user_id));

CREATE TABLE Locations(
location_id INT NOT NULL PRIMARY KEY, 
city Varchar(25),
region Varchar(25),
country Varchar(25));

CREATE TABLE Farms(
farm_id INT NOT NULL PRIMARY KEY,
farm_name Varchar(25),
location_id INT NOT NULL,
farmer_id INT NOT NULL,
FOREIGN KEY(location_id) REFERENCES Locations(location_id),
FOREIGN KEY(farmer_id) REFERENCES Farmers(farmer_id));

CREATE TABLE Products(
product_id INT PRIMARY KEY,
product_name Varchar(25), 
quantity INT NOT NULL);

CREATE TABLE Farmers_Product( 
farmers_product_id INT NOT NULL, 
farmer_id INT NOT NULL, 
product_id INT NOT NULL,
FOREIGN KEY(farmer_id) REFERENCES Farmers(farmer_id),
FOREIGN KEY(product_id) REFERENCES Products (product_id));

CREATE TABLE Descriptions( 
description_id INT NOT NULL PRIMARY KEY,
description_status Varchar(25), 
price Decimal(10,2) NOT NULL,
category Varchar(25));

CREATE TABLE Product_Descriptions(
product_description_id INT NOT NULL,
product_id INT NOT NULL,
description_id INT NOT NULL, 
FOREIGN KEY(product_id) REFERENCES Products (product_id), 
FOREIGN KEY(description_id) REFERENCES Descriptions(description_id));

CREATE TABLE Orders(
order_id INT NOT NULL PRIMARY KEY,
order_date Date,
total_price Decimal(10,2) NOT NULL,
order_status Varchar(25), 
retailer_id INT NOT NULL, 
FOREIGN KEY(retailer_id) REFERENCES Retailers(retailer_id));

CREATE TABLE Product_Order(
product_order_id INT NOT NULL,
product_id INT NOT NULL,
order_id INT NOT NULL,
FOREIGN KEY(product_id) REFERENCES Products(product_id),
FOREIGN KEY(order_id) REFERENCES Orders (order_id));

CREATE TABLE Delivery(
delivery_id INT NOT NULL PRIMARY KEY,
pickup_time TIME NOT NULL,
delivery_time TIME,
delivery_status Varchar(25) NOT NULL);

CREATE TABLE Transporters_Delivery(
transporters_delivery_id INT NOT NULL,
transporter_id INT NOT NULL,
delivery_id INT NOT NULL,
FOREIGN KEY(transporter_id) REFERENCES
Transporters (transporter_id),
FOREIGN KEY(delivery_id) REFERENCES Delivery(delivery_id));

CREATE TABLE Notifications(
nofication_id INT NOT NULL PRIMARY KEY, 
date_sent Date NOT NULL,
notification_status Varchar(25),
user_id INT NOT NULL,
FOREIGN KEY(user_id) REFERENCES Users (user_id));


ALTER TABLE Users
ALTER COLUMN role_name VARCHAR(15);

Alter Table Notifications  -- nofication-natification
Drop column nofication_id;

Alter Table Notifications  -- Updated Notifications table: changed notification _id to an IDENTITY column
ADD notification_id INT    -- So SQL Server Automatically generates unique IDs for each notification.
Identity(1,1) Primary Key;

SELECT * FROM Notifications;

----------------------------------------------------------------------------------
--Inserting data into tables

INSERT INTO Users (user_id, user_name, password, email, phone_number, role_name)
VALUES 
(1, 'john_farmer', 'pass123', 'johnfarmer@email.com', 264123456, 'Farmer'),
(2, 'susan_farmer', 'pass456', 'susanf@email.com', 264987654, 'Farmer'),
(3, 'mike_retail', 'pass789', 'mikert@email.com', 264111222, 'Retailer'),
(4, 'anna_retail', 'pass321', 'annart@email.com', 264333444, 'Retailer'),
(5, 'peter_trans', 'pass654', 'petertrans@email.com', 264555666, 'Transporter'),
(6, 'lucy_trans', 'pass852', 'lucytrans@email.com', 264777888, 'Transporter');

INSERT INTO Farmers (first_name, last_name, farmer_id, user_id)
VALUES
('John', 'Smith', 1, 1),
('Susan', 'Brown', 2, 2);

INSERT INTO Retailers (retailer_id, first_name, last_name, user_id)
VALUES
(1, 'Mike', 'Johnson', 3),
(2, 'Anna', 'Williams', 4);

INSERT INTO Transporters (transporter_id, first_name, last_name, license_plate, user_id)
VALUES
(1, 'Peter', 'Miller', 'NAA1234', 5),
(2, 'Lucy', 'Davis', 'NBB5678', 6);

INSERT INTO Locations (location_id, city, region, country)
VALUES
(1, 'Windhoek', 'Khomas', 'Namibia'),
(2, 'Swakopmund', 'Erongo', 'Namibia'),
(3, 'Otjiwarongo', 'Otjozondjupa', 'Namibia');

INSERT INTO Farms (farm_id, farm_name, location_id, farmer_id)
VALUES
(1, 'Green Valley Farm', 1, 1),
(2, 'Sunny Fields', 2, 2);

INSERT INTO Products (product_id, product_name, quantity)
VALUES
(10, 'Tomatoes', 50),
(11, 'Potatoes', 100),
(12, 'Carrots', 75),
(13, 'Apples', 40);

INSERT INTO Farmers_Product (farmers_product_id, farmer_id, product_id)
VALUES
(1, 1, 10),
(2, 1, 11),
(3, 2, 12),
(4, 2, 13);

INSERT INTO Descriptions (description_id, description_status, price, category)
VALUES
(1, 'Fresh', 15.00, 'Vegetable'),
(2, 'Organic', 20.00, 'Vegetable'),
(3, 'Sweet', 25.00, 'Fruit'),
(4, 'Bulk', 10.00, 'Root');

INSERT INTO Product_Descriptions (product_description_id, product_id, description_id)
VALUES
(1, 10, 1),
(2, 11, 4),
(3, 12, 2),
(4, 13, 3);

INSERT INTO Orders (order_id, order_date, total_price, order_status, retailer_id)
VALUES
(101, '2025-09-28', 200.50, 'Pending', 1),
(102, '2025-09-27', 150.00, 'Completed', 2);

INSERT INTO Product_Order (product_order_id, product_id, order_id)
VALUES
(501, 10, 101),
(502, 12, 102);

--
INSERT INTO Delivery (delivery_id, pickup_time, delivery_time, delivery_status)
VALUES
(1, '09:00:00', '11:00:00', 'Delivered'),
(2, '10:00:00', NULL, 'In Transit');

INSERT INTO Transporters_Delivery (transporters_delivery_id, transporter_id, delivery_id)
VALUES
(1, 1, 1),
(2, 2, 2);

INSERT INTO Notifications (date_sent, notification_status, user_id) -- 
VALUES
('2025-09-27', 'Sent', 3),
('2025-09-27', 'Pending', 4),
('2025-09-28', 'Delivered', 1),
('2025-09-27', 'Sent', 3);

SELECT * FROM Notifications;
------------------------------------------------------------------------------------------
-- Triggers and Procedures

use Agre_Market_Flow;


--Trigger: Update stock when a product enters an order

DROP Trigger trg_update_product_quantity;


-----------------------------------------------------
--1 Trigger to prevent stock from going negative
---------------------------------------------------
CREATE TRIGGER 
PreventNegativeStock
ON Products
AFTER UPDATE
AS
BEGIN
    --'inserted' is a temporary table holding the new values
    -- Check if any product quantity is less than 0*
    IF EXISTS (SELECT * FROM inserted WHERE quantity < 0)
    BEGIN
            RAISERROR('Stock cannot be negative!', 16,1);
        --Rollback the update if rule is violated*
        ROLLBACK TRANSACTION;
    END
END





------------------------------------------------------------
--1 Procedure to add a new product
------------------------------------------------------------

Alter PROCEDURE  
AddProduct
	@ProductId INT,           -- Input parameter: product id
    @ProductName VARCHAR(50), -- Input parameter: product name
    @Quantity INT             -- Input parameter: product quantity
AS
BEGIN
    -- Basic validation: check if quantity is greater than zero
    IF @Quantity <= 0
    BEGIN
        RAISERROR('Quantity must be > 0', 16, 1); -- Throw error if invalid
        RETURN; -- Exit the procedure without inserting
    END

    -- Insert product into Products table
    INSERT INTO Products(product_id, product_name, quantity)
    VALUES (@ProductId, @ProductName, @Quantity);
END

--EXEC AddProduct 14, 'Letuce', 50;



---------------------------------------------------------------
--3 TRIGGER: Update Stock Automatically
-- After a product is added to Product_Order, reduce stock
--------------------------------------------------------------

CREATE OR ALTER TRIGGER
trg_UpdateStock
ON Product_Order
AFTER INSERT 
AS
BEGIN
    DECLARE @prod_id INT;

    SELECT @prod_id = product_id FROM inserted;

    UPDATE Products
    SET quantity = quantity - 1
    WHERE product_id = @prod_id;

    PRINT 'Stock updated automatically.';
END;
GO








--------------------------------------------------------------------
--4 STORED PROCEDURE: Creates an order, links a product, and updates stock inside one transaction
--------------------------------------------------------------------
ALTER PROCEDURE sp_CreateOrder
    @order_id INT,
    @retailer_id INT,
    @product_id INT,
    @quantity INT,
    @price DECIMAL(10,2)
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Insert Order
        INSERT INTO Orders(order_id, retailer_id, total_price, order_date, order_status)
        VALUES (@order_id, @retailer_id, @price * @quantity, GETDATE(), 'Pending');

        -- Insert Product_Order
        INSERT INTO Product_Order(product_order_id, product_id, order_id)
        VALUES (@order_id, @product_id, @order_id);

        -- Update Stock
        UPDATE Products
        SET quantity = quantity - @quantity
        WHERE product_id = @product_id;

        COMMIT TRANSACTION;
        PRINT 'Order created successfully!';
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        PRINT 'Error: Order creation failed.';

   END CATCH
END;
GO

-- ▶️ Example usage:
EXEC sp_CreateOrder @order_id = 103, @retailer_id = 1, @product_id = 14, @quantity = 3, @price = 50.00;








--------------------------------------------------------------------
--5 This trigger executes automatically after a new record is inserted into the Orders table
--------------------------------------------------------------------
CREATE TRIGGER NewOrderNotification
ON Orders
AFTER INSERT
AS
BEGIN
    -- Insert a new record into the Notifications table
    INSERT INTO Notifications (date_sent, notification_status, user_id)
    SELECT 
        -- Current date and time when the notification is created
        GETDATE() AS date_sent,

        -- Fixed message indicating that a new order has been placed
        'New Order Placed' AS notification_status,

        -- The user (retailer owner) who should receive the notification
        u.user_id
    FROM inserted i  -- "inserted" is a logical table containing the new rows added to Orders
    JOIN Retailers r ON i.retailer_id = r.retailer_id   -- Link the order to the retailer
    JOIN Users u ON r.user_id = u.user_id;              -- Link the retailer to the system user
END; 





-- Show all procedures
--Select name, create_date, modify_date from sys.procedures Order By name;

Create procedure 
GetUpperName
	@FirstName Varchar(25),
	@UpperName Varchar(25) OUTPUT
As Begin
	Set @UpperName=Upper(@FirstName);
End

Declare @R Varchar(25);
Exec GetUpperName 'Talita', @R Output;
Print @R

begin TRAN;
Insert Into Products(product_id, quantity) values(11, 5);
Update Products Set quantity=quantity-3 where product_id=11;
If (select quantity from Products where product_id=11)<0
begin
Print'erro: insuficient quantity.';
Rollback TRAN;
END 
Else
begin 
Commit TRAN;
Print'completed.';
End;
Go
Select * from Products

Create Procedure UpperName
	@productID INT,
	@UpperName Varchar (25) OUTPUT
As
Begin
	Select @UpperName= UPPER (product_name)
	From Products
	Where product_id=	@productID;
End

Declare @R Varchar(25);
Exec UpperName 11,
@R OUTPUT;
Print @R;



Alter PROCEDURE GetNomeUpperCase
    @Id INT
AS
BEGIN
    SELECT UPPER(product_name) As UpperCase
    FROM Products
    WHERE product_id = @Id;
END;

Exec GetNomeUpperCase 11 