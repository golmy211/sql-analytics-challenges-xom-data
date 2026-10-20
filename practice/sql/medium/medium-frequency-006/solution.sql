-- Xom Data · Average Orders per Customer by Channel
-- Problem: https://xomdata.com/practice/medium-frequency-006
-- Solved: 2026-10-20

select 
    c.channel,
    count(distinct o.customer_id) as customers,
    count(o.order_id) as total_orders,
    round(count(o.order_id) * 1.00/count(distinct o.customer_id),2) as orders_per_customer
from customers c
join orders o on c.customer_id = o.customer_id
group by 1 
order by orders_per_customer desc, channel asc
