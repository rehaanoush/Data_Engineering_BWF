-- Write a query to calculate the percentage contribution of each item's amount to its
-- order's total amount, grouped by order_id. (Topics: Partition BY)

SELECT item_id, order_id, product_id, amount,
 (amount / SUM(amount) OVER (PARTITION BY order_id)) * 100 AS percentage_contribution
FROM sales.items;


-- Write a query to rank orders by their total amount within each customer, ordering them from highest 
-- to lowest total amount. (Topics: Window functions like RANK, PARTITION BY, and ORDER BY)

SELECT order_id, customer_id, total_amount,
 RANK() OVER (PARTITION BY customer_id ORDER BY total_amount DESC) as rank_within_customer
FROM sales.orders;


-- Write a query to calculate the average price of products supplied by each supplier. Exclude suppliers
-- who have no products in the result. (Topics: JOINS, AGGREGATE FUNCTIONS, GROUP BY)

SELECT s.supplier_id, s.name,
 AVG(p.price) AS average_price
FROM sales.suppliers s
JOIN sales.products p ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.name
HAVING COUNT(p.product_id) > 0;


-- Write a query to count the number of products in each category. Include categories with zero products in the
-- result set. (WINDOW FUNCTIONS, AGGREGATE FUNCTIONS, JOINS, GROUP BY)

SELECT c.category_id, c.name AS category_name,
COUNT(p.product_id) AS product_count
FROM sales.categories c
LEFT JOIN sales.products p ON c.category_id = p.category
GROUP BY c.category_id, c.name;


-- Write a query to retrieve the total amount spent by each customer, along with their name and phone number. Ensure customers with 
-- no orders also appear with a total amount of 0. (WINDOW FUNCTIONS, AGGREGATE FUNCTIONS, JOINS, GROUP BY)

SELECT c.customer_id, c.name, c.phone,
 COALESCE(SUM(o.total_amount), 0) AS total_amount_spent
FROM sales.customers c
LEFT JOIN sales.orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name, c.phone;
