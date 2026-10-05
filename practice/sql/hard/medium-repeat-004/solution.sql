-- Xom Data · Closing a second order within a month
-- Problem: https://xomdata.com/practice/medium-repeat-004
-- Solved: 2026-10-05

with rankk as (

    select 
        customer_id,
        order_date,
        row_number()over(
            partition by customer_id
            order by order_date, order_id
        ) as rn 
    from orders 

),
filtered as (
select 
    customer_id,
    max(case 
        when rn = 1 then order_date 
        end) as first_order_date,
    max(case 
        when rn = 2 then order_date 
        end) as second_order_date
from rankk
group by 1 
)

select 
    customer_id, 
    first_order_date,
    second_order_date,
    julianday(second_order_date) - julianday(first_order_date) as days_to_second 
from filtered
where julianday(second_order_date) - julianday(first_order_date) <= 30 
order by first_order_date , customer_id
