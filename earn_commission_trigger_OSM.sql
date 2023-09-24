CREATE OR REPLACE FUNCTION calculate_commission() RETURNS TRIGGER
AS
$$
DECLARE 
	total NUMERIC;
	emp_id INT;
BEGIN

	SELECT O.employee_id INTO EMP_ID FROM ORDERS AS O WHERE O.ID = NEW.ID;
	total = NEW.total_price;

	UPDATE EMPLOYEES
	SET commision = commision + (total * 0.02)
	WHERE employee_id = NEW.employee_id;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER earn_commission_trigger
BEFORE INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION calculate_commission();

