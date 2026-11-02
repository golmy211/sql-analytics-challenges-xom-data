-- Xom Data · A complete six-month retention matrix
-- Problem: https://xomdata.com/practice/hard-cohort-005
-- Solved: 2026-11-02

with s as (
    select 
        customer_id,
        min(order_date) as cohort_month
    from orders 
    group by 1
),
f as (
    select 
        s.customer_id,
        TO_CHAR(cast(s.cohort_month as date),'YYYY-MM') as cohort_month,
        CAST(TO_CHAR(cast(s.cohort_month as date),'YYYY') AS INTEGER) * 12 + CAST(TO_CHAR(cast(s.cohort_month as date),'MM') AS INTEGER) AS fidx,
        CAST(TO_CHAR(cast(o.order_date as date),'YYYY') AS INTEGER) * 12 + CAST(TO_CHAR(cast(o.order_date as date),'MM') AS INTEGER) AS cidx
    from s 
    join orders o on s.customer_id = o.customer_id
),
ag as (
    select 
        cohort_month,
        count(distinct customer_id) as cohort_size,
        count(distinct case when cidx = fidx then customer_id end) as m0, 
        count(distinct case when cidx = fidx + 1 then customer_id end) as m1,
        count(distinct case when cidx = fidx + 2 then customer_id end) as m2,
        count(distinct case when cidx = fidx + 3 then customer_id end) as m3,
        count(distinct case when cidx = fidx + 4 then customer_id end) as m4,
        count(distinct case when cidx = fidx + 5 then customer_id end) as m5
    from f 
    group by cohort_month
)
    select 
        cohort_month,
        cohort_size,
        round(m0 * 100.00/cohort_size,2) as m0,
        round(m1 * 100.00/cohort_size,2) as m1,
        round(m2 * 100.00/cohort_size,2) as m2,
        round(m3 * 100.00/cohort_size,2) as m3,
        round(m4 * 100.00/cohort_size,2) as m4,
        round(m5 * 100.00/cohort_size,2) as m5
    from ag 
    order by cohort_month
