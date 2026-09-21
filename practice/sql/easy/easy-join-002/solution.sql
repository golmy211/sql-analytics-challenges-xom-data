-- Xom Data · Parcels bound for Denver
-- Problem: https://xomdata.com/practice/easy-join-002
-- Solved: 2026-09-21

-- Write your SQL here
select 
    p.tracking_code,
    r.recipient_name
from recipients r
join parcels p on r.id = p.recipient_id 
where r.city = 'Denver'
