INSERT INTO CUSTOMERS (customer_id, name, location, contact, club_points, total_spend)
VALUES
    (1, 'John Doe', 'New York', 'john@example.com', 100.5, 500.25),
    (2, 'Alice Smith', 'Los Angeles', 'alice@example.com', 50.75, 250.30),
    (3, 'Bob Johnson', 'Chicago', 'bob@example.com', 75.25, 300.90),
    (4, 'Emily Brown', 'San Francisco', 'emily@example.com', 200.0, 1000.0),
    (5, 'Michael Lee', 'Houston', 'michael@example.com', 10.0, 50.0),
    (6, 'Olivia Davis', 'Miami', 'olivia@example.com', 30.0, 150.0),
    (7, 'William Wilson', 'Boston', 'william@example.com', 150.75, 750.50),
    (8, 'Sophia Taylor', 'Dallas', 'sophia@example.com', 90.25, 450.75),
    (9, 'James Wilson', 'Seattle', 'james@example.com', 25.5, 127.75),
    (10, 'Emma Lee', 'Denver', 'emma@example.com', 60.0, 300.0);

INSERT INTO EMPLOYESS (employye_id, name, location, contact, salary, commision, position)
VALUES
    (1, 'Robert Johnson', 'New York', 'robert@example.com', 50000.0, 0.0, 'Manager'),
    (2, 'Jennifer Davis', 'Los Angeles', 'jennifer@example.com', 40000.0, 0.0, 'Sales Associate'),
    (3, 'Michael Smith', 'Chicago', 'michael@example.com', 45000.0, 0.0, 'Sales Associate'),
    (4, 'Laura Wilson', 'San Francisco', 'laura@example.com', 55000.0, 0.0, 'Manager'),
    (5, 'David Lee', 'Houston', 'david@example.com', 40000.0, 0.0, 'Sales Associate'),
    (6, 'Sarah Brown', 'Miami', 'sarah@example.com', 35000.0, 0.0, 'Sales Associate'),
    (7, 'Ava Johnson', 'Boston', 'ava@example.com', 60000.0, 0.0, 'Manager'),
    (8, 'William Taylor', 'Dallas', 'william@example.com', 45000.0, 0.0, 'Sales Associate'),
    (9, 'Olivia Martin', 'Seattle', 'olivia@example.com', 40000.0, 0.0, 'Sales Associate'),
    (10, 'Ethan Wilson', 'Denver', 'ethan@example.com', 50000.0, 0.0, 'Manager');
	
INSERT INTO PRODUCTS (product_id, name, manufacturer, type, subtype, price, quantity_in_stock, total_quantity_sold)
VALUES
    (1, 'Laptop', 'Dell', 'Electronics', 'Computers', 999.99, 50, 20),
    (2, 'Smartphone', 'Apple', 'Electronics', 'Phones', 799.99, 100, 50),
    (3, 'TV', 'Samsung', 'Electronics', 'Televisions', 1299.99, 30, 10),
    (4, 'Chair', 'IKEA', 'Furniture', 'Chairs', 49.99, 200, 100),
    (5, 'Refrigerator', 'LG', 'Appliances', 'Refrigerators', 899.99, 40, 15),
    (6, 'Sneakers', 'Nike', 'Clothing', 'Footwear', 79.99, 150, 75),
    (7, 'Coffee Maker', 'Keurig', 'Appliances', 'Coffee Makers', 79.99, 60, 30),
    (8, 'Desk', 'IKEA', 'Furniture', 'Desks', 149.99, 100, 50),
    (9, 'Watch', 'Casio', 'Accessories', 'Watches', 29.99, 80, 40),
    (10, 'Gaming Console', 'Sony', 'Electronics', 'Game Consoles', 299.99, 25, 10);
	
INSERT INTO ORDERS (id, customer_id, product_id, employye_id, quantity, total_price, club_point_used, customer_paid)
VALUES 
    (1, 1, 2, 1, 2, 1599.98, 0.0, 1599.98),
    (2, 2, 5, 3, 1, 899.99, 0.0, 899.99),
    (3, 3, 1, 2, 3, 2999.97, 100.0, 2899.97),
    (4, 4, 4, 4, 4, 199.96, 0.0, 199.96),
    (5, 5, 7, 5, 2, 159.98, 0.0, 159.98),
    (6, 6, 10, 6, 1, 299.99, 0.0, 299.99),
    (7, 7, 3, 7, 1, 1299.99, 0.0, 1299.99),
    (8, 8, 6, 8, 2, 159.98, 0.0, 159.98),
    (9, 9, 8, 9, 1, 149.99, 0.0, 149.99),
    (10, 10, 9, 10, 3, 89.97, 0.0, 89.97);
	
INSERT INTO ORDER_DETAILS (order_id, order_date, possible_shipping_date, shipment_status)
VALUES
    (1, '2023-09-01', NULL, 'In Progress'),
    (2, '2023-09-02', NULL, 'Pending'),
    (3, '2023-09-03', NULL, 'Shipped'),
    (4, '2023-09-04', NULL, 'Delivered'),
    (5, '2023-09-05', NULL, 'In Progress'),
    (6, '2023-09-06', NULL, 'Pending'),
    (7, '2023-09-07', NULL, 'Shipped'),
    (8, '2023-09-08', NULL, 'Delivered'),
    (9, '2023-09-09', NULL, 'In Progress'),
    (10, '2023-09-10', NULL, 'Pending');

UPDATE EMPLOYESS
SET commision = 1000.0
WHERE position = 'Sales Associate';
