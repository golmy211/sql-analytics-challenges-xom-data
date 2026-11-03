-- Xom Data · D7 and D30 retention rate
-- Problem: https://xomdata.com/practice/hard-retention-001
-- Solved: 2026-11-03

with s as (
    SELECT
        count(distinct s.user_id) as total_users,
        count(distinct case when cast(a.active_date as date) BETWEEN cast(s.signup_date as date) + 1 AND cast(s.signup_date as date) + 7 then s.user_id end) as d7_retained,
        count(distinct case when cast(a.active_date as date) BETWEEN cast(s.signup_date as date) + 1 AND cast(s.signup_date as date) + 30 then s.user_id end) as d30_retained
    from signups s 
    full join activity a on s.user_id = a.user_id

)
select 
    total_users,
    d7_retained,
    coalesce(round(d7_retained * 100.00/NULLIF(total_users,0),2),0) as d7_rate,
    d30_retained,
    coalesce(round(d30_retained * 100.00/NULLIF(total_users,0),2),0) as d30_rate
from s
