CREATE OR REPLACE PROCEDURE RestockAllProducts(quantity INT)
AS $$
BEGIN
	UPDATE PRODUCTS
	SET quantity_in_stock = quantity_in_stock + quantity;
END;
$$ LANGUAGE plpgsql

CALL RestockAllProducts(1)
SELECT * FROM PRODUCTS
SELECT * FROM LOG