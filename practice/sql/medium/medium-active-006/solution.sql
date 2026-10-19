-- Xom Data · Head-to-head customer count across quarters
-- Problem: https://xomdata.com/practice/medium-active-006
-- Solved: 2026-10-19

with s as(
    select 
        customer_id,
        substring(order_date,1,4) || '-Q'|| (((substring(order_date,6,2)::int - 1) / 3 + 1)::text) as quarter
    from orders
),
agg as (
    select 
        quarter,
        count(distinct customer_id) as active_customers
    from s 
    group by quarter 
)

    select 
        quarter,
        active_customers,
        active_customers - lag(active_customers)over(order by quarter) as change_vs_prev
    from agg
    order by quarter asc
