-- Xom Data · Transaction count and amount by month
-- Problem: https://xomdata.com/practice/medium-datefunction-045
-- Solved: 2026-09-23

select
    SUBSTRING(transaction_date,1,7) as month,
    count(id) as transaction_count,
    sum(amount) as total_amount,
    sum(amount) - lag(sum(amount))over(order by SUBSTRING(transaction_date,1,7)asc) as mom_delta
from transactions
group by 1 
order by month asc
