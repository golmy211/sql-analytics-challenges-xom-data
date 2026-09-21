-- Xom Data · Total number of bank accounts
-- Problem: https://xomdata.com/practice/easy-count-006
-- Solved: 2026-09-21

select
    count(id) as total_accounts
from accounts
