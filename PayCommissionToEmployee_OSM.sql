CREATE OR REPLACE PROCEDURE PayCommissionToEmployee(IN start_date DATE, IN end_date DATE, IN name_employee TEXT, IN commission_paid NUMERIC)
AS 
$$
DECLARE 
    earn_commision NUMERIC;
BEGIN   
    IF EXISTS (SELECT 1 FROM EMPLOYEES AS E WHERE E.NAME = name_employee) THEN 
        SELECT e.commision INTO earn_commision
        FROM EMPLOYEES as e 
        WHERE e.name = name_employee;
        
        IF commission_paid <= earn_commision THEN
            -- Rozpocznij transakcję
            BEGIN
                -- Aktualizuj prowizję pracownika
                UPDATE EMPLOYEES
                SET commision = commision - commission_paid
                WHERE name = name_employee;
			END;

        ELSE 
       		RAISE NOTICE 'Commission cannot be paid. The maximum payout amount is %', earn_commision;
	   END IF;
    ELSE
    	RAISE NOTICE 'There is no such employee as %. Please verify the correctness of the data.', name_employee;
	END IF;
END
$$ LANGUAGE plpgsql;

--TESTY
-- Wypłacenie prowizji pracownikowi, gdzie name_employee to istniejący pracownik i commision_paid jest mniejszy lub równy niż jego zarobiona prowizja.
CALL PayCommissionToEmployee('2023-09-01', '2023-09-30', 'Jennifer Davis', 100.0);

-- Próba wypłacenia prowizji pracownikowi, gdzie commision_paid jest większa niż jego zarobiona prowizja.
CALL PayCommissionToEmployee('2023-09-01', '2023-09-30', 'Jennifer Davis', 10000.0);

-- Próba wypłacenia prowizji pracownikowi, którego nie ma w bazie danych.
CALL PayCommissionToEmployee('2023-09-01', '2023-09-30', 'Nieznany Pracownik', 100.0);
