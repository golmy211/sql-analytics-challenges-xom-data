-- Xom Data · Monthly income and expense report
-- Problem: https://xomdata.com/practice/medium-groupby-080
-- Solved: 2026-09-30

with balance as(
    select 
        substring(transaction_date,1,7) as month,
        coalesce(sum(case when type = 'Income' then amount end),0) as total_income,
        coalesce(sum(case when type = 'Expense' then amount end),0) as total_expense
from transactions
group by 1 
)
select  
    month,
    total_income,
    total_expense,
    total_income - total_expense as balance,
    sum(total_income - total_expense)over(
        order by month asc 
        rows between unbounded preceding and current row
    ) as cumulative_balance,
    case 
        when total_income > total_expense then 'Surplus'
        when total_income < total_expense then 'Deficit'
        else 'Balanced'
        end as status
from balance 
order by month asc
