CREATE OR REPLACE PROCEDURE awardClubPointsToCustomers(IN customers_name TEXT, IN points NUMERIC)
AS 
$$
BEGIN
	IF EXISTS (SELECT 1 FROM customers as c where c.name = customers_name) THEN
		UPDATE customers
		SET club_points = club_points + points
		WHERE name = customers_name;
	ELSE 
		RAISE NOTICE 'There is no such customer. Please verify the entered data.';
	END IF;
END;
$$ LANGUAGE plpgsql;

CALL awardClubPointsToCustomers('Bob Johnson', 1000)
SELECT * FROM CUSTOMERS
