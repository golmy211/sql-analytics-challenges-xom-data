-- Xom Data · Last month per branch
-- Problem: https://xomdata.com/practice/medium-lag-003
-- Solved: 2026-10-10

-- Write your SQL here
select 
    branch,
    month,
    revenue,
    lag(revenue)over(
        partition by branch
        order by month asc 
    ) as prev_revenue
from branch_revenue
order by branch asc, month asc
