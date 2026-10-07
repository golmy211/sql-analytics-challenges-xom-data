-- Xom Data · Splitting customers into four spending tiers
-- Problem: https://xomdata.com/practice/medium-ntile-001
-- Solved: 2026-10-07

-- Write your SQL here
select 
    customer_name,
    total_spent,
    ntile(4)over(
        order by total_spent desc, customer_name asc
    ) as spend_quartile
from customer_spending
order by spend_quartile asc, total_spent desc, customer_name asc
