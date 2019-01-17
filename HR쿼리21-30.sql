-- *******************
-- [����021]
-- JOB_TITLE �� "Programmer" �Ǵ� "Sales Manager"�� 
-- ������ �̸�, �Ի���, ������ ǥ��.
-- ������ �̸��� ������������ �����Ͻÿ�
-- *******************
SELECT 
    E.FIRST_NAME, 
    E.HIRE_DATE, 
    J.JOB_ID, 
    J.JOB_TITLE
FROM EMPLOYEES E
    INNER JOIN JOBS J
    ON E.JOB_ID LIKE J.JOB_ID
WHERE JOB_TITLE IN('Sales Manager','Programmer')
ORDER BY FIRST_NAME;

-- *******************
-- [����022]
-- �μ��� �� �������̸� ǥ��
-- (��, �÷����� ������ [����] �̸� �� �ǵ��� ...)
-- DEPARTMENTS ���� MANAGER_ID �� ������ �ڵ�
-- *******************  
SELECT 
    D.DNAME �μ���,
    E.FNAME "������ �̸�"
FROM DEP D
    INNER JOIN EMP E
    ON D.MID LIKE E.EID;


SELECT EID,FNAME,MID FROM EMP;
SELECT * FROM DEP;

-- *******************
-- [����023]
-- ������(Marketing) �μ����� �ٹ��ϴ� ����� 
-- ���, ��å, �̸�, �ټӱⰣ
-- (��, �ټӱⰣ�� JOB_HISTORY ���� END_DATE-START_DATE�� ���� ��)
-- EMPLOYEE_ID ���, JOB_TITLE ��å��
-- *******************  
SELECT
    E.EID ���,
    J.TITLE ��å,
    E.FNAME �̸�,
    H.EDATE-H.SDATE �ټӱⰣ
FROM HIS H
    JOIN JOB J
        ON H.JID LIKE J.JID
        JOIN EmP E
        ON E.EID LIKE H.EID
WHERE E.DID LIKE
    (SELECT D.DID
    FROM DEP D
    WHERE D.DNAME LIKE 'Marketing');

-- *******************
-- [����024]
--  ��å�� "Programmer"�� ����� ������ ���
-- DEPARTMENT_NAME �μ���, �̸�(FIRST_NAME + [����] + LAST_NAME)���� ���
-- �̸��� �ߺ��Ǿ ��µ�. �� �Ѹ��� �����μ����� ������ ������
-- *******************


SELECT 
    D.DNAME �μ���,
    E.FNAME ||' '|| E.LNAME �̸�
FROM EMP E
    INNER JOIN DEP D
    ON E.JID LIKE
    (SELECT J.JID 
    FROM JOB J
    WHERE J.TITLE LIKE 'Programmer');

SELECT * FROM EMP;
SELECT * FROM DEP;
SELECT * FROM JOB;
--*******************
-- [���� 25]
-- �μ���, ������ �̸�, �ΰ���ġ ���� ǥ��
-- �μ��� ��������
--********************
SELECT 
    D.DNAME �μ���,
    E.FNAME ||' '|| E.LNAME "������ �̸�",
    L.CITY "�μ���ġ ����"
    FROM DEP D
        JOIN EMP E
            ON D.MID LIKE E.EID
        JOIN LOC L
            USING(LID)
            --ON D.LID LIKE L.LID �̰Ͱ� ����!!!
    ORDER BY DNAME;
    

--**************
--[���� 26]
--�μ��� ��� �޿��� ���Ͻÿ�.
--**************
SELECT 
    D.DNAME �μ���,
    ROUND(AVG(E.SAL),2) "�μ��� ��� �޿�"
FROM EMP E
    JOIN DEP D
        ON E.DID LIKE D.DID
GROUP BY E.DID, D.DNAME
    HAVING ROUND(AVG(E.SAL),2) >= 10000
    ;