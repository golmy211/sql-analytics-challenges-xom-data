-- Xom Data · Balance after each transaction
-- Problem: https://xomdata.com/practice/medium-runtotal-003
-- Solved: 2026-10-06

-- Write your SQL here
select 
    txn_date,
    amount,
    sum(amount)over(
        order by txn_date asc 
    ) as balance
from transactions
order by txn_date asc
