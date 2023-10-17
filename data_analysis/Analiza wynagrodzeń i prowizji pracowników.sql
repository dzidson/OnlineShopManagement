--Analiza wynagrodzeń i prowizji pracowników:

--Znalezienie pracowników o najwyższych zarobkach.
--Przegląd, ile prowizji otrzymują różni pracownicy.

WITH HighestEarningEmployees AS (
    SELECT employee_id, name, position, salary
    FROM employees
    ORDER BY salary DESC
    LIMIT 15
)
SELECT * FROM HighestEarningEmployees;

WITH EmployeesWithCommision AS (
    SELECT employee_id, name, commision
    FROM employees
    WHERE commision IS NOT NULL
	ORDER BY commision DESC
)
SELECT * FROM EmployeesWithCommision;