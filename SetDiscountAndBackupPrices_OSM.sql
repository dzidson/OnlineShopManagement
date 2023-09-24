CREATE OR REPLACE PROCEDURE SetDiscountAndBackupPrices( product_type varchar(30), 
                                                        discount int, 
                                                        p_start_date date, 
                                                        p_end_date date) 
AS
$$
DECLARE
    backup_filename varchar(255);
BEGIN
    -- Tworzenie unikalnej nazwy pliku CSV z datą i godziną
    backup_filename := 'C:\Users\pawel\OneDrive\Dokumenty\postgres\Online Shop Management\products_backup_'||product_type|| '.csv';
    
    -- Kopiowanie cen do pliku CSV na poziomie klienta
    EXECUTE 'COPY (SELECT p.product_id, p.price FROM products as p WHERE p.type = ''' || product_type || ''') 
    TO ''' || backup_filename || ''' WITH CSV HEADER';
    
    -- Aktualizacja cen z uwzględnieniem rabatu
    UPDATE products
    SET price = price - (price * discount / 100) 
    WHERE "type" = product_type;
END;
$$ LANGUAGE plpgsql;

--TEST
CALL SetDiscountAndBackupPrices('Appliances', 5, '2023-09-06', '2023-09-10');
CALL SetDiscountAndBackupPrices('Accessories', 5, '2023-09-06', '2023-09-10');
SELECT * FROM LOG;
SELECT * FROM PRODUCTS;