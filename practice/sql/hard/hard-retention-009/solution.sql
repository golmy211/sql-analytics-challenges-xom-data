-- Xom Data · Which channel brings in the most durable customers
-- Problem: https://xomdata.com/practice/hard-retention-009
-- Solved: 2026-10-25

with first_orders as (
    select
        c.channel,
        o.customer_id,
        date_trunc('month', min(o.order_date::date)) as first_month
    from customers c
    join orders o on c.customer_id = o.customer_id
    group by c.channel, o.customer_id
),
flagged as (
    select
        f.channel,
        f.customer_id,
        exists (
            select 1
            from orders o
            where o.customer_id = f.customer_id
              and date_trunc('month', o.order_date::date)
                  = f.first_month + interval '1 month'
        ) as is_retained
    from first_orders f
)
select
    channel,
    count(*) as cohort_customers,
    count(*) filter (where is_retained) as retained,
    round(100.0 * count(*) filter (where is_retained) / count(*), 2) as retention_pct
from flagged
group by channel
order by retention_pct desc, channel;
