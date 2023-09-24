CREATE OR REPLACE FUNCTION update_product_quantity() RETURNS TRIGGER AS
$$
DECLARE 
	product_quantity int;
	product INT;
BEGIN
	product_quantity := new.quantity;
	product := new.product_id;
	
	UPDATE products
	SET quantity_in_stock = quantity_in_stock - product_quantity,
		total_quantity_sold = total_quantity_sold + product_quantity
	where product_id = product;
	
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER update_product_quantity_trigger
AFTER INSERT on ORDERS
FOR EACH ROW 
EXECUTE FUNCTION update_product_quantity();

--TEST
SELECT * FROM PRODUCTS
select * FROM ORDERS

INSERT INTO ORDERS (id, customer_id, product_id, employee_id, quantity, total_price, club_point_used, customer_paid)
VALUES (60, 1, 1, 1, 5, 100.00, 20.00, 80.00),
(61, 2, 2, 2, 3, 60.00, 0.00, 60.00),  
(62, 3, 3, 3, 2, 40.00, 10.00, 30.00);  