-- Xom Data · Revenue by product category
-- Problem: https://xomdata.com/practice/easy-groupby-002
-- Solved: 2026-09-23

-- Write your SQL here
select 
    category,
    sum(amount) as total_revenue
from sales
group by 1
order by 1 asc
