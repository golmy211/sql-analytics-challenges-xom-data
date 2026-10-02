-- Xom Data · This invoice's share of the client's spend
-- Problem: https://xomdata.com/practice/medium-winjoin-005
-- Solved: 2026-10-02

-- Write your SQL here
with total_expense as(
select 
    c.id,
    c.client_name,
    sum(i.amount) as total_expense 
from clients c
join invoices i on c.id = i.client_id
group by 1,2
)
select 
    e.client_name,
    i.invoice_code,
    i.amount,
    round(i.amount * 100.00/e.total_expense,2) as pct_of_client
from total_expense e
join invoices i on e.id = i.client_id
order by client_name asc, amount desc, invoice_code asc
