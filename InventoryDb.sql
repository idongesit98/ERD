-- Create a Database
CREATE DATABASE inventory_db;
USE inventory_db;

-- Create Tables Users,Product,Categories,Order,Order_Items
CREATE TABLE Users(
    user_id integer PRIMARY KEY AUTO_INCREMENT,
    user_name VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(255) NOT NULL,
    role ENUM('Admin','User') NOT NULL DEFAULT 'User',
    gender ENUM('male','female'),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Product(
    prod_id integer PRIMARY KEY AUTO_INCREMENT,
    prod_name VARCHAR(255) NOT NULL,
    price VARCHAR(255) NOT NULL,
    size ENUM('Large','Small','Medium','Extra-Large'),
    category_id integer NOT NULL,
    stock_quantity integer DEFAULT 0,
    description VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(category_id) REFERENCES Categories(cat_id) ON DELETE CASCADE
);

CREATE TABLE Categories(
    cat_id integer PRIMARY KEY AUTO_INCREMENT,
    cat_name VARCHAR(255) NOT NULL,
    cat_desc VARCHAR(255) NOT NULL
);

CREATE TABLE Orders(
    order_id integer PRIMARY KEY AUTO_INCREMENT,
    user_id integer PRIMARY KEY AUTO_INCREMENT,
    status ENUM('pending','approved','disapproved') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY(user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

CREATE TABLE Order_Items(
    order_item_id integer PRIMARY KEY AUTO_INCREMENT
    order_id integer NOT NULL,
    prod_id integer NOT NULL
    quantity integer NOT NULL
    FOREIGN KEY(order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY(prod_id) REFERENCES Product(prod_id) ON DELETE CASCADE
)

-- Insert Values into the tables
INSERT INTO Users
(user_name,password,email,phone_number,role,gender)
VALUES("idongesit","compton","idongesit@gmail.com","09051810535","User","male");

INSERT INTO Categories
(cat_name,cat_desc);
VALUES("Groceries","Food meant to be eaten");

INSERT INTO Product
(prod_name,price,size,category_id,stock_quantity,description)
VALUES("Bournvita","#300","Small","1","20","Beverage");

INSERT INTO Orders
(user_id,status)
VALUES(1,"approved");

INSERT INTO Order_Items
(order_id,prod_id,quantity)
VALUES(1,1,100);

-- Querying The Tables
SELECT * FROM Product JOIN Categories ON Categories.cat_id = Product.category_id;

SELECT * FROM Orders JOIN Users ON Users.user_id = Orders.user_id;

--Updating the database
UPDATE
    Product
SET    
    price = #1000
WHERE
    prod_id = 1;

UPDATE
	Product
 SET
	size = "Medium"
 WHERE
	prod_id = 1;
    
--Delete from the database
DELETE FROM 
    Product
WHERE 
    prod_id = 2;

DELETE FROM 
    Categories
WHERE 
    cat_id = 3;      

--SELECT FROM Database using Join
SELECT 
    Users.user_name, 
    Users.email, 
    COUNT(orders.order_id) AS total_orders
FROM 
    users
JOIN 
    orders
ON 
    users.user_id = orders.user_id
GROUP BY 
    users.user_id;          