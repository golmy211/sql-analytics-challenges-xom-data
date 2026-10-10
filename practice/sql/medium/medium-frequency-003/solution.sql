-- Xom Data · Each Customer's Golden Month
-- Problem: https://xomdata.com/practice/medium-frequency-003
-- Solved: 2026-10-10

with order_count as(
select 
    customer_id,
    strftime('%Y-%m',order_date) as month,
    count(*) as order_count 
from orders
group by 1,2
),
s as(
select 
    customer_id,
    month as best_month,
    order_count,
    row_number()over(
        partition by customer_id
        order by order_count desc
    ) as rn
from order_count
)
select 
    customer_id,
    best_month,
    order_count as orders_in_month
from s
where rn = 1
order by customer_id asc
