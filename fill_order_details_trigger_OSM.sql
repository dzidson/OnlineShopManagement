CREATE OR REPLACE FUNCTION fill_order_details() RETURNS TRIGGER AS
$$
DECLARE 
	order_date DATE;
	possible_shipping_date DATE;
	shipment_status VARCHAR(255);
BEGIN
    order_date := CURRENT_DATE;
    
    possible_shipping_date := order_date + INTERVAL '3 days';

    shipment_status := 'processing';
    
    INSERT INTO ORDER_DETAILS (order_id, order_date, possible_shipping_date, shipment_status)
    VALUES (NEW.id, order_date, possible_shipping_date, shipment_status);
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER fill_order_details_trigger
AFTER INSERT ON ORDERS
FOR EACH ROW
EXECUTE FUNCTION fill_order_details();

SELECT * FROM ORDERS
SELECT * FROM ORDER_DETAILS
INSERT INTO ORDERS (id, customer_id, product_id, employee_id, quantity, total_price, club_point_used, customer_paid)
VALUES
(1, 1, 1, 4, 3, 0, 10.00, 0),
(2, 2, 2, 5, 4, 0, 0.00, 0),
(3, 3, 3, 6, 2, 0, 15.00, 0);
