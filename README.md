# Online-Retail-Sales-Analysis-SQL-Project-
## Project Overview
This project analyzes 100k + transactions from a UK-based online retail company specializing in unique gift-ware, spanning from February 2010 to May 2010. The analysis provides actionable business insights through comprehensive SQL queries and data-driven recommendations.
The main goal is to perform data exploration and answer key business questions related to sales performance, customer behavior, and product trends.

Industry: E-commerce & Wholesale Gift-ware

Records: 1,00,000 transactions

Tools: MySQL

## Business Questions Answered

- Which months show the highest sales volume?
- What is Month over Month Growth?
- What is the total revenue generated?
- What is the average revenue per transaction?
- Which is the top selling product?
- Which are the low performing products?
- Which customers have the highest spending?
- Who were Unique Customers (Customer Retention)?
- What is the monthly revenue trend?
- Which countries contribute the most revenue?
- How does customer behavior differ by country?
- Which months have the highest sales?

## Technical Implementation
### Data Processing Pipeline

#### Data Import: 
Bulk loading of more than one lac rows in mysql workbench.
#### Data Cleaning: 
Handling missing values, duplicates, and cancellations. Standardizing the date, and CustomerID. And deleting unnecessary column.
#### Feature Engineering: 
Creating calculated fields (Total Price)
#### Analysis Execution: 
Complex SQL queries with CTEs, window functions

### Advanced SQL Techniques Used

Common Table Expressions (CTEs) for complex hierarchical queries
Window Functions (rank(), LAG()) for ranking and comparisons
Advanced Aggregations with GROUP BY and HAVING clauses
Date Functions for time-series analysis and seasonality detection

## Example Queries

- Top 3 Product Preferred in different months

``` sql
WITH monthly_product_sales AS (
    SELECT 
        monthname(InvoiceDate) AS month_name,
        StockCode,
        ANY_VALUE(Description) AS Description,
        SUM(Quantity) AS total_quantity
    FROM online_retail2
    GROUP BY month_name, StockCode
)
SELECT month_name, StockCode, Description, total_quantity
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY month_name ORDER BY total_quantity DESC) AS rank_num
    FROM monthly_product_sales
) ranked
WHERE rank_num <= 3
ORDER BY month_name, rank_num;
```

#### Result:

<img width="478" height="231" alt="image" src="https://github.com/user-attachments/assets/c734b597-0b4b-4b0f-9698-1050d4811dab" />

- How does customer behavior differ by country?

``` sql
with cte as
(
select Country, StockCode, Description ,sum(Quantity) as Quantity_Sold
from online_retail2
group by Country, StockCode, Description
), second_cte as
(
select *,
rank()over(partition by Country order by Quantity_Sold desc) as rank_num
from cte
)
select * 
from second_cte
where rank_num = 1;
```

#### Result

<img width="538" height="274" alt="image" src="https://github.com/user-attachments/assets/81ca3cea-408d-44b9-9053-00637ca4940d" />

- Which months show the highest sales volume?

``` sql
select monthname(InvoiceDate) as months, sum(Total_Price) as sales
from online_retail2
group by months
order by sales desc;
```

#### Result 

<img width="141" height="93" alt="image" src="https://github.com/user-attachments/assets/8ab88990-25f1-4e38-be65-cf182918ad73" />

## Key Insights

- 42% of revenue was generated in the month of 'March'
- The overall Average Order Value is approximately £453.
- 'PACK OF 12 PINK PAISLEY TISSUES' is top selling product with 13745 sold items.
- Top 10 customers are making 17.4% of total revenue.
- 23% of sales is done on the day of 'Wednesday'.

## Outcomes

This project demonstrates:
- Ability to work with large datasets in SQL.
- Skills in data cleaning, aggregation, and KPI building.
- Translating business questions into SQL queries.
- Business intelligence, and strategic decision-making in the retail industry.

## Contact
Author: Jia Menahil Rasheed

LinkedIn: [https://www.linkedin.com/in/jia-rasheed-b030962ba/]

GitHub: [https://github.com/Jia-Menahil]

#### ⭐ If you found this project helpful, please give it a star!








