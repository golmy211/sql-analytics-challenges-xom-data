-- Xom Data · Records with a contact number
-- Problem: https://xomdata.com/practice/easy-isnull-003
-- Solved: 2026-09-21

-- Write your SQL here
select 
    patient_name,
    phone 
from patients 
where phone is not null
