-- Xom Data · Does anyone return the following week
-- Problem: https://xomdata.com/practice/hard-retention-003
-- Solved: 2026-10-30

with s as (
    select 
        customer_id,
        order_date,
        round((cast(order_date as date) - cast('2024-01-01' as date))/7 + 1,0) as week_no
    from orders 
),
a as (

    select 
        distinct customer_id,
        min(week_no) as cohort_week
    from s
    group by 1
)
SELECT
    a.cohort_week,
    count(distinct a.customer_id) as cohort_size,
    count(distinct case when s.week_no = a.cohort_week + 1 then s.customer_id end) as retained_next_week
from a
join s on a.customer_id = s.customer_id
group by 1
