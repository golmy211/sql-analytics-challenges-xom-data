-- Xom Data · 3-month consecutive disbursement rate by department
-- Problem: https://xomdata.com/practice/sql-nightmare-003
-- Solved: 2026-11-08

with s as (
    select 
        dept,
        month,
        sum(budget)over(partition by dept order by month
                        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as roll3_budget,
        sum(actual)over(partition by dept order by month
                        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as roll3_actual

    from budgets 
)
    select 
        *,
        round(roll3_actual * 100.0/roll3_budget,2) as utilization_pct
    
    from s
    order by dept,month
