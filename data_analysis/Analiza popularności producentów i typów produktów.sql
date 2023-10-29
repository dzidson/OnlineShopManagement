/*
Analiza popularności producentów i typów produktów:

Które marki i rodzaje produktów cieszą się największą popularnością.
*/

SELECT product_id, name, MAX(total_quantity_sold) as total_sold
FROM PRODUCTS
GROUP BY product_id, name
ORDER BY total_sold DESC

SELECT p.manufacturer, COUNT(*) AS Popularity
FROM Products as p
JOIN ORDERS as o on p.product_id = o.product_id 
GROUP BY manufacturer
ORDER BY manufacturer DESC;

SELECT p.type, COUNT(*) AS Popularity
FROM PRODUCTS AS p
JOIN ORDERS as o on p.product_id = o.product_id
GROUP BY type
ORDER BY Popularity DESC;
