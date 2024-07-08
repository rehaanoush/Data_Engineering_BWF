

--   [Topics: JOINS and WINDOW FUNCTIONS]

-- Write a query to retrieve all orders placed by customers, including customer details (name, phone),
-- order details (order ID, timestamp), and item details (product, amount). 

SELECT c.name AS customer_name, c.phone AS customer_phone, o.order_id, o.order_timestamp, p.product_id, i.amount
FROM  customer c
JOIN orders o ON c.customer = o.customer_id
JOIN items i ON o.order_id = i.order_id
JOIN products p ON i.product_id = p.product_id
ORDER BY o.order_timestamp;
 
-- Write a query to fetch all products along with their suppliers' details (name, phone) and the corresponding category name.

SELECT p.name AS product_name, s.supplier_id, s.phone AS supplier_phone, c.name AS category_name
FROM products p
LEFT JOIN suppliers s ON p.supplier_id = s.supplier_id
LEFT JOIN categories c ON p.category= c.category::text;

 -- Write a query to retrieve details of all orders including the product name and amount ordered for each item.

SELECT o.order_id, p.name AS product_name, i.amount
FROM orders o
JOIN  items i ON o.order_id = i.order_id
JOIN products p ON i.product_id = p.product_id
ORDER BY  o.order_id, i.amount;
 
-- Write a query to retrieve all suppliers along with the city and country where they are located, and the products they supply.

SELECT s.name AS supplier_name, s.location AS supplier_location, STRING_AGG(p.name, ', ') AS products_supplied
FROM suppliers s
LEFT JOIN  products p ON s.supplier_id = p.supplier_id
GROUP BY s.name, s.location
ORDER BY s.name;

 
-- Write a query to fetch details of the most recent order (by timestamp) placed by each customer,
-- including the product details for each item in the order. [This question will use a Window Function alongside Joins]

