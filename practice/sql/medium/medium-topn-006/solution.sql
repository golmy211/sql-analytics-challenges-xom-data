-- Xom Data · Valedictorian, salutatorian, and the score gap
-- Problem: https://xomdata.com/practice/medium-topn-006
-- Solved: 2026-10-02

-- Write your SQL here
with chancellor as (
    select 
        id,
        student_name,
        class_name,
        score,
        row_number()over(
            partition by class_name
            order by score desc, student_name asc 
        ) as position
    from students 
),
top_score as(
    select 
        id,
        class_name,
        max(score)over(
            partition by class_name 
        ) as top_score
    from students 
)
select 
    c.class_name,
    c.position,
    c.student_name,
    c.score,
    t.top_score - c.score as behind_top
from chancellor c
left join top_score t on c.id = t.id
where c.position <= 2 
order by class_name asc, position asc
