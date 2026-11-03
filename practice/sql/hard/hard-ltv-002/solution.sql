-- Xom Data · Cumulative revenue by cohort age
-- Problem: https://xomdata.com/practice/hard-ltv-002
-- Solved: 2026-11-03

with s as (
    select 
        customer_id,
        min(order_date) as first_date,
        CAST(TO_CHAR(CAST(min(order_date) as date),'YYYY') AS INTEGER)* 12 + CAST(TO_CHAR(CAST(min(order_date) as date),'MM') AS INTEGER) as fidx
    from orders 
    group by 1
), 
f as (
    select
        TO_CHAR(cast(s.first_date as date),'YYYY-MM') as cohort_month,
        s.fidx,
        CAST(TO_CHAR(CAST(o.order_date as date),'YYYY') AS INTEGER)* 12 + CAST(TO_CHAR(CAST(o.order_date as date),'MM') AS INTEGER) as cidx,
        o.amount
    from s
    join orders o on s.customer_id = o.customer_id

),
a as(
    select 
        cohort_month,
        case when cidx = fidx then 0 
            when cidx = fidx + 1 then 1 
            else 2 
            end as month_age,
        sum(amount) as revenue
    from f
    group by 1,2
) 
    select 
        cohort_month,
        month_age,
        revenue,
        sum(revenue)over(
            PARTITION BY cohort_month
            order by month_age
        ) as cumulative_revenue
    from a
    order by cohort_month, month_age
