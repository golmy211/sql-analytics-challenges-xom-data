-- Xom Data · How long before a customer decides to come back a second time
-- Problem: https://xomdata.com/practice/medium-gap-002
-- Solved: 2026-10-16

with sub as ( 

    select  
        customer_id,
        order_date,
        row_number()over(
            partition by customer_id
            order by order_date asc ,order_id asc
        ) as rn 
    from orders

),
s as (
    select  
        customer_id,
        max(case 
            when rn = 1 then order_date end)as first_order_date,
        max(case
            when rn =2 then order_date end) as second_order_date
    from sub 
    where rn <= 2 
    group by 1 
) 

select 
    customer_id,
    first_order_date,
    second_order_date,
    abs(first_order_date::date - second_order_date::date) as days_between
from s 
where second_order_date is not null 
order by days_between asc, customer_id
