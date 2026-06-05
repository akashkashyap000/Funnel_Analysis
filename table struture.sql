-- Orders table
CREATE TABLE orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

-- Payments table
CREATE TABLE payments (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(20),
    payment_installments INT,
    payment_value FLOAT
);

-- Reviews table drop karo
DROP TABLE reviews;

-- Naya table banao extra columns ke saath
CREATE TABLE reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title VARCHAR(100),
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

-- Items table
CREATE TABLE items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date TIMESTAMP,
    price FLOAT,
    freight_value FLOAT
);

-- Customers table
CREATE TABLE customers (
    customer_id VARCHAR(50),
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(50),
    customer_state VARCHAR(10)
);


-- Orders import
COPY orders
FROM 'D:/olist_orders_dataset.csv'
DELIMITER ','
CSV HEADER;

-- Payments import
COPY payments
FROM 'D:/olist_order_payments_dataset.csv'
DELIMITER ','
CSV HEADER;

-- Reviews import
COPY reviews
FROM 'D:/olist_order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER;

-- Items import
COPY items
FROM 'D:/olist_order_items_dataset.csv'
DELIMITER ','
CSV HEADER;

-- Customers import
COPY customers
FROM 'D:/olist_customers_dataset.csv'
DELIMITER ','
CSV HEADER;