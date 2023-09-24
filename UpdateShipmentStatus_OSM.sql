CREATE OR REPLACE PROCEDURE UpdateShipmentStatus(in OrderID INT)
AS
$$
DECLARE
	start_date DATE;
	today date;
BEGIN
	
	SELECT o.order_date into start_date
	from order_details as o 
	where o.order_id = OrderID;
	today := CURRENT_DATE;
	if today - start_date > 3 THEN
		UPDATE ORDER_DETAILS
		SET shipment_status = 'Shipped'
		where order_id = OrderID;
	ELSE
		RAISE NOTICE 'Shipment in preparation.';
	END IF;
	
END;
$$ LANGUAGE PLPGSQL

--TEST
CALL UpdateShipmentStatus(11)
CALL UpdateShipmentStatus(1)
SELECT * FROM ORDER_DETAILS
SELECT * FROM LOG

