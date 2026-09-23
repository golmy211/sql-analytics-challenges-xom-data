-- Xom Data · Countries our students come from
-- Problem: https://xomdata.com/practice/easy-distinct-008
-- Solved: 2026-09-23

-- Write your SQL here
select 
    count(distinct country) as num_countries
from students
