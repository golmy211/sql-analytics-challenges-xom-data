-- Xom Data · Normalize codes for label printing
-- Problem: https://xomdata.com/practice/easy-string-001
-- Solved: 2026-09-24

-- Write your SQL here
select 
    sku,
    UPPER(sku) as label_code
from inventory
