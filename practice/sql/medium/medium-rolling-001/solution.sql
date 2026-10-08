-- Xom Data · Three-month rolling average revenue
-- Problem: https://xomdata.com/practice/medium-rolling-001
-- Solved: 2026-10-07

-- Write your SQL here
select  
    month,
    revenue,
    round(avg(revenue)over(
        order by month asc
        rows between 2 preceding and current row
    ),2) as avg_3m
from shop_revenue 
order by month asc
