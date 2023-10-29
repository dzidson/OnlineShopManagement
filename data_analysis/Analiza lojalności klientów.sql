/*Analiza lojalności klientów:

Średnia ilość punktów klubowych zdobywanych przez klientów.
Znalezienie klientów, którzy najczęściej korzystają z punktów klubowych.
*/

SELECT AVG(club_points)
FROM CUSTOMERS


SELECT customer_id, name, MAX(club_points) as MaxClubPoints
FROM CUSTOMERS
GROUP BY customer_id, name
ORDER BY MaxClubPoints DESC
