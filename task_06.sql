

--   [Topics: JOINS and WINDOW FUNCTIONS]

-- Write a query to retrieve all orders placed by customers, including customer details (name, phone),
-- order details (order ID, timestamp), and item details (product, amount). 

SELECT c.name AS customer_name, c.phone AS customer_phone, o.order_id, o.order_timestamp, p.product_id, i.amount
FROM  customer AS c
JOIN orders AS o ON c.customer = o.customer_id
JOIN items AS i ON o.order_id = i.order_id
JOIN products AS p ON i.product_id = p.product_id
ORDER BY o.order_timestamp;
 
-- Write a query to fetch all products along with their suppliers' details (name, phone) and the corresponding category name.

SELECT p.name AS product_name, s.supplier_id, s.phone AS supplier_phone, c.name AS category_name
FROM products AS p
LEFT JOIN suppliers AS s ON p.supplier_id = s.supplier_id
LEFT JOIN categories AS c ON p.category= c.category::text;

 -- Write a query to retrieve details of all orders including the product name and amount ordered for each item.

SELECT o.order_id, p.name AS product_name, i.amount
FROM orders AS o
JOIN  items AS i ON o.order_id = i.order_id
JOIN products AS p ON i.product_id = p.product_id
ORDER BY  o.order_id, i.amount;
 
-- Write a query to retrieve all suppliers along with the city and country where they are located, and the products they supply.

SELECT s.name AS supplier_name, s.location AS supplier_location, STRING_AGG(p.name, ', ') AS products_supplied
FROM suppliers AS s
LEFT JOIN  products AS p ON s.supplier_id = p.supplier_id
GROUP BY s.name, s.location
ORDER BY s.name;

 
-- Write a query to fetch details of the most recent order (by timestamp) placed by each customer,
-- including the product details for each item in the order. [This question will use a Window Function alongside Joins]

WITH RankedOrders AS ( SELECT o.customer_id,
 RANK() OVER (PARTITION BY o.customer_id ORDER BY o.order_time DESC) AS order_rank_for_customer,
 o.order_id, o.order_time, c.name, c.location, p.name AS product_name, p.category AS product_category, p.price AS product_price
 FROM sales.orders AS o
 LEFT JOIN sales.customers AS c ON o.customer_id = c.customer_id
 LEFT JOIN sales.items AS i ON o.order_id = i.order_id
 LEFT JOIN sales.products AS p ON i.product_id = p.product_id
)
SELECT customer_id, name AS customer_name, location AS customer_location,
order_id, order_time, product_name, product_category, product_price
FROM RankedOrders
WHERE order_rank_for_customer = 1
ORDER BY customer_id DESC;

