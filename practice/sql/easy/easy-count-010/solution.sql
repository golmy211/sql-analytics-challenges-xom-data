-- Xom Data · Tickets still valid
-- Problem: https://xomdata.com/practice/easy-count-010
-- Solved: 2026-09-23

-- Write your SQL here
select 
     count(id) as valid_tickets 
from tickets 
where status = 'Valid'
