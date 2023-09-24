CREATE OR REPLACE PROCEDURE RestockSpecificProducts(ID_product INT, quantity INT)
AS $$
BEGIN
	IF EXISTS (SELECT 1 FROM PRODUCTS AS P WHERE P.PRODUCT_ID = ID_product) THEN
		UPDATE PRODUCTS
		SET quantity_in_stock = quantity_in_stock + quantity
		where product_id = ID_product;
	ELSE
		RAISE NOTICE 'Product with ID % does not exist.', ID_product;
	END IF;
END;
$$ LANGUAGE plpgsql;

--TEST
CALL RestockSpecificProducts(2, 10)
CALL RestockSpecificProducts(21, 10)
SELECT * FROM PRODUCTS