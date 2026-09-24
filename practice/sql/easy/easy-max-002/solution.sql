-- Xom Data · Peak-hour electricity record
-- Problem: https://xomdata.com/practice/easy-max-002
-- Solved: 2026-09-24

-- Write your SQL here
select 
    MAX(kwh) as peak_load
from power_readings
where period = 'Peak'
