-- Xom Data · Which channel produces loyal customers
-- Problem: https://xomdata.com/practice/medium-repeat-005
-- Solved: 2026-10-20

with s as (
    select 
        c.channel,
        count(distinct o.customer_id) as customers,
        count(o.order_id) as order_count
    from customers c
    join orders o on c.customer_id = o.customer_id
    group by 1 
)
    select 
        channel,
        customers,
        sum(case when order_count >= 3 then 1 else 0 end) as loyal_customers,
        round(sum(case when order_count >= 3 then 1 else 0 end) * 100.00/customers,2) as loyal_rate_pct
    from s 
    group by 1,2
    order by loyal_rate_pct desc,channel asc
