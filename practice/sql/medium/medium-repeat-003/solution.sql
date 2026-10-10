-- Xom Data · Which channel grows loyal customers
-- Problem: https://xomdata.com/practice/medium-repeat-003
-- Solved: 2026-10-10

with customer_orders as (
    select
        c.customer_id,
        c.channel,
        count(o.order_id) as order_count
    from customers c
    join orders o on c.customer_id = o.customer_id
    group by c.customer_id, c.channel
)
select
    channel,
    count(*) as total_customers,
    count(*) filter (where order_count >= 2) as repeat_customers,
    round(count(*) filter (where order_count >= 2) * 100.0 / count(*), 2) as repeat_rate_pct
from customer_orders
group by channel
order by channel
