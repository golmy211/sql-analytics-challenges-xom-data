-- Xom Data · Apartments matching the client's criteria
-- Problem: https://xomdata.com/practice/easy-andor-001
-- Solved: 2026-09-23

-- Write your SQL here
select 
    listing_code,
    district,
    monthly_rent 
from apartments 
where district in ('Brookline','District 3')
    and monthly_rent <= 9000000
