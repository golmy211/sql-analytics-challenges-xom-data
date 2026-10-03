-- Xom Data · Class fund running total by day
-- Problem: https://xomdata.com/practice/medium-runtotal-001
-- Solved: 2026-10-03

-- Write your SQL here
select 
    collect_date,
    amount,
    sum(amount)over(
        order by collect_date asc
        rows between unbounded preceding and current row
    ) as running_total
from fund_log
order by collect_date asc
