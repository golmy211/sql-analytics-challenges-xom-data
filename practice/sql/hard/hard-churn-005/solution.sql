-- Xom Data · Monthly lifecycle log for each customer
-- Problem: https://xomdata.com/practice/hard-churn-005
-- Solved: 2026-11-05

with s as(
    SELECT
        distinct customer_id,
        to_char(cast(order_date as date),'YYYY-MM') as month,
        cast(to_char(cast(order_date as date),'YYYY')as integer) * 12 + cast(to_char(cast(order_date as date),'MM')as integer) as cidx
    from orders  
),
f as (
    select 
        customer_id,
        month,
        cidx,
        lag(cidx)over(PARTITION BY customer_id order by cidx) as fidx
    from s 
)

select 
    month,
    customer_id,
    case when fidx is NULL then 'new'
         when cidx = fidx + 1 then 'retained'
         else 'resurrected'
        end as lifecycle
from f  
order by month, customer_id
