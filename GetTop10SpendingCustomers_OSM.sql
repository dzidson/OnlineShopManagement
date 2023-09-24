CREATE OR REPLACE FUNCTION GetTop10SpendingCustomers()
RETURNS TABLE (
    customer_id INT,
    name customers.name%type,
    total_spent NUMERIC
) AS
$$
BEGIN	
	return query
		SELECT c.customer_id, c.name, CAST(sum(total_price) AS NUMERIC) as total_spent
		FROM customers as c
		join orders as o on c.customer_id = o.customer_id
		group by c.customer_id
		order by total_spent DESC
		LIMIT 10;
END;
$$ LANGUAGE plpgsql

CREATE OR REPLACE PROCEDURE GetTop10SpendingCustomers_procedure()
AS
$$
DECLARE
    customer_info RECORD;
BEGIN
    FOR customer_info IN (
        SELECT c.customer_id, c.name, CAST(sum(total_price) AS NUMERIC) as total_spent
		FROM customers as c
		join orders as o on c.customer_id = o.customer_id
		group by c.customer_id
		order by total_spent DESC
		LIMIT 10
    )
    LOOP
        RAISE NOTICE 'Customer ID: %, Name: %, Total Spent: %', customer_info.customer_id, customer_info.name, customer_info.total_spent;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

--TEST
SELECT * FROM GetTop10SpendingCustomers();
CALL GetTop10SpendingCustomers_procedure();

