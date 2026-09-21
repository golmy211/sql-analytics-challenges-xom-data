-- Xom Data · Display names on profile pages
-- Problem: https://xomdata.com/practice/easy-coalesce-001
-- Solved: 2026-09-21

-- Write your SQL here
select 
    real_name,
    nickname,
    case 
        when nickname is null then real_name
        else nickname
        end as display_name
from profiles
