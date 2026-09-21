-- Xom Data · Ticket statuses guests can read
-- Problem: https://xomdata.com/practice/easy-join-005
-- Solved: 2026-09-21

select 
    t.ticket_code,
    s.status_name
from statuses s 
right join tickets t on s.code = t.status_code
