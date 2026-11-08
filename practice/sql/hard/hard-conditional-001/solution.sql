-- Xom Data · Cumulative revenue from successful transactions only
-- Problem: https://xomdata.com/practice/hard-conditional-001
-- Solved: 2026-11-08

with s as (
    select
        id,
        date,
        status,
        amount,
        sum(case when status = 'success' then amount end)over(order by date,status,id 
                                                            rows BETWEEN  UNBOUNDED PRECEDING AND CURRENT ROW) as running_success_total
    from transactions
)

select 
    date,
    status,
    amount,
    COALESCE(running_success_total,0) AS running_success_total
from s
order by date,status,id
