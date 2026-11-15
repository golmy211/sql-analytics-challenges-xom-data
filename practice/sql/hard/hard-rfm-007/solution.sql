-- Xom Data · Customer momentum: trending up or down between two seasons
-- Problem: https://xomdata.com/practice/hard-rfm-007
-- Solved: 2026-11-15

with s as (
    select 
        customer_id,
        count(case when order_date between '2024-01-01' and '2024-03-31' then order_id end) as p1_orders,
        count(case when order_date between '2024-04-01' and '2024-06-30' then order_id end) as p2_orders
    from orders 
    group by 1 
),
f as (
    select 
        customer_id,
        p1_orders,
        p2_orders,
        case 
            when p1_orders = 0 and p2_orders > 0 then 'new'
            when p1_orders > 0 and p2_orders = 0 then 'lost'
            when p2_orders - p1_orders >= 1 then 'up'
            when p1_orders - p2_orders >= 1 then 'down'
            else 'flat'
            end as trend
        from s 

)
select * 
from f
where p1_orders >= 1 or p2_orders >= 1
