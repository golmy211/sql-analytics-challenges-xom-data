-- Xom Data · Each device's next service date
-- Problem: https://xomdata.com/practice/medium-lead-001
-- Solved: 2026-10-10

-- Write your SQL here
select 
    device_code,
    service_date,
    lead(service_date)over(
        partition by device_code
        order by service_date asc 
    ) as next_service
from service_log
order by device_code asc, service_date asc
