Select * from employees;

CREATE SEQUENCE EMP_SEQ
START WITH 1000;

SELECT * FROM USER_SEQUENCES;

INSERT INTO EMPLOYEES(EMPLOYEE_ID,MANAGER,NAME,BIRTH_DATE,PHOTO,NOTES)
VALUES(EMP_SEQ.NEXTVAL,'MANAGER','����','960101','KIM.JPG','MANAGER');