CREATE OR REPLACE FUNCTION calculate_total_price_for_order()RETURNS trigger
AS $$
DECLARE 
	price NUMERIC;
BEGIN
	SELECT p.price INTO price 
	FROM orders as o 
	join products as p on o.product_id = p.product_id
	where o.id = new.id;
	
	UPDATE orders
	SET total_price = price * quantity
	WHERE id = new.id;
	RETURN NEW;
	
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER calculate_total_price_trigger
AFTER INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION calculate_total_price_for_order();

--TEST
SELECT * FROM ORDERS
SELECT * FROM PRODUCTS

INSERT INTO ORDERS (id, customer_id, product_id, employee_id, quantity,total_price, club_point_used, customer_paid)
VALUES (55, 10, 5, 2, 1, 0, 0, 0)