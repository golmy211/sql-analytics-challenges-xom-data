-- Xom Data · Each customer's latest contact number
-- Problem: https://xomdata.com/practice/medium-dedup-001
-- Solved: 2026-10-03

-- Write your SQL here
with update_phone as (    
    select 
        customer_name,
        phone,
        first_value(updated_date) over(
            partition by customer_name
            order by updated_date desc 
        ) as updated_date,
        row_number()over(
            partition by customer_name
            order by updated_date desc
        ) as rank
    from contact_updates 
 )
 select 
    customer_name,
    phone,
    updated_date
from update_phone
where rank = 1
