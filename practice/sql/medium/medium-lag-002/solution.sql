-- Xom Data · Change versus last month
-- Problem: https://xomdata.com/practice/medium-lag-002
-- Solved: 2026-10-10

-- Write your SQL here
select 
    month,
    revenue,
    revenue - lag(revenue)over(order by month asc) as mom_change 
from monthly_revenue
order by month asc
