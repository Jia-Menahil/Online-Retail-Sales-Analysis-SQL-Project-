-- Sales Performance and trends

-- Which months show the highest sales volume? 

select min(InvoiceDate), max(InvoiceDate)
from online_retail2;

select month(InvoiceDate) as months, sum(Total_Price) as sales
from online_retail2
group by months
order by sales desc; -- March showed highest sales (42% of sales)

select month(InvoiceDate) as months, count(InvoiceNo) as Total_orders
from online_retail2
group by months
order by Total_orders desc;

-- Month over Month Growth

WITH monthly_data AS (
    SELECT 
        MONTH(InvoiceDate) AS month,
        SUM(Total_Price) AS monthly_revenue,
        COUNT(DISTINCT CustomerID) AS monthly_customers
    FROM online_retail2
    GROUP BY MONTH(InvoiceDate)
)
SELECT * ,
    LAG(monthly_revenue) OVER (ORDER BY month) AS prev_month_revenue,
    ROUND(
        ((monthly_revenue - LAG(monthly_revenue) OVER (ORDER BY month)) /
          LAG(monthly_revenue) OVER (ORDER BY month)) * 100,
        2
    ) AS revenue_growth_rate
FROM monthly_data
ORDER BY month;


-- Customer Analysis

-- Top Customers
 
select CustomerID, count(InvoiceNo) as Total_orders, sum(Total_Price) as Total_spending
from online_retail2
group by CustomerID
order by Total_spending desc
limit 10;
 
--  Unique Customers (Customer Retention)

with cte as
(
select CustomerID, count(InvoiceNo) as orders
from online_retail2
group by CustomerID
order by orders desc
) select count(CustomerID)
from cte;


















