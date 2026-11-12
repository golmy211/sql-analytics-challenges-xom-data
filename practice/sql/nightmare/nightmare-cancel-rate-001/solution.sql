-- Xom Data · Daily trip cancellation rate (unbanned users/drivers only)
-- Problem: https://xomdata.com/practice/nightmare-cancel-rate-001
-- Solved: 2026-11-12

with s as (
    select 
        distinct t.request_at,
        count(case when status like 'cancelled%' then id end)over(PARTITION BY request_at) as cancel_counts,
        count(*)over(PARTITION BY request_at) as total_count
    from trips t 
    join users u on t.client_id = u.users_id and u.banned = 'No'
    join users d on t.driver_id = d.users_id and d.banned = 'No'
    where request_at BETWEEN '2024-01-01' AND '2024-01-03'
)
select 
    request_at as Day,
    round(cancel_counts * 1.0/total_count,2) as Cancellation_Rate    
from s
order by Day
