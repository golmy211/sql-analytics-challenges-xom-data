-- Xom Data · Consecutive weekly streak with no breaks
-- Problem: https://xomdata.com/practice/hard-streak-003
-- Solved: 2026-10-31

with s as (
    select 
        customer_id,
        (abs(cast('2024-01-01' as date) - cast(order_date as date))/ 7) + 1 as week_num
    from orders 
),
gap as (
    select 
        customer_id,
        week_num - ROW_NUMBER()over(partition by customer_id order by week_num) as grp
    from s 
),
g as (
    select 
        customer_id,
        grp,
        count(*) as streak
    from gap 
    group by 1,2
)

select 
    customer_id,
    max(streak) as longest_week_streak
from g 
GROUP BY 1  
order by longest_week_streak desc, customer_id
