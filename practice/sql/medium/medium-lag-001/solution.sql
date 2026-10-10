-- Xom Data · Last month's revenue next to each month
-- Problem: https://xomdata.com/practice/medium-lag-001
-- Solved: 2026-10-10

-- Write your SQL here
 select 
    month,
    revenue,
    lag(revenue)over(
        order by month asc
    ) as prev_revenue
from monthly_revenue
order by month asc
