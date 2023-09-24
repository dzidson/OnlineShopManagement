CREATE OR REPLACE FUNCTION getProductsLessThan10InStock() 
RETURNS TABLE (product_id products.product_id%type,
			   name products.name%type,
			   quantity_in_stock products.quantity_in_stock%type
			  )
AS
$$
BEGIN
	RETURN QUERY
	SELECT p.product_id, p.name, p.quantity_in_stock 
	FROM products as p
	WHERE p.quantity_in_stock < 10;
END;
$$ LANGUAGE plpgsql

--TEST
SELECT * FROM getProductsLessThan10InStock()