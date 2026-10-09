-- Xom Data · Each expense's share of the fund
-- Problem: https://xomdata.com/practice/medium-winagg-006
-- Solved: 2026-10-09

select 
    expense_name,
    amount,
    round(100.00* amount/sum(amount)over(),2) as pct_of_total
from fund_expenses 
order by amount desc, expense_name
