# E-Commerce Sales Analysis using PostgreSQL

## About the Project

I created this project to practice SQL and analyze an e-commerce dataset using PostgreSQL.

The main aim of this project is to understand sales performance, customer behavior, product performance, monthly sales, order status, and payment methods using SQL queries.

I worked with four tables: Customers, Products, Orders, and Order Items.


## Tools Used

* PostgreSQL
* SQL
* GitHub



## Database Tables

### 1. Customers

Contains customer details such as:

* Customer ID
* Customer Name
* Gender
* City
* State
* Signup Date

### 2. Products

Contains product information:

* Product ID
* Product Name
* Category
* Sub Category
* Price

### 3. Orders

Contains order information:

* Order ID
* Customer ID
* Order Date
* Payment Method
* Order Status

### 4. Order Items

Contains the products included in each order:

* Order Item ID
* Order ID
* Product ID
* Quantity
* Unit Price



## Project Structure


ecommerce-sales-analysis-postgresql/
│
├── README.md
│
├── data/
│   ├── customers.csv
│   ├── products.csv
│   ├── orders.csv
│   └── order_items.csv
│
├── sql/
│   ├── 01_create_tables.sql
│   ├── 02_insert_data.sql
│   ├── 03_data_cleaning.sql
│   ├── 04_sales_analysis.sql
│   ├── 05_customer_analysis.sql
│   ├── 06_product_analysis.sql
│   ├── 07_monthly_analysis.sql
│   ├── 08_order_payment_analysis.sql
│   └── 09_business_analysis.sql
│
└── screenshots/



## What I Analyzed

### Sales Analysis

I analyzed:

* Total orders
* Delivered and cancelled orders
* Total units sold
* Total revenue
* Average Order Value
* Revenue by city
* Revenue by payment method

### Customer Analysis

I analyzed:

* Customer-wise revenue
* Top customers
* Repeat customers
* Customer Average Order Value
* Customer segmentation
* Customer ranking
* Top customer from each city

### Product Analysis

I analyzed:

* Product-wise revenue
* Units sold by product
* Top products
* Category-wise sales
* Sub-category performance
* Top product in each category

### Monthly Analysis

I analyzed:

* Monthly orders
* Monthly revenue
* Monthly units sold
* Monthly Average Order Value
* Month-over-Month revenue growth
* Monthly category performance

### Order & Payment Analysis

I analyzed:

* Order status
* Cancellation rate
* Payment method usage
* Revenue by payment method
* Payment method contribution
* City-wise cancellation rate



## SQL Concepts Used

During this project I used:

* SELECT
* WHERE
* ORDER BY
* GROUP BY
* HAVING
* CASE
* Aggregate Functions
* JOINs
* LEFT JOIN
* SELF JOIN
* CTEs
* Subqueries
* EXISTS
* UNION
* Date Functions
* String Functions
* Window Functions
* RANK
* ROW_NUMBER
* DENSE_RANK
* LAG
* Data Validation
* NULL Checking



## Key Results

Some results from my analysis:

* Total Orders: **32**
* Delivered Orders: **30**
* Cancelled Orders: **2**
* Cancellation Rate: **6.25%**
* Total Revenue: **₹7,00,000**
* Total Units Sold: **77**
* Average Order Value: **₹23,333.33**

### Other Findings

* Electronics generated the highest revenue with **₹4,98,000**.
* Electronics contributed around **71.14%** of total revenue.
* Laptop was the highest-revenue product with **₹3,00,000**.
* The top 3 customers contributed around **57.7%** of total revenue.
* April 2026 had the highest monthly revenue of **₹1,26,000**.



## Data Validation

Before doing the analysis, I checked the data for:

* NULL values
* Duplicate IDs
* Invalid quantities
* Invalid prices
* Invalid order statuses
* Invalid payment methods
* Missing customer records
* Missing product records
* Missing order records
* Product price mismatches
* Cancelled orders



## Business Questions

Some of the questions I tried to answer using SQL were:

1. What is the total revenue?
2. How many orders were delivered and cancelled?
3. Which customers generated the most revenue?
4. Which products sold the most?
5. Which category generated the highest revenue?
6. Which city generated the most revenue?
7. What is the monthly revenue?
8. How is revenue changing month by month?
9. Which payment method is used the most?
10. What is the cancellation rate?
11. Who are the repeat customers?
12. Which product performs best in each category?



## What I Learned

Through this project, I got practical practice with PostgreSQL and learned how SQL can be used to answer business-related questions from raw data.

I also got more practice with joins, aggregations, CTEs, subqueries, and window functions while working on different analysis problems.



## Author

**Shailendra Prajapat**

B.Tech Graduate | Aspiring Data Analyst

### Skills

**SQL | PostgreSQL | Excel | Power BI | Python**
