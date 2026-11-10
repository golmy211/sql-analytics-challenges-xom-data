-- Xom Data · Users active 5+ consecutive days
-- Problem: https://xomdata.com/practice/nightmare-active-users-001
-- Solved: 2026-11-10

with s as (
    select 
        id,
        cast(login_date as date) - CAST(ROW_NUMBER()over(PARTITION BY id order by login_date asc) AS INTEGER)  as rank 
    from logins
),
f as (
    select
        id,
        rank,
        count(*) as streak
    from s
    group by 1,2
)
select 
    DISTINCT id
from f
where streak >= 5 
order by id
