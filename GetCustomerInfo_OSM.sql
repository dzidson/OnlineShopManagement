CREATE OR REPLACE FUNCTION GetCustomerInfo(IN customers_name customers.name%TYPE)
RETURNS SETOF customers
AS
$$
BEGIN   
    IF EXISTS (SELECT 1 FROM customers AS c WHERE c.name = customers_name) THEN
        RETURN QUERY SELECT c.* FROM customers AS c WHERE c.name = customers_name;
    ELSE 
        RAISE NOTICE '% does not exist in the data warehouse', customers_name;
        RETURN;
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM GetCustomerInfo('James Wilson')

