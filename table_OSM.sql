CREATE TABLE CUSTOMERS( customer_id int PRIMARY KEY,
					  	name varchar(100) NOT NULL,
					  	location varchar(200),
					   	contact varchar(50) UNIQUE NOT NULL,
					   	club_points float DEFAULT 0,
					   	total_spend float DEFAULT 0
					  );

CREATE TABLE EMPLOYESS( employye_id int PRIMARY KEY,
					  	name varchar(100) NOT NULL,
					   	location varchar(200),
					   	contact varchar(50) UNIQUE NOT NULL,
					   	salary float DEFAULT 0,
					   	commision float DEFAULT 0,
					   	position varchar(75)
					  );

CREATE TABLE PRODUCTS( product_id int PRIMARY KEY,
					   name varchar(100) NOT NULL,
					   manufacturer varchar(100),
					   type varchar(30),
					   subtype varchar(50),
					   price float CHECK (price > 0),
					   quantity_in_stock int CHECK (quantity_in_stock > 0),
					   total_quantity_sold int DEFAULT 0
					 );

CREATE TABLE ORDERS( id int PRIMARY KEY,
				   	 customer_id int REFERENCES CUSTOMERS(customer_id) ,
					 product_id int REFERENCES PRODUCTS(product_id),
					 employye_id int REFERENCES EMPLOYESS(employye_id),
					 quantity int CHECK (quantity > 0),
					 total_price float CHECK (total_price > 0),
					 club_point_used float,
					 customer_paid float
				   );

CREATE TABLE ORDER_DETAILS( order_id INT PRIMARY KEY,
						    order_date DATE NOT NULL,
						    possible_shipping_date DATE, -- DEFAULT (order_date + INTERVAL '3 days') FUNCTION TRIGGER
						    shipment_status VARCHAR(255),
						    FOREIGN KEY (order_id) REFERENCES ORDERS(id)
						  );

CREATE TABLE LOG( log_date DATE,
				  log_from varchar(70),
				  log_Msg varchar(255)
				);
				
ALTER TABLE LOG ADD log_user VARCHAR(70);
ALTER TABLE LOG ALTER COLUMN log_date SET DATA TYPE TIMESTAMP


ALTER TABLE order_details
ADD CONSTRAINT order_details_order_id_fkey_updated
FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE;

ALTER TABLE EMPLOYESS RENAME TO EMPLOYEES;
ALTER TABLE EMPLOYEES RENAME COLUMN employye_id TO employee_id;
ALTER TABLE ORDERS RENAME COLUMN employye_id TO employee_id;
ALTER TABLE CUSTOMERS ALTER COLUMN club_points SET NOT NULL;
