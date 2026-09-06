-- Xom Data · Classify student academic performance
-- Problem: https://xomdata.com/practice/medium-case-124
-- Solved: 2026-09-06

select
        s.full_name,
        s.student_code,
        round(avg(sc.final_score),2) as avg_score,
        case 
            when coalesce(avg(sc.final_score),0) >= 9 then 'Excellent'
            when coalesce(avg(sc.final_score),0) between 8 and 9 then 'Good'
            when coalesce(avg(sc.final_score),0) between 7 and 8 then 'Fair'
            when coalesce(avg(sc.final_score),0) between 5 and 7 then 'Average'
            else 'Poor'
            end as grade,
        dense_rank()over(
            order by coalesce(avg(sc.final_score),0) desc
        ) as class_rank
from students s
left join scores sc on s.id = sc.student_id
group by 1,2
order by avg_score desc,s.id asc
limit 20
