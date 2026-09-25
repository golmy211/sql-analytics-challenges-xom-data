-- Xom Data · Who showed up in two consecutive months
-- Problem: https://xomdata.com/practice/medium-active-002
-- Solved: 2026-09-25

with datee as( 
    select 
        distinct customer_id,
        substring(order_date,1,7) as month
    from orders 
    where substring(order_date,1,7) in ('2024-03','2024-04')
)
select
     customer_id
from datee
group by 1 
having count(distinct month) = 2
