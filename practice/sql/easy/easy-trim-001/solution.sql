-- Xom Data · Cleaning whitespace in the lead list
-- Problem: https://xomdata.com/practice/easy-trim-001
-- Solved: 2026-09-24

-- Write your SQL here
select 
    full_name,
    trim(full_name) as clean_name,
    phone
from leads
