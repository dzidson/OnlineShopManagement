CREATE OR REPLACE FUNCTION CalculateTotalSalaryAndCommission(IN start_date DATE, IN end_date DATE)
RETURNS TABLE (
    employee_id INT,
    name VARCHAR(100),
    total_salary NUMERIC,
    "position" VARCHAR(75)
)
AS
$$
BEGIN
    RETURN QUERY
    SELECT e.employee_id, e.name, CAST(e.salary + e.commision as NUMERIC) as total_salary, e.position
    FROM EMPLOYEES AS e
    JOIN orders AS o ON o.employee_id = e.employee_id
    JOIN order_details AS od ON od.order_id = o.id
    WHERE od.order_date BETWEEN start_date AND end_date
    GROUP BY e.employee_id, e.name, e.salary, e.commision, e.position
    ORDER BY total_salary DESC;
END;
$$ LANGUAGE plpgsql;

-- TEST
SELECT * FROM CalculateTotalSalaryAndCommission('2023.09.01', '2023.09.05')