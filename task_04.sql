-- 1. Write a query to fetch all customer names and sort them alphabetically. (Topic Soring)

SELECT name 
FROM customers
order by name;

	
-- 2. Write a query to fetch all product names and their prices, sorted by price from low to high. (Topic Sorting)

SELECT name AS "Product Name", price AS "Product Price"
FROM products
Order By price;


-- 3. Write a query to fetch supplier names that start with the letter 'A' and sort them by their names.(Topic Sorting with Operators and Wildcards)

SELECT name AS "Supplier Name"
FROM suppliers
Where name LIKE 'A%'
ORDER BY name;

-- 4. Write a query to fetch all items and sort them by their status, placing NULL values first.

SELECT * 
FROM items 
Order by status NULLS FIRST;


-- 5. Write a query to fetch all products, sort them first by category and then by price in descending order.

SELECT * 
FROM products 
Order by category, price desc

	
-- 6. Write a query to fetch all customer names and phone numbers,but sort them by the last four digits of their phone numbers	in ascending order. (Hint use sorting with substings)
  
SELECT name AS "Customer Name",phone AS "Customer Phone No." 
FROM customers
Order by right(phone, 4) 
