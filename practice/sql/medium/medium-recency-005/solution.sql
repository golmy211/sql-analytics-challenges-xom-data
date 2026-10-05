-- Xom Data · Which Channel Is Keeping Its Warmth
-- Problem: https://xomdata.com/practice/medium-recency-005
-- Solved: 2026-10-05

with days_silent as (
    select
        c.customer_id,
        c.channel,
        julianday('2024-06-30') - julianday(max(o.order_date)) as days_silent
    from customers c
    join orders o on c.customer_id = o.customer_id
    group by c.customer_id, c.channel
)
select
    channel,
    count(*) as customers,
    round(avg(days_silent), 2) as avg_days_silent
from days_silent
group by channel
order by avg_days_silent asc, channel asc
