-- Xom Data · Customer With the Widest Monthly Spread
-- Problem: https://xomdata.com/practice/medium-frequency-005
-- Solved: 2026-10-03

with active_months as (
    select 
        customer_id,
        count(distinct(substring(order_date,1,7))) as active_months,
        count(order_id) as total_orders 
    from orders
    group by 1
    having count(order_id) >= 1 
)
select * 
from active_months  
order by active_months desc, customer_id asc
