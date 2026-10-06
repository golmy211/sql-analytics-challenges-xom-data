-- Xom Data · Each Channel's Most Recent Face
-- Problem: https://xomdata.com/practice/medium-firstlast-002
-- Solved: 2026-10-06

with ranked as(
select 
    c.customer_id,
    c.channel,
    order_date,
    row_number()over(
        partition by c.channel
        order by o.order_date desc
    ) as rn
from customers c 
join orders o on c.customer_id = o.customer_id
)

select 
    channel,
    customer_id,
    order_date as last_order_date
from ranked
where rn = 1
order by channel asc
