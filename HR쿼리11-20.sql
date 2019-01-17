-- Employees ���̺�
--[ employee_id = ��� ] [ first_name = �̸� ] 
--[ last_name = �� ] [ email = �̸��� ] 
--[ phone_number = ��ȭ��ȣ ] [ hire_date = �Ի��� ]
--[ job_id = �����ڵ� ] [ salary = �޿�]
--[ commission_pct = Ŀ�̼Ǻ��� ] [ manager_id = �����̵�]
--[ department_id = �μ��ڵ�]

-- *******
-- ����011. 
-- Ŀ�̼��� ���� ���ϴ� ������ �̸�,�����ڵ�,�޿�,Ŀ�̼Ǻ����� ��ȸ
-- *******
select first_name, job_id, salary, commission_pct 
from Employees 
where commission_pct is null;

-- *******
-- ����012. 
-- ����� 110,120,130�� ����� ���, ��, �̸� ��ȸ
-- *******
select employee_id, last_name, first_name
from Employees
where employee_id in('110', '120', '130');

-- *******
-- ����013. 
-- �μ��ڵ�� ��������, �޿��� ������������ 
-- �μ��ڵ�, �޿�, ���, �̸�, �� ����
-- �������� 0,1,2 ... �������� 9,8,7...
-- ******
select department_id, salary, employee_id, first_name, last_name
from Employees 
order by department_id asc, salary desc;

-- *******
-- ����014. 
-- �̸��� am �̶� ���ڰ� ���Ե� ������ ���,�̸�, ��
-- *******
select employee_id, first_name, last_name
from Employees
where first_name like '%am%';

-- *******
-- ����015. 
-- �̸��Ͽ� 'GG' �� 'KK'�δܾ� �� �ϳ��� ���ԵǾ ��ȸ
-- ��, ��ҹ��� ������
-- *******
select *
from Employees
where email like '%GG%' or email like '%KK%';

-- *******
-- ����016. 
-- �̸����ּҰ� A �� �������� �ʴ� �̸��� ����
-- *******
select *
from Employees
where email not in('A%');

-- *******
-- ����017.
-- ���� �ι�°,����° ���ڰ� ���ÿ� e �� ������ �̸�, ��
-- *******
select *
from Employees
where last_name like '_ee%';

-- *******
-- ����018
-- �����ӱ��� 10000�� �̻��� ������ �� ������ ǥ���Ѵ�
-- *******
SELECT *
from jobs
where min_salary >= 10000;

-- *******************
-- [����19]
-- 2002����� 2005����� 
-- ������ ������ �̸��� ���� ���ڸ� ǥ���Ѵ�.
-- *******************
select first_name, hire_date
from employees
where hire_date 
between to_date('2002/01/01') and to_date('2005/12/31')
order by hire_date asc;

-- *******************
-- [����020]
-- IT Programmer �Ǵ� Sales Man�� 
-- ������ �̸�, �Ի���, �����ڵ� ǥ��.
-- ******************* 
select first_name �̸�, HIRE_DATE �Ի���, JOB_ID "�����ڵ�"
from employees
where job_id like 'IT_PROG' or job_id like 'SA_MAN';


