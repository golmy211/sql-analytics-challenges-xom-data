-- Xom Data · Identify children under five
-- Problem: https://xomdata.com/practice/sql-growth-01-under-five-cohort
-- Solved: 2026-11-17

with s as(
    select 
        visit_id,
        patient_id,
        cast(admission_at as date) - birth_date as age_days
    from medical_visits
    where cast(admission_at as date) >= birth_date
    and cast(admission_at as date) < birth_date + INTERVAL '5 years'
)
select * from s order by visit_id
