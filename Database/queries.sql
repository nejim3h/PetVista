USE PETVISTA;

-- Write and execute TEN SQL queries about your application involving various relational algebraic operations supporting the application features involving database access and manipulation.

-- Requirements:

-- Diverse queries containing various select, update, etc. commands.
-- Showcase adequate relational algebraic operations.
-- Showcase your constraints
-- A document containing your relational schema.

-- Your must submit a text file containing SQL queries and the document

SELECT *
FROM Product
WHERE item_rating > 4;


SELECT C.first_name AS customer_name, DD.first_name AS driver_name, DD.phone_number
FROM Orders O
INNER JOIN Customer C ON O.email = C.email
INNER JOIN DeliveryDriver DD ON O.order_id = DD.employee_id;


SELECT C.category_name, SUM(OD.quantity) AS total_sold
FROM Category C
INNER JOIN Product P ON C.category_id = P.category
INNER JOIN OrderDetails OD ON P.itemID = OD.itemID
GROUP BY C.category_name
ORDER BY total_sold DESC
LIMIT 1;


SELECT C.email, COUNT(*) AS outstanding_receipts
FROM Customer C
INNER JOIN Receipt R ON C.email = R.email
WHERE R.payment_status = FALSE
GROUP BY C.email
HAVING COUNT(*) > 0;


SELECT C.category_name, AVG(P.item_rating) AS average_rating
FROM Category C
INNER JOIN Product P ON C.category_id = P.category
GROUP BY C.category_name;


SELECT Store.store_name, Store.city, DeliveryDriver.first_name, DeliveryDriver.last_name
FROM Store
LEFT JOIN DeliveryDriver ON Store.employee_id = DeliveryDriver.employee_id;


SELECT Orders.order_id, Orders.order_date, Product.item_name, OrderDetails.quantity
FROM Orders
JOIN OrderDetails ON Orders.order_id = OrderDetails.order_id
JOIN Product ON OrderDetails.itemID = Product.itemID;


SELECT category, AVG(item_rating) AS avg_rating
FROM Product
-- WHERE category = 'Pet Food'-- 
GROUP BY category;


SELECT Product.category, SUM(Cart.subtotal) AS total_revenue
FROM Product
JOIN Cart ON Product.itemID = Cart.product_id
GROUP BY Product.category
ORDER BY total_revenue DESC;

UPDATE Product
SET quantity = quantity + 25
WHERE quantity < 5
LIMIT 100;  -- Adjust the limit based on the number of rows you want to update at a time


SELECT p1.item_name AS product1, p2.item_name AS product2, COUNT(*) AS frequency
FROM OrderDetails od1
JOIN OrderDetails od2 ON od1.order_id = od2.order_id AND od1.itemID < od2.itemID
JOIN Product p1 ON od1.itemID = p1.itemID
JOIN Product p2 ON od2.itemID = p2.itemID
GROUP BY product1, product2
ORDER BY frequency DESC
LIMIT 5;

-- SELECT Customer.first_name, Customer.last_name, Customer.email, SUM(Cart.subtotal) AS total_purchase
-- FROM Customer
-- JOIN Orders ON Customer.email = Orders.email
-- JOIN Cart ON Orders.order_id = Cart.order_id
-- GROUP BY Customer.email
-- ORDER BY total_purchase DESC
-- LIMIT 5;

-- SELECT Orders.order_id, Orders.order_date, SUM(Cart.subtotal) AS total_cost
-- FROM Orders
-- JOIN Cart ON Orders.order_id = Cart.order_id
-- WHERE Orders.order_date BETWEEN '2024-01-01' AND '2024-02-01'
-- GROUP BY Orders.order_id, Orders.order_date
-- LIMIT 5000;

SELECT Product.item_name, COUNT(OrderDetails.itemID) AS total_quantity_sold
FROM OrderDetails
JOIN Product ON OrderDetails.itemID = Product.itemID
JOIN Orders ON OrderDetails.order_id = Orders.order_id
WHERE Orders.order_date >= CURDATE() - INTERVAL 1 MONTH
GROUP BY Product.item_name
ORDER BY total_quantity_sold DESC
LIMIT 1;


-- UPDATE Product
-- SET item_rating = (
--     SELECT AVG(OrderDetails.item_rating)
--     FROM OrderDetails
--     JOIN Orders ON OrderDetails.order_id = Orders.order_id
--     WHERE OrderDetails.itemID = Product.itemID
-- );
-- -- Retrieve the updated ratings
-- SELECT itemID, item_name, item_rating
-- FROM Product;

-- Query to list down products with their respective categories--
SELECT Product.item_name, Category.category_name
FROM Product
INNER JOIN Category ON Product.category = Category.category_name;


-- Query to generate receipt-- 
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


INSERT INTO OrderDetails (order_id, itemID, quantity)
SELECT Orders.order_id, Cart.product_id, Cart.quantity
FROM Cart
JOIN Orders ON Cart.email = Orders.email
WHERE Orders.order_status = 'Completed';
DELETE FROM Cart
WHERE email IN (SELECT email FROM Orders WHERE order_status = 'Completed');
-- Show Cart contents before the update
SELECT * FROM Cart;





