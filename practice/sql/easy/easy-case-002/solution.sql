-- Xom Data · Sizing parcels by weight
-- Problem: https://xomdata.com/practice/easy-case-002
-- Solved: 2026-09-21

-- Write your SQL here
select 
    parcel_code,
    weight_kg,
    case 
        when weight_kg < 5 then 'Small'
        when weight_kg between 5 and 20 then 'Medium'
        when weight_kg > 20 then 'Large'
        end as size_label

from parcels
