-- Xom Data · Normalizing emails before matching
-- Problem: https://xomdata.com/practice/easy-lower-001
-- Solved: 2026-09-24

-- Write your SQL here
select
    email,
    lower(email) as normalized_email
from subscribers
