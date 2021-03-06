------------- 1~5 (1페이지) -----------------
--1단계
SELECT BIRTH_DATE 생년월일, PLAYER_NAME 선수
FROM PLAYER
WHERE BIRTH_DATE IS NOT NULL
ORDER BY BIRTH_DATE DESC;
    
--2단계
SELECT BIRTH_DATE 생년월일, PLAYER_NAME 선수
FROM PLAYER
WHERE BIRTH_DATE IS NOT NULL
AND ROWNUM BETWEEN 1 AND 5
ORDER BY BIRTH_DATE DESC;

--3단계
SELECT BIRTH_DATE 생년월일, PLAYER_NAME 선수
FROM (SELECT BIRTH_DATE, PLAYER_NAME
    FROM PLAYER
    WHERE BIRTH_DATE IS NOT NULL
    ORDER BY BIRTH_DATE DESC)
WHERE ROWNUM BETWEEN 1 AND 5;

------------- 6~10 (2페이지) -----------------
-- 1단계
SELECT BIRTH_DATE 생년월일, PLAYER_NAME 선수
FROM (SELECT BIRTH_DATE, PLAYER_NAME
    FROM PLAYER
    WHERE BIRTH_DATE IS NOT NULL
    ORDER BY BIRTH_DATE DESC)
WHERE ROWNUM BETWEEN 6 AND 10;

-- 2단계
SELECT BIRTH_DATE 생년월일, PLAYER_NAME 선수
FROM (SELECT ROWNUM RNUM, BIRTH_DATE, PLAYER_NAME
    FROM PLAYER
    WHERE BIRTH_DATE IS NOT NULL
    ORDER BY BIRTH_DATE DESC)
WHERE RNUM BETWEEN 6 AND 10;

-- 3단계
SELECT BIRTH_DATE 생년월일, PLAYER_NAME 선수
FROM (SELECT ROWNUM RNUM, BIRTH_DATE, PLAYER_NAME
    FROM (SELECT BIRTH_DATE, PLAYER_NAME
        FROM PLAYER
        WHERE BIRTH_DATE IS NOT NULL
        ORDER BY BIRTH_DATE DESC))
WHERE RNUM BETWEEN 6 AND 10;

---------------- TUPLE 번호 메기기 ---------------------
SELECT RNUM "NO.", BIRTH_DATE 생년월일, PLAYER_NAME 선수
FROM (SELECT ROWNUM RNUM, P.*
    FROM (SELECT BIRTH_DATE, PLAYER_NAME
            FROM PLAYER
            WHERE BIRTH_DATE IS NOT NULL
            ORDER BY BIRTH_DATE DESC) P)
WHERE RNUM BETWEEN 1 AND 5
;
