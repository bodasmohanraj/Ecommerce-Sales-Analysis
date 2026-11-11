
-- =====================================================
-- PROJECT: E-COMMERCE SALES ANALYSIS
-- SAMPLE DATA INSERTION
-- =====================================================

USE ecommerce_analysis;

-- 1. CUSTOMERS
INSERT INTO Customers
(customer_id, customer_name, email, city, registration_date)
VALUES
(1, 'Mohan', 'mohan@gmail.com', 'Hyderabad', '2025-01-10'),
(2, 'Rahul', 'rahul@gmail.com', 'Bangalore', '2025-01-15'),
(3, 'Priya', 'priya@gmail.com', 'Chennai', '2025-02-01'),
(4, 'Anil', 'anil@gmail.com', 'Mumbai', '2025-02-10'),
(5, 'Sneha', 'sneha@gmail.com', 'Hyderabad', '2025-02-20'),
(6, 'Kiran', 'kiran@gmail.com', 'Pune', '2025-03-05'),
(7, 'Divya', 'divya@gmail.com', 'Delhi', '2025-03-12'),
(8, 'Arjun', 'arjun@gmail.com', 'Bangalore', '2025-03-20'),
(9, 'Meena', 'meena@gmail.com', 'Chennai', '2025-04-01'),
(10, 'Vikram', 'vikram@gmail.com', 'Mumbai', '2025-04-15');

-- 2. CATEGORIES
INSERT INTO Categories
(category_id, category_name)
VALUES
(1, 'Electronics'),
(2, 'Clothing'),
(3, 'Furniture'),
(4, 'Books'),
(5, 'Home Appliances');

-- 3. PRODUCTS
INSERT INTO Products
(product_id, product_name, category_id, price, stock_quantity)
VALUES
(101, 'Laptop', 1, 55000, 20),
(102, 'Smartphone', 1, 25000, 35),
(103, 'Headphones', 1, 2000, 50),
(104, 'T-Shirt', 2, 500, 100),
(105, 'Jeans', 2, 1200, 60),
(106, 'Office Chair', 3, 7000, 15),
(107, 'Study Table', 3, 9000, 10),
(108, 'SQL Book', 4, 600, 80),
(109, 'Python Book', 4, 750, 70),
(110, 'Mixer Grinder', 5, 3500, 25);

-- 4. ORDERS
INSERT INTO Orders
(order_id, customer_id, order_date, status)
VALUES
(1001, 1, '2025-05-01', 'Completed'),
(1002, 2, '2025-05-02', 'Completed'),
(1003, 3, '2025-05-03', 'Pending'),
(1004, 1, '2025-05-04', 'Completed'),
(1005, 4, '2025-05-05', 'Cancelled'),
(1006, 5, '2025-05-06', 'Completed'),
(1007, 6, '2025-05-07', 'Completed'),
(1008, 7, '2025-05-08', 'Pending'),
(1009, 8, '2025-05-09', 'Completed'),
(1010, 9, '2025-05-10', 'Completed'),
(1011, 10, '2025-05-11', 'Cancelled'),
(1012, 2, '2025-05-12', 'Completed'),
(1013, 3, '2025-05-13', 'Completed'),
(1014, 5, '2025-05-14', 'Pending'),
(1015, 1, '2025-05-15', 'Completed');

-- 5. ORDER ITEMS
INSERT INTO Order_Items
(order_item_id, order_id, product_id, quantity, unit_price)
VALUES
(1, 1001, 101, 1, 55000),
(2, 1001, 103, 2, 2000),
(3, 1002, 102, 1, 25000),
(4, 1002, 104, 2, 500),
(5, 1003, 108, 2, 600),
(6, 1004, 105, 2, 1200),
(7, 1004, 109, 1, 750),
(8, 1005, 106, 1, 7000),
(9, 1006, 110, 1, 3500),
(10, 1006, 104, 3, 500),
(11, 1007, 107, 1, 9000),
(12, 1008, 108, 3, 600),
(13, 1009, 101, 1, 55000),
(14, 1009, 103, 1, 2000),
(15, 1010, 105, 1, 1200),
(16, 1010, 108, 2, 600),
(17, 1011, 102, 1, 25000),
(18, 1012, 103, 2, 2000),
(19, 1013, 109, 2, 750),
(20, 1015, 110, 2, 3500);

-- 6. PAYMENTS
INSERT INTO Payments
(payment_id, order_id, amount, payment_method, payment_status, payment_date)
VALUES
(1, 1001, 59000, 'Credit Card', 'Paid', '2025-05-01'),
(2, 1002, 26000, 'UPI', 'Paid', '2025-05-02'),
(3, 1003, 1200, 'UPI', 'Pending', '2025-05-03'),
(4, 1004, 3150, 'Debit Card', 'Paid', '2025-05-04'),
(5, 1005, 7000, 'Credit Card', 'Refunded', '2025-05-05'),
(6, 1006, 5000, 'UPI', 'Paid', '2025-05-06'),
(7, 1007, 9000, 'Net Banking', 'Paid', '2025-05-07'),
(8, 1008, 1800, 'UPI', 'Pending', '2025-05-08'),
(9, 1009, 57000, 'Credit Card', 'Paid', '2025-05-09'),
(10, 1010, 2400, 'Debit Card', 'Paid', '2025-05-10'),
(11, 1011, 25000, 'UPI', 'Refunded', '2025-05-11'),
(12, 1012, 4000, 'UPI', 'Paid', '2025-05-12'),
(13, 1013, 1500, 'Credit Card', 'Paid', '2025-05-13'),
(14, 1014, 0, 'UPI', 'Pending', '2025-05-14'),
(15, 1015, 7000, 'Debit Card', 'Paid', '2025-05-15');

-- VERIFY RECORD COUNTS
SELECT 'Customers' AS table_name, COUNT(*) AS total_records FROM Customers
UNION ALL
SELECT 'Categories', COUNT(*) FROM Categories
UNION ALL
SELECT 'Products', COUNT(*) FROM Products
UNION ALL
SELECT 'Orders', COUNT(*) FROM Orders
UNION ALL
SELECT 'Order_Items', COUNT(*) FROM Order_Items
UNION ALL
SELECT 'Payments', COUNT(*) FROM Payments;
