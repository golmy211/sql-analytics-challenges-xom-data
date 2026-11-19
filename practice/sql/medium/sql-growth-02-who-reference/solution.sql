-- Xom Data · Match WHO weight references
-- Problem: https://xomdata.com/practice/sql-growth-02-who-reference
-- Solved: 2026-11-19

select
    e.visit_id,
    e.age_days,
    e.sex_code,
    e.weight_kg,
    w.l,
    w.m,
    w.s,
    w.sd_neg_3,
    w.sd_neg_2,
    w.sd_pos_2,
    w.sd_pos_3
from eligible_visits e
left join who_weight_for_age_daily w
    on e.sex_code = w.sex_code
   and e.age_days = w.age_days
order by e.visit_id
