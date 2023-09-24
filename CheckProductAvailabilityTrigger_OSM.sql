CREATE OR REPLACE FUNCTION CheckProductAvailability() 
RETURNS TRIGGER AS 
$$
DECLARE available_quantity INT;
BEGIN
	IF NEW.QUANTITY > 0 THEN
		SELECT quantity_in_stock INTO available_quantity
        FROM products
        WHERE product_id = NEW.product_id;
			
		IF NEW.quantity <= available_quantity THEN
        RETURN NEW;
        ELSE
            RAISE EXCEPTION 'Cannot order more products than available in stock.';
        END IF;
    ELSE
        RAISE EXCEPTION 'Cannot order products with a non-positive quantity.';
    END IF;
END;
$$ LANGUAGE plpgsql

CREATE OR REPLACE TRIGGER CheckProductAvailabilityTrigger
BEFORE INSERT ON orders
FOR EACH ROW EXECUTE FUNCTION CheckProductAvailability();

--TEST
SELECT * FROM PRODUCTS
INSERT INTO ORDERS (id, customer_id, product_id, employye_id, quantity, total_price, club_point_used, customer_paid)
VALUES (12, 2, 3, 2, 2, 2599.98, 0.0, 2599.98), (13, 5, 6, 5, 3, 239.97, 0.0, 239.97);

INSERT INTO orders (id, customer_id, product_id, employye_id, quantity, total_price, club_point_used, customer_paid)
VALUES (14, 1, 1, 1, 100, 19999.80, 0.0, 19999.80);