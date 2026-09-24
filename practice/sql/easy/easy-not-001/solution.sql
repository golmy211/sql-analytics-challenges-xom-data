-- Xom Data · Devices ready for dispatch
-- Problem: https://xomdata.com/practice/easy-not-001
-- Solved: 2026-09-24

-- Write your SQL here
 select
    device_code,
    status
 from devices 
 where not status = 'Maintenance'
