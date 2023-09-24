CREATE OR REPLACE FUNCTION DeleteOrder() RETURNS TRIGGER 
AS $$
DECLARE 
    IDCustomers INT;
    IDemployye INT;
    total_spent NUMERIC;
    commision_reduction NUMERIC;
    points NUMERIC;
    o_order_id INT;
		
BEGIN
    o_order_id := OLD.id;
	IDCustomers := OLD.customer_id;
	IDemployye := OLD.employee_id;
	total_spent := OLD.total_price;
	points := OLD.club_point_used;
	--Pracownicy otrzymują 2% prowizji z zamówienia
    commision_reduction := total_spent * 0.02;
	--Nie ma potrzeby zmieniania id zamówienia o 1 w dół każdorazowo gdy tylko usuniemy rekord ze srodka. 	
        UPDATE EMPLOYEES
        SET commision = commision - commision_reduction
        WHERE employee_id = IDemployye;

        UPDATE customers
        SET total_spend = total_spend - total_spent,
            club_points = club_points + points    
        WHERE customer_id = IDCustomers;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER ReductionCommissionDeletingOrder
AFTER DELETE ON ORDERS
FOR EACH ROW
EXECUTE FUNCTION DeleteOrder();

--TEST
DELETE FROM ORDERS
WHERE id = 21

SELECT * FROM ORDERS