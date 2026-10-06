-- Xom Data · 7-day moving average of revenue
-- Problem: https://xomdata.com/practice/hard-frame-001
-- Solved: 2026-10-06

select 
    date,
    amount as revenue,
    round(avg(amount)over(
        order by date asc
        rows between 6 preceding and current row
    ),2) as ma7
from daily_revenue
order by date asc
