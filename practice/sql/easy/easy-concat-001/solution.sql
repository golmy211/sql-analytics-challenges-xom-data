-- Xom Data · Names printed on staff badges
-- Problem: https://xomdata.com/practice/easy-concat-001
-- Solved: 2026-09-23

-- Write your SQL here
select 
    first_name,
    last_name,
    first_name || ' ' || last_name as badge_name

from staff
