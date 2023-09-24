CREATE OR REPLACE FUNCTION getMostSoldProductsByCategory()
RETURNS TABLE(type products.type%TYPE, total_sold BIGINT)
AS
$$
BEGIN
	RETURN QUERY
	SELECT p.type, COUNT(o.product_id) AS total_sold
	FROM orders as o
	join products as p ON p.product_id = o.product_id
	GROUP BY p.type
	ORDER BY total_sold DESC;
END;
$$ LANGUAGE plpgsql

--TEST
SELECT * FROM getMostSoldProductsByCategory()
