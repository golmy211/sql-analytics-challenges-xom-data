-- Xom Data · Users who never took a ride
-- Problem: https://xomdata.com/practice/easy-leftjoin-001
-- Solved: 2026-09-21

-- Write your SQL here
select 
    u.user_name,
    u.joined_date
from users u
where not exists (
    select 1 
    from rides r
    where u.id = r.user_id
)
