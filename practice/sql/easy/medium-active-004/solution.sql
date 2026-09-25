-- Xom Data · Who stayed loyal all quarter
-- Problem: https://xomdata.com/practice/medium-active-004
-- Solved: 2026-09-25

with month as (
    select 
        customer_id,    
        substring(order_date,1,7) as month
    from orders 
    where substring(order_date,1,7) in ('2024-01', '2024-02', '2024-03')
)
select 
    customer_id 
from month
group by 1
having count(distinct month)= 3
