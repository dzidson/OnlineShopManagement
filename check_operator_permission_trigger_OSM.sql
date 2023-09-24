CREATE OR REPLACE FUNCTION check_operator_permission() RETURNS TRIGGER
AS $$
BEGIN
	 IF NOT EXISTS (SELECT 1 FROM employees WHERE employee_id = NEW.employee_id) THEN
        RAISE EXCEPTION 'Only operators can permit a product';
    END IF; 
    RETURN NEW;
END;
$$ LANGUAGE plpgsql

CREATE OR REPLACE TRIGGER check_operator_permission_trigger
BEFORE INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION check_operator_permission();

--TEST
SELECT * FROM ORDERS
INSERT INTO ORDERS (id, customer_id, product_id, employee_id, quantity, total_price, club_point_used, customer_paid)
VALUES (22, 3, 5, 5, 3, 150.00, 50.00, 100.00);
