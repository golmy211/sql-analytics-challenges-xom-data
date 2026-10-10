-- Xom Data · Intake sequence per warehouse
-- Problem: https://xomdata.com/practice/medium-rownum-002
-- Solved: 2026-10-10

-- Write your SQL here
select 
    warehouse,
    row_number()over(
        partition by warehouse
        order by entry_date asc, product asc
    ) as entry_no,
    product,
    entry_date
from stock_entries
order by warehouse asc, entry_no asc
