-- Xom Data · Branch code from the invoice number
-- Problem: https://xomdata.com/practice/easy-substr-001
-- Solved: 2026-09-24

-- Write your SQL here
select
    invoice_code,
    substring(invoice_code,1,3) as branch_code
from invoices
