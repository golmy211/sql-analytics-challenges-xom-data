-- Xom Data · Longest consecutive login streak
-- Problem: https://xomdata.com/practice/sql-nightmare-001
-- Solved: 2026-11-09

with s as(
    select 
        user_id,
        login_date,
        lag(login_date)over(partition by user_id ORDER BY login_date)as prev_date
    from logins
),
f as (
    select 
        user_id,
        cast(login_date as date) - cast(prev_date as date)as days_gap
    from s
)
select 
    user_id,
    count(case when days_gap is NULL or days_gap = 1 then 1 end) as max_streak
from f 
group by 1
order by 1
