-- Xom Data · Splitting customers into five spend tiers
-- Problem: https://xomdata.com/practice/hard-monetary-001
-- Solved: 2026-10-16

select 
    customer_id,
    sum(amount) as total_spent,
    ntile(5)over(
        order by sum(amount) desc, customer_id 
    ) as spend_rank
from orders 
group by 1
order by spend_rank asc,customer_id
