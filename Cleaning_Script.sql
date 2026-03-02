# 1.  Loading the Dataset

CREATE DATABASE SupplyChain_Project;
USE supplychain_project;

CREATE TABLE dataco_supplychain_data(
transaction_type VARCHAR(255),
days_for_shipping_real INT,
days_for_shipment_scheduled INT,
benefit_per_order DOUBLE,
sales_per_customer DOUBLE,
delivery_status VARCHAR(255),
late_delivery_risk INT,
category_id INT,
category_name VARCHAR(255),
customer_city VARCHAR(255),
customer_country VARCHAR(255),
customer_email VARCHAR(255),
customer_fname VARCHAR(255),
customer_id INT,
customer_lname VARCHAR(255),
customer_password VARCHAR(255),
customer_segment VARCHAR(255),
customer_state VARCHAR(255),
customer_street VARCHAR(255),
customer_zipcode VARCHAR(20),
department_id INT,
department_name VARCHAR(255),
latitude DOUBLE,
longitude DOUBLE,
market VARCHAR(255),
order_city VARCHAR(255),
order_country VARCHAR(255),
order_customer_id INT,
order_date_dateorders text,
order_id INT,
order_item_cardprod_id INT,
order_item_discount double,
order_item_discount_rate double,
order_item_id INT,
order_item_product_price DOUBLE,
order_item_profit_ratio DOUBLE, 
order_item_quantity INT,
sales DOUBLE,
order_item_total DOUBLE,
order_profit_per_order DOUBLE,
order_region VARCHAR(255),
order_state VARCHAR(100),
order_status VARCHAR(255),
order_zipcode VARCHAR(255),
product_card_id INT,
product_category_id INT,
product_description TEXT,
product_image TEXT,
product_name VARCHAR(255),
product_price DOUBLE,
product_status INT,
shipping_date_dateorders TEXT,
shipping_mode VARCHAR(255)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE dataco_supplychain_data;
SELECT * FROM dataco_supplychain_data;


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/DataCoSupplyChainDataset.csv'
INTO TABLE dataco_supplychain_data
CHARACTER SET latin1
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;


SHOW VARIABLES LIKE "secure_file_priv";

SELECT * FROM dataco_supplychain_data
LIMIT 5;



# 2. Date Inconsistencies
DESCRIBE SupplyChain_Project.dataco_supplychain_data;

SELECT COUNT(*) AS no_of_rows, 
       SUM(CASE WHEN order_date_dateorders IS NULL OR order_date_dateorders = " " THEN 1 ELSE 0 END) AS nulls_order_date, 
       SUM(CASE WHEN shipping_date_dateorders IS NULL OR shipping_date_dateorders = " " THEN 1 ELSE 0 END) AS nulls_shipping_date
FROM dataco_supplychain_data;

ALTER TABLE dataco_supplychain_data
ADD COLUMN order_date_dateorders_clean DATETIME,
ADD COLUMN shipping_date_dateorders_clean DATETIME;

SET SQL_SAFE_UPDATES = 0;

UPDATE dataco_supplychain_data
SET order_date_dateorders_clean = str_to_date(REPLACE(`order_date_dateorders`,'/','-' ), '%m-%d-%Y %H:%i')
WHERE `order_date_dateorders` NOT LIKE "%order_date%";
    
 UPDATE dataco_supplychain_data   
 SET shipping_date_dateorders_clean = str_to_date(REPLACE(`shipping_date_dateorders`,'/','-' ),'%m-%d-%Y %H:%i')
 WHERE `shipping_date_dateorders` NOT LIKE "%shipping_date%";
 
SET SQL_SAFE_UPDATES = 1;