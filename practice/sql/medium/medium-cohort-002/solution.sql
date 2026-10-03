-- Xom Data · Opening order or returning order
-- Problem: https://xomdata.com/practice/medium-cohort-002
-- Solved: 2026-10-03

-- Write your SQL here
with first_order as(
select
    customer_name,
    order_date,
    amount,
    first_value(order_date)over(
        partition by customer_name
        order by order_date asc
    )as first_order 
from orders 
order by customer_name asc 
)
select 
    customer_name,
    order_date,
    amount,
    case 
        when order_date = first_order then 'New'
        else 'Returning'
        end as order_type
from first_order
order by customer_name asc, order_date asc
