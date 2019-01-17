select e.last_name 이름, d.department_name 부서명
from employees e
inner join departments d
on e.department_id like d.department_id;

select department_id 
from employees  
where last_name like 'Fay';

select department_name "페이 부서"
from departments
where department_id like '20';