-- Xom Data · Who has spent past the five-million mark
-- Problem: https://xomdata.com/practice/medium-monetary-001
-- Solved: 2026-09-25

select
    customer_id,
    sum(amount) as total_spent,
    case 
        when sum(amount) >= 5000000 then 'VIP'
        else 'Standard'
        end as segment 
from orders 
group by 1 
order by 1
