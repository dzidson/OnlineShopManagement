SELECT * FROM ORDERS
SELECT * FROM ORDER_DETAILS
SELECT * FROM PRODUCTS
/*

Analiza trendów sprzedaży:

Przegląd sprzedaży produktów w ciągu roku.
Określenie sezonowości w sprzedaży różnych produktów.
Średnią miesięczną sprzedaż w określonym okresie czasu.

*/

WITH YearlySales AS (
    SELECT EXTRACT(YEAR FROM OD.ORDER_DATE) AS YEAR,
           SUM(TOTAL_PRICE) AS TOTALSALES
    FROM ORDERS AS O
    JOIN ORDER_DETAILS AS OD ON OD.ORDER_ID = O.ID
    WHERE OD.ORDER_DATE BETWEEN '2023-01-01' AND '2023-12-31'
    GROUP BY YEAR
)
SELECT * FROM YearlySales;

WITH season_product AS (
    SELECT EXTRACT(YEAR FROM OD.ORDER_DATE) AS YEAR,
           EXTRACT(MONTH FROM OD.order_date) AS MONTH,
           o.product_id,
           SUM(o.quantity) AS TotalQuantitySold
    FROM ORDERS AS O
    JOIN ORDER_DETAILS AS OD ON OD.order_id = O.id
    JOIN PRODUCTS AS P ON P.product_id = O.product_id
    WHERE OD.ORDER_DATE BETWEEN '2023-01-01' AND '2023-12-31'
    GROUP BY YEAR, MONTH, o.product_id
)
SELECT * FROM season_product;

WITH MonthlySales AS (
    SELECT EXTRACT(YEAR FROM OD.ORDER_DATE) AS YEAR,
           EXTRACT(MONTH FROM OD.ORDER_DATE) AS MONTH,
           ROUND(AVG(O.TOTAL_PRICE)::numeric, 4) AS AvgMonthlySales
    FROM ORDERS AS O
    JOIN ORDER_DETAILS AS OD ON OD.ORDER_ID = O.ID
    WHERE OD.ORDER_DATE BETWEEN '2023-01-01' AND '2023-12-31'
    GROUP BY YEAR, MONTH
	ORDER BY MONTH 
)
SELECT * FROM MonthlySales;