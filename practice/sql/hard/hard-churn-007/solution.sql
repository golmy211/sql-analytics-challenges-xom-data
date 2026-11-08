-- Xom Data · Survival probability past three milestones
-- Problem: https://xomdata.com/practice/hard-churn-007
-- Solved: 2026-11-08

with s as (
    select 
        customer_id,
        TO_CHAR(cast(min(order_date) as date),'YYYY-MM') as cohort_month,
        CAST(TO_CHAR(cast(min(order_date) as date),'YYYY')AS INTEGER) * 12 + CAST(TO_CHAR(cast(min(order_date) as date),'MM')AS INTEGER) as fidx 
    from orders
    group by 1
),
f as (
    select 
        s.customer_id,
        s.cohort_month,
        s.fidx,
        CAST(to_char(cast(o.order_date as date),'YYYY')AS INTEGER) * 12 +  CAST(to_char(cast(o.order_date as date),'MM')AS INTEGER) as cidx 
    from s
    join orders o 
    on s.customer_id = o.customer_id
),
a as (
    select 
        cohort_month,
        count(DISTINCT customer_id) as cohort_size,
        count(distinct case when cidx >= fidx + 1 then customer_id end) as surv_30,
        count(distinct case when cidx >= fidx + 2 then customer_id end) as surv_60,
        count(distinct case when cidx >= fidx + 3 then customer_id end) as surv_90
    from f 
    group by 1
)


select 
    cohort_month,
    cohort_size,
    round(surv_30 * 100.0/cohort_size,2) as surv_30_pct,
    round(surv_60 * 100.0/cohort_size,2) as surv_60_pct,
    round(surv_90 * 100.0/cohort_size,2) as surv_90_pct
 from a
 order by cohort_month
