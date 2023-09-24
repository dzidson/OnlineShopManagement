CREATE OR REPLACE FUNCTION increase_customer_total_spend() RETURNS TRIGGER AS
$$
DECLARE
	 total NUMERIC; 
	 price NUMERIC;
	 customer_paid NUMERIC;
	 total_spend_before_new_order NUMERIC;
BEGIN
	SELECT p.price INTO price FROM ORDERS as o
	join products as p on o.product_id = p.product_id
	WHERE o.id = new.id;
	
	SELECT c.total_spend INTO total_spend_before_new_order
	FROM ORDERS as o
	join customers as c on c.customer_id = o.customer_id
	WHERE o.id = new.id;
	
	total = new.quantity * price;
	customer_paid = total - new.club_point_used;
	
	UPDATE CUSTOMERS
	SET total_spend = customer_paid + total_spend_before_new_order
	where customer_id = new.customer_id;
	
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER increase_customer_total_spend_trigger
AFTER INSERT ON ORDERS
FOR EACH ROW
EXECUTE FUNCTION increase_customer_total_spend();


--TEST
SELECT * FROM CUSTOMERS
SELECT * FROM ORDERS
SELECT * FROM PRODUCTS
UPDATE CUSTOMERS 
SET club_points = 100
INSERT INTO ORDERS (id, customer_id, product_id, employee_id, quantity, total_price, 
					club_point_used, customer_paid)
VALUES
(98, 4, 4, 4, 4, 0, 100, 0)

