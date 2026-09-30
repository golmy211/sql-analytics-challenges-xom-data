-- Xom Data · Consultation revenue by doctor
-- Problem: https://xomdata.com/practice/medium-join-141
-- Solved: 2026-09-30

select 
    f.faculty_name,
    d.full_name as doctor_name,
    count(m.id) as visit_count,
    round(avg(m.visit_fee),0) as avg_exam_fee,
    sum(m.visit_fee) as total_exam_fee,
    rank()over(
        order by sum(m.visit_fee) desc
    ) as overall_rank,
    rank()over(
        partition by f.faculty_name
        order by sum(m.visit_fee) desc
    )as rank_in_faculty
from faculties f
left join doctors d on f.id = d.faculty_id
left join medical_visits m on d.id = m.doctor_id
group by 1,2
order by total_exam_fee desc, full_name asc
limit 15
