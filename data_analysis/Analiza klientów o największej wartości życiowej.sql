/*
Analiza klientów o największej wartości życiowej:

Znalezienie klientów, którzy przynoszą najwięcej przychodów.
*/

SELECT c.customer_id, c.name, SUM(o.total_price) AS TOTAL
FROM ORDERS as o
join customers as c on c.customer_id = o.customer_id 
GROUP BY c.customer_id, c.name
ORDER BY TOTAL DESC
