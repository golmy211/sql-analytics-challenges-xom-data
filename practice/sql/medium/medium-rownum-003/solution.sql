-- Xom Data · Visit number within each day
-- Problem: https://xomdata.com/practice/medium-rownum-003
-- Solved: 2026-10-03

-- Write your SQL here
select 
    checkin_date,
    row_number()over(
        partition by checkin_date
        order by checkin_time asc, member_name asc
    )as visit_no,
    member_name,
    checkin_time
from checkins 
order by checkin_date asc , visit_no asc
