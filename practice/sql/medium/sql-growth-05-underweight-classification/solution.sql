-- Xom Data · Classify underweight status
-- Problem: https://xomdata.com/practice/sql-growth-05-underweight-classification
-- Solved: 2026-11-18

with s as (
    select 
        visit_id,
        case 
            when round(adjusted_z,3) < -6.000 or adjusted_z > 5 then NULL else round(adjusted_z,3) end as weight_for_age_z,
    
        case 
            when adjusted_z < -6 or adjusted_z > 5 or adjusted_z is NULL then 'INSUFFICIENT_DATA'
            when adjusted_z >= -6 and adjusted_z < -3 then 'SEVERE'
            when adjusted_z >= -3 and adjusted_z < -2 then 'MODERATE'
            else 'NOT_UNDERWEIGHT'
            end as underweight_class
        from visit_zscores
)
SELECT * from s ORDER BY visit_id
