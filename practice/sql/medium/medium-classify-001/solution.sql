-- Xom Data · Diamond, Gold, or regular member
-- Problem: https://xomdata.com/practice/medium-classify-001
-- Solved: 2026-09-25

select 
    customer_id,
    sum(amount) as total_spent,
    case
        when sum(amount) >= 10000000 then 'Diamond'
        when sum(amount) between 3000000 and 10000000 then 'Gold'
        else 'Member'
        end as tier
from orders 
group by 1
