
-- =====================================================
-- PROJECT: E-COMMERCE SALES ANALYSIS
-- BUSINESS ANALYSIS QUERIES
-- DATABASE: MySQL 8.0+
-- =====================================================

USE ecommerce_analysis;

-- TASK 1: TOTAL NUMBER OF ORDERS
SELECT COUNT(*) AS total_orders
FROM Orders;


-- TASK 2: ORDER STATUS ANALYSIS
SELECT
    status,
    COUNT(*) AS total_orders
FROM Orders
GROUP BY status;


-- TASK 3: TOTAL REVENUE FROM COMPLETED ORDERS
SELECT
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM Orders o
INNER JOIN Order_Items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed';


-- TASK 4: CATEGORY-WISE REVENUE
SELECT
    c.category_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM Categories c
INNER JOIN Products p
    ON c.category_id = p.category_id
INNER JOIN Order_Items oi
    ON p.product_id = oi.product_id
INNER JOIN Orders o
    ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY c.category_id, c.category_name
ORDER BY total_revenue DESC;


-- TASK 5: TOP-SELLING PRODUCTS BY COMPLETED UNITS
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_units_sold
FROM Products p
INNER JOIN Order_Items oi
    ON p.product_id = oi.product_id
INNER JOIN Orders o
    ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY p.product_id, p.product_name
ORDER BY total_units_sold DESC;


-- TASK 6: TOP 5 CUSTOMERS BY COMPLETED REVENUE
SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
INNER JOIN Order_Items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC
LIMIT 5;


-- TASK 7: AVERAGE ORDER VALUE (AOV)
WITH order_revenue AS (
    SELECT
        o.order_id,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM Orders o
    INNER JOIN Order_Items oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'Completed'
    GROUP BY o.order_id
)
SELECT
    SUM(order_total) AS total_revenue,
    COUNT(*) AS completed_orders,
    ROUND(AVG(order_total), 2) AS average_order_value
FROM order_revenue;


-- TASK 8: MONTHLY SALES TREND
SELECT
    YEAR(o.order_date) AS sales_year,
    MONTHNAME(o.order_date) AS sales_month,
    SUM(oi.quantity * oi.unit_price) AS monthly_revenue
FROM Orders o
INNER JOIN Order_Items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY YEAR(o.order_date), MONTH(o.order_date),
         MONTHNAME(o.order_date)
ORDER BY sales_year, MONTH(o.order_date);


-- TASK 9: CUSTOMERS WHO NEVER PLACED AN ORDER
SELECT
    c.customer_id,
    c.customer_name,
    c.city
FROM Customers c
LEFT JOIN Orders o
    ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


-- TASK 10: CITY-WISE COMPLETED REVENUE
SELECT
    c.city,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
INNER JOIN Order_Items oi
    ON o.order_id = oi.order_id
WHERE o.status = 'Completed'
GROUP BY c.city
ORDER BY total_revenue DESC;


-- TASK 11: PAYMENT METHOD ANALYSIS
SELECT
    payment_method,
    COUNT(*) AS total_payments,
    SUM(amount) AS total_amount
FROM Payments
WHERE payment_status = 'Paid'
GROUP BY payment_method
ORDER BY total_amount DESC;


-- TASK 12: ORDER STATUS VS PAYMENT STATUS
SELECT
    o.status AS order_status,
    p.payment_status,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(p.amount) AS total_payment_amount
FROM Orders o
INNER JOIN Payments p
    ON o.order_id = p.order_id
GROUP BY o.status, p.payment_status
ORDER BY o.status;


-- TASK 13: PRODUCT PERFORMANCE ANALYSIS
SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.unit_price) AS total_revenue,
    ROUND(
        SUM(oi.quantity * oi.unit_price) / SUM(oi.quantity),
        2
    ) AS average_selling_price
FROM Products p
INNER JOIN Order_Items oi
    ON p.product_id = oi.product_id
INNER JOIN Orders o
    ON oi.order_id = o.order_id
WHERE o.status = 'Completed'
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC;


-- TASK 14: CUSTOMER PURCHASE FREQUENCY
-- Include customers with zero completed orders.
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_completed_orders
FROM Customers c
LEFT JOIN Orders o
    ON c.customer_id = o.customer_id
    AND o.status = 'Completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_completed_orders DESC;


-- TASK 15: REPEAT CUSTOMERS
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS completed_orders
FROM Customers c
INNER JOIN Orders o
    ON c.customer_id = o.customer_id
WHERE o.status = 'Completed'
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) >= 2
ORDER BY completed_orders DESC;


-- TASK 16: ORDER VALUE CLASSIFICATION
WITH order_revenue AS (
    SELECT
        o.order_id,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM Orders o
    INNER JOIN Order_Items oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'Completed'
    GROUP BY o.order_id
)
SELECT
    order_id,
    order_total,
    CASE
        WHEN order_total >= 20000 THEN 'High Value'
        WHEN order_total >= 5000 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS order_category
FROM order_revenue
ORDER BY order_total DESC;


-- TASK 17: INVENTORY AND STOCK ANALYSIS
SELECT
    product_id,
    product_name,
    stock_quantity,
    CASE
        WHEN stock_quantity < 20 THEN 'Low Stock'
        WHEN stock_quantity <= 50 THEN 'Medium Stock'
        ELSE 'High Stock'
    END AS stock_status
FROM Products
ORDER BY stock_quantity;


-- TASK 18: CATEGORY REVENUE CONTRIBUTION PERCENTAGE
WITH category_revenue AS (
    SELECT
        c.category_id,
        c.category_name,
        SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM Categories c
    INNER JOIN Products p
        ON c.category_id = p.category_id
    INNER JOIN Order_Items oi
        ON p.product_id = oi.product_id
    INNER JOIN Orders o
        ON oi.order_id = o.order_id
    WHERE o.status = 'Completed'
    GROUP BY c.category_id, c.category_name
)
SELECT
    category_name,
    total_revenue,
    ROUND(
        total_revenue * 100.0 /
        SUM(total_revenue) OVER (),
        2
    ) AS revenue_percentage
FROM category_revenue
ORDER BY total_revenue DESC;


-- TASK 19: CUSTOMER RANKING USING WINDOW FUNCTIONS
WITH customer_revenue AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM Customers c
    INNER JOIN Orders o
        ON c.customer_id = o.customer_id
    INNER JOIN Order_Items oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'Completed'
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_id,
    customer_name,
    total_revenue,
    ROW_NUMBER() OVER (
        ORDER BY total_revenue DESC
    ) AS row_num,
    RANK() OVER (
        ORDER BY total_revenue DESC
    ) AS revenue_rank,
    DENSE_RANK() OVER (
        ORDER BY total_revenue DESC
    ) AS dense_revenue_rank
FROM customer_revenue
ORDER BY total_revenue DESC;


-- TASK 20: TOP 3 CUSTOMERS BY REVENUE
WITH customer_revenue AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.unit_price) AS total_revenue
    FROM Customers c
    INNER JOIN Orders o
        ON c.customer_id = o.customer_id
    INNER JOIN Order_Items oi
        ON o.order_id = oi.order_id
    WHERE o.status = 'Completed'
    GROUP BY c.customer_id, c.customer_name
),
customer_ranking AS (
    SELECT
        customer_id,
        customer_name,
        total_revenue,
        ROW_NUMBER() OVER (
            ORDER BY total_revenue DESC
        ) AS customer_rank
    FROM customer_revenue
)
SELECT *
FROM customer_ranking
WHERE customer_rank <= 3
ORDER BY customer_rank;
