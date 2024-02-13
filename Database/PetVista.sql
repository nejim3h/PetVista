CREATE DATABASE IF NOT EXISTS PETVISTA;
USE PETVISTA;

CREATE TABLE IF NOT EXISTS Customer (
    email VARCHAR(50) PRIMARY KEY,
    password VARCHAR(30) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    building VARCHAR(50) NOT NULL,
    street VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    pin INT NOT NULL,
    phone_number BIGINT UNIQUE NOT NULL,  -- Unique constraint
    pet_type VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS Product (
    itemID INT PRIMARY KEY AUTO_INCREMENT,  -- Auto-increment
    item_name VARCHAR(30),
    category VARCHAR(30),
    quantity INT CHECK (quantity > 0),  -- Check constraint
    image VARCHAR(100),
    item_info VARCHAR(100),
	item_rating INT CHECK (item_rating >= 0 AND item_rating <= 5)
);

CREATE INDEX idx_category ON Product(category);  -- Additional index

CREATE TABLE IF NOT EXISTS Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,  -- Auto-increment
    order_date DATETIME,
    total_cost INT CHECK (total_cost >= 0),  -- Check constraint
    email VARCHAR(50),
    FOREIGN KEY (email) REFERENCES Customer(email)
);

CREATE TABLE IF NOT EXISTS OrderDetails (
    order_id INT,
    itemID INT,
    quantity INT CHECK (quantity > 0),  -- Check constraint
    PRIMARY KEY (order_id, itemID),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (itemID) REFERENCES Product(itemID)
);

CREATE TABLE IF NOT EXISTS Receipt (
    receipt_id INT PRIMARY KEY AUTO_INCREMENT,  -- Auto-increment
    order_id INT,  -- New column
    amount INT CHECK (amount >= 0),  -- Check constraint
    payment_status BOOLEAN,
    email VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),  -- New foreign key
    FOREIGN KEY (email) REFERENCES Customer(email)
);

CREATE TABLE IF NOT EXISTS Store (
    store_ID INT PRIMARY KEY AUTO_INCREMENT,  -- Auto-increment
    employee_id INT UNIQUE,  -- Unique constraint
    store_name VARCHAR(50),
    phone_number BIGINT UNIQUE,  -- Unique constraint
    building VARCHAR(50),
    street VARCHAR(50),
    city VARCHAR(50),
    pin INT
);

CREATE INDEX idx_store_city ON Store(city);  -- Additional index

CREATE TABLE IF NOT EXISTS DeliveryDriver (
    username VARCHAR(20) PRIMARY KEY,
    password VARCHAR(30) NOT NULL,
    employee_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    building VARCHAR(50) NOT NULL,
    street VARCHAR(50) NOT NULL,
    city VARCHAR(50) NOT NULL,
    pin INT NOT NULL,
    phone_number BIGINT UNIQUE NOT NULL,  -- Unique constraint
    FOREIGN KEY (employee_id) REFERENCES Store(employee_id)
);

CREATE TABLE IF NOT EXISTS Admin (
    username VARCHAR(20) PRIMARY KEY,
    password VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS Cart (
    cart_id INT PRIMARY KEY AUTO_INCREMENT,  -- Auto-increment
    product_id INT,
    quantity INT CHECK (quantity > 0),  -- Check constraint
    subtotal INT CHECK (subtotal >= 0),  -- Check constraint
    email VARCHAR(50) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Product(itemID),
    FOREIGN KEY (email) REFERENCES Customer(email)
);

CREATE TABLE IF NOT EXISTS Category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,  -- Auto-increment
    category_name VARCHAR(30) NOT NULL UNIQUE,  -- Unique constraint
    image VARCHAR(100)
);

-- Customers 
INSERT INTO Customer VALUES
('customer1@example.com', 'password123', 'Ravi', 'Kumar', '123', 'Karol Bagh', 'Delhi', 110005, 9876543210, 'Dog'),
('customer2@example.com', 'securepass', 'Sunita', 'Sharma', '456', 'Paharganj', 'Delhi', 110055, 1234567890, 'Cat'),
('customer3@example.com', 'password456', 'Amit', 'Patel', '789', 'Rajouri Garden', 'Delhi', 110027, 2345678901, 'Bird'),
('customer4@example.com', 'password789', 'Priya', 'Gupta', '101', 'Dwarka', 'Delhi', 110075, 3456789012, 'Fish'),
('customer5@example.com', 'password012', 'Vijay', 'Singh', '202', 'Rohini', 'Delhi', 110085, 4567890123, 'Dog'),
('customer6@example.com', 'password345', 'Anjali', 'Verma', '303', 'Saket', 'Delhi', 110017, 5678901234, 'Cat'),
('customer7@example.com', 'password678', 'Rajesh', 'Malhotra', '404', 'Vasant Kunj', 'Delhi', 110070, 6789012345, 'Bird'),
('customer8@example.com', 'password901', 'Pooja', 'Bhatia', '505', 'Pitampura', 'Delhi', 110034, 7890123456, 'Fish'),
('customer9@example.com', 'password234', 'Sanjay', 'Jain', '606', 'Shahdara', 'Delhi', 110032, 8901234567, 'Dog'),
('customer10@example.com', 'password567', 'Anita', 'Dutta', '707', 'Kalkaji', 'Delhi', 110019, 9012345678, 'Cat'),
('customer11@example.com', 'password890', 'Manoj', 'Sinha', '808', 'Janakpuri', 'Delhi', 110058, 9123456789, 'Bird'),
('customer12@example.com', 'password123', 'Rekha', 'Mehra', '909', 'Uttam Nagar', 'Delhi', 110059, 9234567890, 'Fish'),
('customer13@example.com', 'password456', 'Sunil', 'Agarwal', '010', 'Paschim Vihar', 'Delhi', 110063, 9345678901, 'Dog'),
('customer14@example.com', 'password789', 'Ritu', 'Khanna', '111', 'Lajpat Nagar', 'Delhi', 110024, 9456789012, 'Cat'),
('customer15@example.com', 'password012', 'Prakash', 'Chopra', '212', 'Patel Nagar', 'Delhi', 110008, 9567890123, 'Bird');

-- Orders
INSERT INTO Orders VALUES
(1, '2024-02-12 10:30:00', 150, 'customer1@example.com'),
(2, '2024-02-13 12:45:00', 200, 'customer2@example.com'),
(3, '2024-02-14 14:00:00', 250, 'customer3@example.com'),
(4, '2024-02-15 15:30:00', 300, 'customer4@example.com'),
(5, '2024-02-16 16:45:00', 350, 'customer5@example.com'),
(6, '2024-02-17 18:00:00', 400, 'customer6@example.com'),
(7, '2024-02-18 19:15:00', 450, 'customer7@example.com'),
(8, '2024-02-19 20:30:00', 500, 'customer8@example.com'),
(9, '2024-02-20 21:45:00', 550, 'customer9@example.com'),
(10, '2024-02-21 23:00:00', 600, 'customer10@example.com'),
(11, '2024-02-22 10:30:00', 650, 'customer11@example.com'),
(12, '2024-02-23 12:45:00', 700, 'customer12@example.com'),
(13, '2024-02-24 14:00:00', 750, 'customer13@example.com'),
(14, '2024-02-25 15:30:00', 800, 'customer14@example.com'),
(15, '2024-02-26 16:45:00', 850, 'customer15@example.com'),
(16, '2024-02-27 18:00:00', 900, 'customer1@example.com'),
(17, '2024-02-28 19:15:00', 950, 'customer2@example.com'),
(18, '2024-02-29 20:30:00', 1000, 'customer3@example.com'),
(19, '2024-03-01 21:45:00', 1050, 'customer4@example.com'),
(20, '2024-03-02 23:00:00', 1100, 'customer5@example.com');

-- Product
INSERT INTO Product VALUES
(1, 'Dog Food', 'Pet Food', 50, 'dog_food.jpg', 'High-quality dog food for all breeds', 4),
(2, 'Cat Toy', 'Toys', 30, 'cat_toy.jpg', 'Interactive toy for cats', 5),
(3, 'Dog Toy', 'Toys', 35, 'dog_toy.jpg', 'Durable toy for dogs', 4),
(4, 'Cat Food', 'Pet Food', 45, 'cat_food.jpg', 'Nutritious food for cats', 5),
(5, 'Dog Leash', 'Accessories', 20, 'dog_leash.jpg', 'Strong and durable dog leash', 4),
(6, 'Cat Litter', 'Accessories', 25, 'cat_litter.jpg', 'Highly absorbent cat litter', 5),
(7, 'Dog Treat', 'Treats', 15, 'dog_treat.jpg', 'Tasty and healthy dog treats', 4),
(8, 'Cat Treat', 'Treats', 15, 'cat_treat.jpg', 'Delicious and healthy cat treats', 5),
(9, 'Dog Collar', 'Accessories', 20, 'dog_collar.jpg', 'Comfortable and adjustable dog collar', 4),
(10, 'Cat Collar', 'Accessories', 20, 'cat_collar.jpg', 'Comfortable and adjustable cat collar', 5),
(11, 'Dog Bed', 'Accessories', 60, 'dog_bed.jpg', 'Comfortable and durable dog bed', 4),
(12, 'Cat Bed', 'Accessories', 60, 'cat_bed.jpg', 'Soft and cozy cat bed', 5),
(13, 'Dog Shampoo', 'Grooming', 20, 'dog_shampoo.jpg', 'Gentle and effective dog shampoo', 4),
(14, 'Cat Shampoo', 'Grooming', 20, 'cat_shampoo.jpg', 'Gentle and effective cat shampoo', 5),
(15, 'Dog Brush', 'Grooming', 15, 'dog_brush.jpg', 'Easy to use dog brush for all coat types', 4);

-- OrderDetails
INSERT INTO OrderDetails VALUES
(1, 1, 2),
(1, 2, 1),
(2, 1, 1),
(3, 3, 2),
(4, 4, 1),
(5, 5, 2),
(6, 6, 1),
(7, 7, 2),
(8, 8, 1),
(9, 9, 2),
(10, 10, 1),
(11, 11, 2),
(12, 12, 1),
(13, 13, 2),
(14, 14, 1),
(15, 15, 2),
(16, 1, 1),
(17, 2, 2),
(18, 3, 1),
(19, 4, 2),
(20, 5, 1);

-- Receipt
INSERT INTO Receipt (receipt_id, order_id, amount, payment_status, email) VALUES
(101, 1, 150, true, 'customer1@example.com'),
(102, 2, 200, false, 'customer2@example.com'),
(103, 3, 250, true, 'customer3@example.com'),
(104, 4, 300, false, 'customer4@example.com'),
(105, 5, 350, true, 'customer5@example.com'),
(106, 6, 400, false, 'customer6@example.com'),
(107, 7, 450, true, 'customer7@example.com'),
(108, 8, 500, false, 'customer8@example.com'),
(109, 9, 550, true, 'customer9@example.com'),
(110, 10, 600, false, 'customer10@example.com'),
(111, 11, 650, true, 'customer11@example.com'),
(112, 12, 700, false, 'customer12@example.com'),
(113, 13, 750, true, 'customer13@example.com'),
(114, 14, 800, false, 'customer14@example.com'),
(115, 15, 850, true, 'customer15@example.com'),
(116, 16, 900, false, 'customer1@example.com'),
(117, 17, 950, true, 'customer2@example.com'),
(118, 18, 1000, false, 'customer3@example.com'),
(119, 19, 1050, true, 'customer4@example.com'),
(120, 20, 1100, false, 'customer5@example.com');

-- Store
INSERT INTO Store VALUES
(1001, 001, 'Pet Paradise', 9876543210, '789', 'Maple St', 'Delhi', 567890),
(1002, 002, 'Pet World', 9876543211, '790', 'Oak St', 'Delhi', 567891),
(1003, 003, 'Pet Haven', 9876543212, '791', 'Pine St', 'Delhi', 567892),
(1004, 004, 'Pet Oasis', 9876543213, '792', 'Birch St', 'Delhi', 567893),
(1005, 005, 'Pet Galaxy', 9876543214, '793', 'Cedar St', 'Delhi', 567894),
(1006, 006, 'Pet Universe', 9876543215, '794', 'Elm St', 'Delhi', 567895),
(1007, 007, 'Pet Kingdom', 9876543216, '795', 'Fir St', 'Delhi', 567896),
(1008, 008, 'Pet Palace', 9876543217, '796', 'Grove St', 'Delhi', 567897),
(1009, 009, 'Pet Emporium', 9876543218, '797', 'Hickory St', 'Delhi', 567898),
(1010, 010, 'Pet Pantheon', 9876543219, '798', 'Ivy St', 'Delhi', 567899);

-- DeliveryDriver
INSERT INTO DeliveryDriver VALUES
('driver1', 'deliverypass', 001, 'Ravi', 'Sharma', '456', 'Pitampura', 'Delhi', 110034, 8765432109),
('driver2', 'deliverypass', 002, 'Sunita', 'Gupta', '457', 'Rohini', 'Delhi', 110085, 8765432110),
('driver3', 'deliverypass', 003, 'Amit', 'Verma', '458', 'Dwarka', 'Delhi', 110075, 8765432111),
('driver4', 'deliverypass', 004, 'Pooja', 'Malhotra', '459', 'Janakpuri', 'Delhi', 110058, 8765432112),
('driver5', 'deliverypass', 005, 'Vijay', 'Kumar', '460', 'Vasant Kunj', 'Delhi', 110070, 8765432113),
('driver6', 'deliverypass', 006, 'Anita', 'Singh', '461', 'Saket', 'Delhi', 110017, 8765432114),
('driver7', 'deliverypass', 007, 'Rajesh', 'Patel', '462', 'Karol Bagh', 'Delhi', 110005, 8765432115),
('driver8', 'deliverypass', 008, 'Suman', 'Rana', '463', 'Lajpat Nagar', 'Delhi', 110024, 8765432116),
('driver9', 'deliverypass', 009, 'Sanjay', 'Jain', '464', 'Shahdara', 'Delhi', 110032, 8765432117),
('driver10', 'deliverypass', 010, 'Rekha', 'Agarwal', '465', 'Preet Vihar', 'Delhi', 110092, 8765432118),
('driver11', 'deliverypass', 001, 'Rahul', 'Khanna', '466', 'Paschim Vihar', 'Delhi', 110063, 8765432119),
('driver12', 'deliverypass', 002, 'Seema', 'Bisht', '467', 'Uttam Nagar', 'Delhi', 110059, 8765432120),
('driver13', 'deliverypass', 002, 'Sunil', 'Dutta', '468', 'Patparganj', 'Delhi', 110092, 8765432121),
('driver14', 'deliverypass', 002, 'Geeta', 'Chauhan', '469', 'Kalkaji', 'Delhi', 110019, 8765432122),
('driver15', 'deliverypass', 007, 'Rajiv', 'Bhardwaj', '470', 'Malviya Nagar', 'Delhi', 110017, 8765432123);

-- Admin
INSERT INTO Admin VALUES
('admin1', 'adminpass1'),
('admin2', 'adminpass2'),
('admin3', 'adminpass3'),
('admin4', 'adminpass4'),
('admin5', 'adminpass5'),
('admin6', 'adminpass6'),
('admin7', 'adminpass7'),
('admin8', 'adminpass8'),
('admin9', 'adminpass9'),
('admin10', 'adminpass10');

-- Cart
INSERT INTO Cart VALUES
(201, 1, 2, 100, 'customer1@example.com'),
(202, 2, 1, 50, 'customer2@example.com'),
(203, 3, 1, 150, 'customer3@example.com'),
(204, 4, 2, 200, 'customer4@example.com'),
(205, 5, 1, 250, 'customer5@example.com'),
(206, 6, 2, 300, 'customer6@example.com'),
(207, 7, 1, 350, 'customer7@example.com'),
(208, 8, 2, 400, 'customer8@example.com'),
(209, 9, 1, 450, 'customer9@example.com'),
(210, 10, 2, 500, 'customer10@example.com'),
(211, 11, 1, 550, 'customer11@example.com'),
(212, 12, 2, 600, 'customer12@example.com'),
(213, 13, 1, 650, 'customer13@example.com'),
(214, 14, 2, 700, 'customer14@example.com'),
(215, 15, 1, 750, 'customer1@example.com'),
(216, 2, 2, 800, 'customer6@example.com'),
(217, 7, 1, 850, 'customer7@example.com'),
(218, 8, 2, 900, 'customer1@example.com'),
(219, 9, 1, 950, 'customer9@example.com'),
(220, 2, 2, 1000, 'customer2@example.com');

-- Category
INSERT INTO Category VALUES
(1, 'Pet Food', 'pet_food.jpg'),
(2, 'Pet Treat', 'pet_treat.jpg'),
(3, 'Toys', 'toys.jpg'),
(4, 'Accessories', 'accessories.jpg'),
(5, 'Grooming Supplies', 'grooming_supplies.jpg'),
(6, 'Healthcare', 'healthcare.jpg'),
(7, 'Bedding', 'bedding.jpg'),
(8, 'Clothing', 'clothing.jpg'),
(9, 'Training Supplies', 'training_supplies.jpg'),
(10, 'Travel Accessories', 'travel_accessories.jpg');

SELECT Product.item_name, Category.category_name
FROM Product
INNER JOIN Category ON Product.category = Category.category_name;

SELECT Orders.order_id, Orders.order_date, Orders.total_cost, 
       Customer.first_name, Customer.last_name, 
       Product.item_name, Product.item_info, OrderDetails.quantity, 
       Receipt.amount, Receipt.payment_status
FROM Orders
INNER JOIN Customer ON Orders.email = Customer.email
INNER JOIN OrderDetails ON Orders.order_id = OrderDetails.order_id
INNER JOIN Product ON OrderDetails.itemID = Product.itemID
INNER JOIN Receipt ON Orders.order_id = Receipt.order_id  
WHERE Orders.order_id = 3;
