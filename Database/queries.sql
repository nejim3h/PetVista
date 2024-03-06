USE PETVISTA;

-- Products with rating more than equal to 4--
SELECT *
FROM Product 
WHERE item_rating >= 4
ORDER BY item_rating ASC; 


-- Customer - Deliver Driver--
SELECT C.first_name AS customer_name, DD.first_name AS driver_name, DD.phone_number
FROM Orders O
INNER JOIN Customer C ON O.email = C.email
INNER JOIN DeliveryDriver DD ON O.order_id = DD.employee_id;


-- Cash on Delivery--
SELECT C.email, COUNT(*) AS outstanding_receipts
FROM Customer C
INNER JOIN Receipt R ON C.email = R.email
WHERE R.payment_status = FALSE
GROUP BY C.email
HAVING COUNT(*) > 0;


-- Store - Employees--
SELECT Store.store_name, Store.city, DeliveryDriver.first_name, DeliveryDriver.last_name
FROM Store
LEFT JOIN DeliveryDriver ON Store.employee_id = DeliveryDriver.employee_id;


-- Average Rating for each category--
SELECT category, AVG(item_rating) AS avg_rating
FROM Product
-- WHERE category = 'Pet Food'-- 
GROUP BY category;


-- Total revenue generated by each category--
SELECT Product.category, SUM(Cart.subtotal) AS total_revenue
FROM Product
JOIN Cart ON Product.itemID = Cart.product_id
GROUP BY Product.category
ORDER BY total_revenue DESC;


-- Add to stock --
UPDATE Product
SET quantity = quantity + 25
WHERE quantity < 5
LIMIT 25;
SELECT * FROM Product;


-- Frequently bought together--
WITH ProductPairs AS (
    SELECT
        od1.itemID AS item1,
        od2.itemID AS item2,
        COUNT(*) AS frequency
    FROM
        OrderDetails od1
        JOIN OrderDetails od2 ON od1.order_id = od2.order_id AND od1.itemID < od2.itemID
    GROUP BY
        od1.itemID, od2.itemID
    HAVING
        COUNT(*) >= 2
)
SELECT
    p1.item_name AS product1,
    p2.item_name AS product2,
    pp.frequency
FROM
    ProductPairs pp
    JOIN Product p1 ON pp.item1 = p1.itemID
    JOIN Product p2 ON pp.item2 = p2.itemID
ORDER BY
    pp.frequency DESC, p1.item_name, p2.item_name;


-- Most bought in last month--
SELECT Product.item_name, COUNT(OrderDetails.itemID) AS total_quantity_sold
FROM OrderDetails
JOIN Product ON OrderDetails.itemID = Product.itemID
JOIN Orders ON OrderDetails.order_id = Orders.order_id
WHERE Orders.order_date >= CURDATE() - INTERVAL 1 MONTH
GROUP BY Product.item_name
ORDER BY total_quantity_sold DESC
LIMIT 1;


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


-- Total money spent by customers--
SELECT email, SUM(total_cost) AS total_money_spent
FROM Orders
GROUP BY email
ORDER BY total_money_spent DESC;

