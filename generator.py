import psycopg2
import os
from os import listdir
from os.path import isfile, join 
import random as random
import sys
from random import randrange


class generator():
    
    DATABASE_HOST = 'localhost' 
    DATABASE_PORT = 5432
    DATABASE_USER = 'postgres'
    DATABASE_PASSWORD = 'password'
    DATABASE_NAME = 'Online Shop Management'
    db = None #uchwyt
    data_path = "OnlineShopManagement/data/" #pliki z przykładowymi danymi 
    result_path = 'OnlineShopManagement/result/' #pliki wynikowe które wygeneruje generator
     
    def __init__(self) -> None:
        self.db = psycopg2.connect(
            dbname = self.DATABASE_NAME,
            user = self.DATABASE_USER,
            host = self.DATABASE_HOST,
            port = self.DATABASE_PORT,  
            password = self.DATABASE_PASSWORD
        )
        
    def __del__(self):
        self.db.close()

    def gen_customers(self):
        count_cust = 50
        sql_template = "INSERT INTO CUSTOMERS(customer_id, name, location, contact, club_points, total_spend)"
        file_name = "customers.sql"

        customers_name_set = self.get_file_content_list("customers.txt")
        location_name_set = self.get_file_content_list("location.txt")
        contact_name_set = self.get_file_content_list("contact.txt")
        
        data = []
        
        for i in range(count_cust):
            customer_id = i + 1
            name = customers_name_set[i].strip()
            location = self.rand_element(location_name_set)
            contact = contact_name_set[i].strip()
            club_points = random.randint(0,100)
            total_spend = 0 
            data.append([customer_id, name, location, contact, club_points, total_spend])

        self.save_sql_to_file(file_name, sql_template, data)
        self.execute_sql(sql_template, data)

    def gen_employees(self):
        count_emp = 30
        sql_template = "INSERT INTO EMPLOYEES(employee_id, name, location, contact, salary, commision, position)"
        file_name = "employees.sql"
        employees_name_set = self.get_file_content_list("employees.txt")
        location_name_set = self.get_file_content_list("location.txt")
        contact_emp_name_set = self.get_file_content_list("contact_emp.txt")
        position_name_set = self.get_file_content_list("position.txt")

        data = []

        for i in range(count_emp):
            employee_id = i + 1
            name =  employees_name_set[i].strip()
            location = self.rand_element(location_name_set)
            contact = contact_emp_name_set[i].strip()
            salary = random.randint(3000,25000)
            commision = 0
            position = position_name_set[i].strip()
            data.append([employee_id, name, location, contact, salary, 
                         commision, position])
            
        self.save_sql_to_file(file_name, sql_template, data)
        self.execute_sql(sql_template, data)

    def gen_products(self):
        count_products = 100
        sql_template = "INSERT INTO PRODUCTS(product_id, name, manufacturer, type, subtype, price, quantity_in_stock, total_quantity_sold)"
        file_name = "products.sql"
        product_data = self.read_product_data('products.txt')
        data = []
        
        for i in range(count_products):
            product_id = i + 1
            name, type, subtype, manufacturer = self.rand_element(product_data)
            price = random.randint(10,10000)
            quantity_in_stock = random.randint(1000,10000)
            total_quantity_sold = 0
            data.append([product_id, name, manufacturer, type, subtype, price, quantity_in_stock, total_quantity_sold])

        self.save_sql_to_file(file_name, sql_template, data)
        self.execute_sql(sql_template, data)

    def gen_orders(self):
        count_order = 200
        sql_template = "INSERT INTO ORDERS(id, customer_id, product_id, employee_id, quantity, total_price, club_point_used, customer_paid)"
        file_name = "orders.sql"
        customer = self.sum_lines("customers.txt")
        product = self.sum_lines("products.txt")
        employye = self.sum_lines("employees.txt")
        data = []

        for i in range(count_order):
            id = i+1
            customer_id = random.randint(1, customer)
            product_id = random.randint(1, product)
            employee_id = random.randint(1, employye)
            quantity = random.randint(1,100)
            total_price = 0
            club_point_used = 0
            customer_paid = 0
            data.append([id, customer_id, product_id, employee_id, quantity, total_price, club_point_used, customer_paid])

        self.save_sql_to_file(file_name, sql_template, data)
        self.execute_sql(sql_template, data)

    def sum_lines(self, file_name):
        with open(self.data_path + file_name, 'r', encoding='utf-8') as file:
            num_lines = sum(1 for _ in file)
            return num_lines

    def read_product_data(self, file_name):
        product_data = []
        with open(self.data_path + file_name, 'r', encoding='utf-8') as file:
            for line in file:
                parts = line.strip().split(',')
                if len(parts) == 4:
                    name, type, subtype, manufacturer = parts
                    product_data.append((name.strip(), type.strip(), subtype.strip(), manufacturer.strip()))
        return product_data

    def get_file_content_list(self, file_name):
        data_file = open(self.data_path + file_name, "r", encoding="utf-8")
        content = data_file.readlines()
        data_file.close()
        return content
    
    def rand_element(self, array):
        return array[random.randint(0, len(array) - 1 )]
    
    def save_sql_to_file(self, file_name,sql_template, data):
        if os.path.exists(self.result_path + file_name):
            os.remove(self.result_path + file_name)
        sqlOutputs = open(self.result_path + file_name, "a")
        sqlOutputs.write(sql_template + '\n')
        i = 1
        for item_set in data:
            item = [str(element) for element in item_set]
            valuesSql = "('" + "', '".join(item) + "')"
            if i != len(data):
                sqlOutputs.write(valuesSql + ', \n')
            else:
                sqlOutputs.write(valuesSql)
            i += 1
        sqlOutputs.write(';\n\n')
        sqlOutputs.close()

    def execute_sql(self, sql_template, data):
        if len(data) <= 0:
            return

        sql_template = sql_template + " values (" + ','.join(["%s " for item in data[0]]) + ");"

        cursor = self.db.cursor()
        cursor.executemany(sql_template, data)
        self.db.commit()