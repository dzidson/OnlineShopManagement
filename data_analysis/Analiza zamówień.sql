/*Analiza zamówień:

Średni koszt zamówienia.
Którzy klienci składają najwięcej zamówień.
*/

SELECT AVG(total_price) FROM ORDERS

SELECT c.customer_id, c.name, COUNT(o.id) as count_order
FROM ORDERS as o
JOIN CUSTOMERS as c on c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY count_order DESC
