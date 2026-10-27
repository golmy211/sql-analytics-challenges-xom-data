-- Xom Data · Retention rate by signup-month cohort
-- Problem: https://xomdata.com/practice/hard-cohort-001
-- Solved: 2026-10-27

select 
    substring(s.signup_date,1,7) as signup_month,
    substring(a.active_date,1,7) as active_month,
    count(distinct a.user_id) as n_active

from signups s 
join activity a on s.user_id = a.user_id
where  substring(a.active_date,1,7) >= substring(s.signup_date,1,7)
group by 1,2
order by signup_month, active_month
