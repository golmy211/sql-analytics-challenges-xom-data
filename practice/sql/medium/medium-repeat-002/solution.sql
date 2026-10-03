-- Xom Data · What share of customers does the shop retain
-- Problem: https://xomdata.com/practice/medium-repeat-002
-- Solved: 2026-10-03

with total as (
    select 
    count(distinct customer_id) as total_customer
    from orders
),
customer as (
    select count(*) as customer
    from (
        select customer_id
        from orders
        group by customer_id
        having count(order_id) >=2
    )t
)
select 
   round(customer * 100.00 / total_customer, 2) as repeat_rate_pct 
from total join customer on true
