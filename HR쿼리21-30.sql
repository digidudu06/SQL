-- *******************
-- [문제021]
-- JOB_TITLE 가 "Programmer" 또는 "Sales Manager"인 
-- 직원의 이름, 입사일, 업무명 표시.
-- 직원의 이름을 오름차순으로 정렬하시오
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
-- [문제022]
-- 부서명 및 관리자이름 표시
-- (단, 컬럼명은 관리자 [공백] 이름 이 되도록 ...)
-- DEPARTMENTS 에서 MANAGER_ID 가 관리자 코드
-- *******************  
SELECT 
    D.DNAME 부서명,
    E.FNAME "관리자 이름"
FROM DEP D
    INNER JOIN EMP E
    ON D.MID LIKE E.EID;


SELECT EID,FNAME,MID FROM EMP;
SELECT * FROM DEP;

-- *******************
-- [문제023]
-- 마케팅(Marketing) 부서에서 근무하는 사원의 
-- 사번, 직책, 이름, 근속기간
-- (단, 근속기간은 JOB_HISTORY 에서 END_DATE-START_DATE로 구할 것)
-- EMPLOYEE_ID 사번, JOB_TITLE 직책임
-- *******************  
SELECT
    E.EID 사번,
    J.TITLE 직책,
    E.FNAME 이름,
    H.EDATE-H.SDATE 근속기간
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
-- [문제024]
--  직책이 "Programmer"인 사원의 정보를 출력
-- DEPARTMENT_NAME 부서명, 이름(FIRST_NAME + [공백] + LAST_NAME)까지 출력
-- 이름은 중복되어서 출력됨. 즉 한명이 여러부서에서 업무를 수행함
-- *******************


SELECT 
    D.DNAME 부서명,
    E.FNAME ||' '|| E.LNAME 이름
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
-- [문제 25]
-- 부서명, 관리자 이름, 부거위치 도시 표시
-- 부서명 오름차순
--********************
SELECT 
    D.DNAME 부서명,
    E.FNAME ||' '|| E.LNAME "관리자 이름",
    L.CITY "부서위치 도시"
    FROM DEP D
        JOIN EMP E
            ON D.MID LIKE E.EID
        JOIN LOC L
            USING(LID)
            --ON D.LID LIKE L.LID 이것과 같음!!!
    ORDER BY DNAME;
    

--**************
--[문제 26]
--부서별 평균 급여를 구하시오.
--**************
SELECT 
    D.DNAME 부서명,
    ROUND(AVG(E.SAL),2) "부서별 평균 급여"
FROM EMP E
    JOIN DEP D
        ON E.DID LIKE D.DID
GROUP BY E.DID, D.DNAME
    HAVING ROUND(AVG(E.SAL),2) >= 10000
    ;