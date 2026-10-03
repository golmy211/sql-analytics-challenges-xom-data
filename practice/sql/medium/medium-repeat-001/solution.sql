-- Xom Data · One-time buyers vs. repeat customers
-- Problem: https://xomdata.com/practice/medium-repeat-001
-- Solved: 2026-10-03

with total as (
    select 
        customer_id,
        count(order_id) as order_count
    from orders 
    group by 1
)
select 
    case 
        when order_count = 1 then 'one-time'
        else 'repeat'
        end as customer_type,
    count(*) as customer_count
from total 
group by 1
