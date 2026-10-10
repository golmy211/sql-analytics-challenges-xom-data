-- Xom Data · The month that exploded with new customers
-- Problem: https://xomdata.com/practice/medium-active-003
-- Solved: 2026-10-10

with order_date as (

select 
    customer_id,
    min(order_date) as first_order_date 
from orders 
group by 1 

),
monthly as (
    select 
        substring(first_order_date,1,7) as month,
        count(*) as new_customers
    from order_date
    group by 1
)
select 
    month,
    new_customers
from monthly 
order by new_customers desc
limit 1
