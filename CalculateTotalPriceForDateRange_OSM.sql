CREATE OR REPLACE FUNCTION CalculateTotalPriceForDateRange(IN start_date DATE, IN end_date DATE, OUT SUM_total_price_for_month NUMERIC) 
AS
$$
BEGIN
	SELECT SUM(o.total_price) INTO SUM_total_price_for_month
	FROM order_details as od
	join orders as o on o.id = od.order_id
	WHERE od.order_date between start_date and end_date;
	
	IF SUM_total_price_for_month IS NULL THEN 
	SUM_total_price_for_month := 0;
	END IF;
END;
$$ LANGUAGE plpgsql;

--TEST
SELECT CalculateTotalPriceForDateRange('2023-09-01','2023-09-30')
	
