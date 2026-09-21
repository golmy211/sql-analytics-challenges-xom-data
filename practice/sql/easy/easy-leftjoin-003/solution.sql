-- Xom Data · Booking count per branch
-- Problem: https://xomdata.com/practice/easy-leftjoin-003
-- Solved: 2026-09-21

-- Write your SQL here
select
    branches.branch_name,
    coalesce(count(bookings.id),0) as num_bookings
from branches 
left join bookings on branches.id = bookings.branch_id
group by 1
order by branches.branch_name asc
