--Analiza preferencji klientów:

--Które produkty są najczęściej kupowane przez konkretne grupy klientów?

SELECT o.customer_id, o.product_id, p.name ,SUM(o.quantity)
FROM ORDERS as o
JOIN ORDER_DETAILS as od on od.order_id = o.id
JOIN PRODUCTS as p on o.product_id = p.product_id
GROUP BY  o.customer_id, o.product_id, p.name
ORDER BY o.customer_id
