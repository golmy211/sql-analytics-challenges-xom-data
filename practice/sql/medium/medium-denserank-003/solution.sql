-- Xom Data · Spending tiers of loyal customers
-- Problem: https://xomdata.com/practice/medium-denserank-003
-- Solved: 2026-10-03

-- Write your SQL here
select 
    customer_name,
    sum(amount) as total_spent,
    dense_rank()over(
        order by sum(amount)desc
    ) as spend_tier 
from purchases 
group by 1
order by spend_tier asc, customer_name asc
