/*Analiza efektywności pracowników w generowaniu sprzedaży:

Przegląd, który pracownik generuje najwięcej sprzedaży i prowizji.
*/

SELECT e.employee_id, e.name, SUM(o.total_price) AS TotalSales, SUM(e.commision) AS TotalCommission
FROM Employees AS e
JOIN Orders AS o ON e.employee_id = o.employee_id
JOIN Order_Details AS od On o.id = od.order_id
GROUP BY e.employee_id, e.name
ORDER BY TotalSales DESC;
