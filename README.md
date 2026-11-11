# E-commerce Sales Analysis using MySQL

## Project Overview

This project analyzes an e-commerce business dataset using MySQL to understand sales performance, customer purchasing behavior, product performance, payment methods, and inventory levels.

The objective is to transform raw relational data into meaningful business insights that can support better decision-making.

## Technologies Used

- MySQL 8.0+
- MySQL Workbench
- SQL

## Database Schema

The project contains six relational tables:

| Table | Description |
|---|---|
| Customers | Customer information |
| Categories | Product categories |
| Products | Product details and stock |
| Orders | Customer order information |
| Order_Items | Products purchased in each order |
| Payments | Payment details and status |

## SQL Concepts Applied

- SELECT, WHERE, ORDER BY, LIMIT
- Aggregate functions: COUNT, SUM, AVG, MIN, MAX
- GROUP BY and HAVING
- INNER JOIN, LEFT JOIN
- Subqueries and CTEs
- CASE WHEN
- UNION
- Window functions: ROW_NUMBER, RANK, DENSE_RANK
- Date functions
- Revenue calculations and percentage contribution

## Business Questions Answered

1. What is the total number of orders?
2. How many orders are completed, pending, and cancelled?
3. What is the total revenue from completed orders?
4. Which product categories generate the highest revenue?
5. Which products sell the most units?
6. Who are the top five customers by revenue?
7. What is the average order value?
8. What is the monthly sales trend?
9. Which customers have never placed an order?
10. Which cities generate the highest revenue?
11. Which payment methods are most commonly used?
12. What is the relationship between order and payment status?
13. How does each product perform?
14. How frequently do customers purchase?
15. Who are the repeat customers?
16. How can orders be classified by value?
17. Which products have low, medium, or high stock?
18. What percentage of revenue comes from each category?
19. How can customers be ranked by revenue?
20. Who are the top three customers?

## Key Business Insights

The following insights were calculated from the sample dataset:

| Metric | Result |
|---|---:|
| Total orders | 15 |
| Completed orders | 10 |
| Pending orders | 3 |
| Cancelled orders | 2 |
| Completed-order revenue | ₹174,050 |
| Average order value | ₹17,405 |
| Highest-revenue category | Electronics |
| Highest-revenue city | Bangalore |
| Highest-revenue customer | Mohan |

### Additional Findings

- Electronics generated ₹145,000, approximately 83.31% of completed-order revenue.
- Bangalore generated ₹87,000 in completed-order revenue.
- Mohan was the highest-revenue customer, generating ₹69,150.
- Laptop generated the highest product revenue of ₹110,000.
- Headphones and T-Shirts were the highest-selling products by quantity, with five units each.
- Two products were classified as low stock.

## Project Structure

```text
Ecommerce-Sales-Analysis/
│
├── README.md
├── SQL/
│   ├── 01_create_database_tables.sql
│   ├── 02_insert_sample_data.sql
│   └── 03_business_analysis_queries.sql
│
└── screenshots/
```

## How to Run the Project

1. Install MySQL 8.0+ and MySQL Workbench.
2. Open the SQL scripts in MySQL Workbench.
3. Execute `01_create_database_tables.sql`.
4. Execute `02_insert_sample_data.sql`.
5. Execute `03_business_analysis_queries.sql` to explore the analysis.
6. Review the query results and business findings.

## Dataset Information

This is an illustrative practice dataset containing:

- 10 customers
- 5 product categories
- 10 products
- 15 orders
- 20 order items
- 15