select e.last_name �̸�, d.department_name �μ���
from employees e
inner join departments d
on e.department_id like d.department_id;

select department_id 
from employees  
where last_name like 'Fay';

select department_name "���� �μ�"
from departments
where department_id like '20';