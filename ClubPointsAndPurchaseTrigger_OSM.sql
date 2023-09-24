-- Tworzenie funkcji do obsługi zarówno dodawania punktów klubowych, 
-- jak i używania ich do zakupu (złączenie 2 funkcji w jedną)
CREATE OR REPLACE FUNCTION ClubPointsAndPurchase()
RETURNS TRIGGER AS
$$
DECLARE
    points_added NUMERIC;
    points_used NUMERIC;
    cust_ID INT;
    available_points NUMERIC;
	price NUMERIC;
BEGIN
	SELECT p.price INTO price FROM ORDERS as o
	join products as p on o.product_id = p.product_id
	WHERE o.id = new.id;
	
    points_added := (new.quantity * price) * 0.05;
    
    SELECT c.customer_id, c.club_points INTO cust_ID, available_points
    FROM customers AS c
    WHERE c.customer_id = NEW.customer_id;
    
    -- Jeśli klient używa punktów klubowych do zakupu
    IF NEW.club_point_used > 0 THEN
        points_used := NEW.club_point_used;
        
        IF points_used <= available_points THEN
            
            UPDATE customers
            SET club_points = club_points - points_used
            WHERE customer_id = cust_ID;
            
            NEW.customer_paid := NEW.total_price - points_used;
        ELSE
            RAISE EXCEPTION 'Not enough club points available for this purchase';
        END IF;
    ELSE
        -- Jeśli klient nie używa punktów klubowych, cena płatności klienta to pełna cena zamówienia
        NEW.customer_paid := NEW.total_price;
    END IF;
    
    -- Aktualizacja liczby punktów klubowych klienta
    UPDATE customers
    SET club_points = club_points + points_added
    WHERE customer_id = cust_ID;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE TRIGGER ClubPointsAndPurchaseTrigger
AFTER INSERT ON orders
FOR EACH ROW
EXECUTE FUNCTION ClubPointsAndPurchase();

INSERT INTO ORDERS (id, customer_id, product_id, employee_id, quantity, total_price, club_point_used, customer_paid)
VALUES (116, 6, 7, 7, 3, 0, 0, 0) 

SELECT * FROM CUSTOMERS
UPDATE CUSTOMERS
SET club_points = 100