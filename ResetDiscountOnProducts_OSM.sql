CREATE OR REPLACE FUNCTION ResetDiscountOnProducts(product_type varchar(30)) RETURNS void
AS
$$
DECLARE 
    pid int;
    Oldprice numeric;
    csv_filename varchar(255);
BEGIN
    -- Budowanie nazwy pliku CSV z wykorzystaniem funkcji CONCAT
    csv_filename := CONCAT('C:\Users\pawel\OneDrive\Dokumenty\postgres\Online Shop Management\products_backup_', product_type, '.csv');

    -- Tworzenie tymczasowej tabeli do skopiowania danych
    CREATE TEMPORARY TABLE temp_products (product_id int, price numeric);

    -- Skopiowanie ceny z pliku do tabeli tymczasowej, użycie quote_literal aby uzyskać pożądany ciąg znaków
    EXECUTE 'COPY temp_products FROM ' || quote_literal(csv_filename) || ' WITH CSV HEADER';

    -- Pobranie danych z tabeli tymczasowej do zmiennych
    SELECT product_id, price INTO pid, Oldprice FROM temp_products;

    -- Wyświetlenie starej ceny w dzienniku
    RAISE NOTICE 'Old Price: %', Oldprice;

    -- Zaktualizowanie cen
    UPDATE products
    SET price = Oldprice
    WHERE type = product_type;

    -- Usunięcie tabeli tymczasowej
    DROP TABLE temp_products;
END;
$$ LANGUAGE plpgsql;

SELECT ResetDiscountOnProducts('Accessories');
SELECT * FROM LOG;
SELECT * FROM PRODUCTS;