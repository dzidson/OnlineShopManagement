CREATE OR REPLACE FUNCTION calculate_customer_payment() RETURNS trigger AS 
$$
DECLARE 
	total NUMERIC;
	price NUMERIC;
BEGIN
	SELECT p.price INTO price 
	FROM orders as o 
	join products as p on o.product_id = p.product_id
	where o.id = new.id;
	
	total = price * new.quantity;
	
	UPDATE orders
	SET customer_paid = total - new.club_point_used
	WHERE id = new.id;
	RETURN NEW;
	
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER calculate_customer_payment_trigger
AFTER INSERT ON ORDERS
FOR EACH ROW EXECUTE FUNCTION calculate_customer_payment();

--TEST
INSERT INTO ORDERS (id, customer_id, product_id, employee_id, quantity,total_price, club_point_used, customer_paid)
VALUES (56, 10, 5, 2, 1, 0, 50, 0)
SELECT * FROM orders