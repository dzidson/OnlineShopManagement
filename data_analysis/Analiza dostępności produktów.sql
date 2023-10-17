--Analiza dostępności produktów:

--Wykaz produktów, które są bliskie wyczerpania zapasów.
--Które produkty są stale niedostępne


SELECT p.product_id, p.name, p.quantity_in_stock
FROM products as p
WHERE p.quantity_in_stock < 250


SELECT p.product_id, p.name, p.quantity_in_stock
FROM products as p
WHERE p.quantity_in_stock = 0
