-- Xom Data · Longest run of consecutive active months
-- Problem: https://xomdata.com/practice/hard-streak-001
-- Solved: 2026-11-05

  with s as (
    select 
        customer_id,
        TO_CHAR(CAST(order_date as DATE),'YYYY-MM') as month,
        CAST(TO_CHAR(cast(order_date as date),'YYYY') AS INTEGER) * 12 + CAST(TO_CHAR(cast(order_date as date),'MM') AS INTEGER) as cidx
    from orders 
  ),
  f as (
    select 
        customer_id,
        month,
        cidx - ROW_NUMBER()over(PARTITION BY customer_id order by cidx) as rank
    from s
  ),
  a as (
    SELECT 
        customer_id,
        rank,
        count(*) as streak
    from f
    group by 1,2
  )

  select 
    customer_id,
    MAX(streak) as longest_streak
from a
group by 1 
order by longest_streak desc, customer_id
