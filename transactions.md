# Database Transactions

## Conflicting Transaction 

### Transaction - 1

```
USE petvista;

BEGIN;
UPDATE Customer 
    SET phone_number = 1111111111 
    WHERE email = 'customer1@example.com';
```

```
USE petvista;

BEGIN;
UPDATE Customer
    SET last_name = 'NewLastName'
    WHERE email = 'customer1@example.com';
```

### Transaction - 2

```
USE petvista;

START TRANSACTION;

UPDATE Cart
SET quantity = quantity + 1
WHERE cart_id = 201;
```

```
USE petvista;

START TRANSACTION;

UPDATE Cart
SET quantity = quantity + 2
WHERE cart_id = 201;
```


## Non-Conflicting transactions

### Transaction-1
```
USE petvista;

START TRANSACTION;
UPDATE DeliveryDriver
SET city = 'New City'
WHERE username = 'driver1';
```
```
USE petvista;

START TRANSACTION;
UPDATE DeliveryDriver 
SET city = 'Another City' 
WHERE username = 'driver2';
```

### Transaction-2
```
USE petvista;

START TRANSACTION;
INSERT INTO Customer (email, password, first_name, last_name, building, street, city, pin, phone_number, pet_type)
VALUES ('newcustomer1@example.com', 'newpassword', 'John', 'Doe', '123', 'Main St', 'New City', 12345, 9876543210, 'Dog');
```
```
USE petvista;

START TRANSACTION;
INSERT INTO Customer (email, password, first_name, last_name, building, street, city, pin, phone_number, pet_type)
VALUES ('newcustomer2@example.com', 'newpassword', 'Jane', 'Smith', '456', 'Elm St', 'Another City', 54321, 9876543211, 'Cat');
```

### Transaction-3
```
USE petvista;

START TRANSACTION;
DELETE FROM Category
WHERE category_name = 'Bedding';
```
```
USE petvista;

START TRANSACTION;
DELETE FROM Category
WHERE category_name = 'Clothing';
```

### Transaction-4
```
USE petvista;

START TRANSACTION;
-- Total number of products sold in each store
SELECT s.store_name, COUNT(od.quantity) AS total_products_sold
FROM Store s
JOIN DeliveryDriver dd ON s.employee_id = dd.employee_id
JOIN Orders o ON dd.username = o.email
JOIN OrderDetails od ON o.order_id = od.order_id
GROUP BY s.store_name;
```
```
USE petvista;

START TRANSACTION;
-- Total number of orders placed by each customer
SELECT c.first_name, c.last_name, COUNT(o.order_id) AS total_orders
FROM Customer c
LEFT JOIN Orders o ON c.email = o.email
GROUP BY c.email;
```