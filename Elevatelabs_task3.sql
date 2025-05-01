USE ecommerce_db;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    country VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    total_amount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers (customer_name, email, country) VALUES
('Ravi Kumar', 'ravi@example.com', 'India'),
('Anita Sharma', 'anita@example.com', 'India'),
('John Smith', 'john@example.com', 'USA'),
('Linda White', 'linda@example.com', 'UK'),
('Chen Wei', 'chen@example.com', 'China');


INSERT INTO products (product_name, category, price) VALUES
('Laptop', 'Electronics', 60000.00),
('Smartphone', 'Electronics', 25000.00),
('Headphones', 'Accessories', 2000.00),
('Backpack', 'Accessories', 1500.00),
('Shoes', 'Fashion', 3000.00);


INSERT INTO orders (customer_id, product_id, order_date, quantity, total_amount, status) VALUES
(1, 1, '2024-01-10', 1, 60000.00, 'Shipped'),
(2, 2, '2024-01-15', 2, 50000.00, 'Shipped'),
(3, 3, '2024-02-01', 1, 2000.00, 'Pending'),
(4, 4, '2024-02-10', 3, 4500.00, 'Cancelled'),
(5, 5, '2024-03-05', 2, 6000.00, 'Shipped'),
(1, 2, '2024-03-12', 1, 25000.00, 'Shipped'),
(3, 5, '2024-03-20', 1, 3000.00, 'Shipped'),
(2, 3, '2024-04-01', 2, 4000.00, 'Pending');


SELECT * FROM customers;


-- View Products
SELECT * FROM products;

-- View Orders
SELECT * FROM orders;

-- Shipped orders, most recent first
SELECT * FROM orders 
WHERE status = 'Shipped'
ORDER BY order_date DESC;

-- Total revenue per customer
SELECT 
    c.customer_name,
    SUM(o.total_amount) AS total_spent,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;

-- Average order value per product
-- View for monthly sales summary
CREATE OR REPLACE VIEW monthly_sales_summary AS
SELECT
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(total_amount) AS total_revenue,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date);

SELECT * FROM monthly_sales_summary;



