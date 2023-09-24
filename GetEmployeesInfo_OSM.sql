CREATE OR REPLACE FUNCTION GetEmployeesInfo(IN employess_name EMPLOYEES.name%TYPE)
RETURNS SETOF EMPLOYEES
AS
$$
BEGIN   
    IF EXISTS (SELECT 1 FROM EMPLOYEES AS c WHERE c.name = employess_name) THEN
        RETURN QUERY SELECT c.* FROM EMPLOYEES AS c WHERE c.name = employess_name;
    ELSE 
        RAISE NOTICE '% does not exist in the data warehouse', employess_name;
        RETURN;
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM GetEmployeesInfo('Ava Johnson')

SELECT * FROM EMPLOYEES