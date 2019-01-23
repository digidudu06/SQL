-- SOCCER_SQL_021
-- 이현 선수 소속팀의 선수명단 출력
SELECT PLAYER_NAME 선수명, POSITION 포지션, BACK_NO 백넘버
FROM (SELECT PLAYER_NAME, POSITION, BACK_NO
        FROM PLAYER
        WHERE TEAM_ID LIKE 
            (SELECT TEAM_ID
            FROM PLAYER
            WHERE PLAYER_NAME LIKE '이현'))
ORDER BY PLAYER_NAME;


-- SOCCER_SQL_022
-- NULL 처리에 있어
-- SUM(NVL(SAL,0)) 로 하지말고
-- NVL(SUM(SAL),0) 으로 해야 자원낭비가 줄어든다
-- 팀별 포지션별 인원수와 팀별 전체 인원수 출력
-- Oracle, Simple Case Expr 


-- SOCCER_SQL_023
-- GROUP BY 절 없이 전체 선수들의 포지션별 평균 키 및 전체 평균 키 출력
SELECT DISTINCT
    (SELECT ROUND(AVG(HEIGHT),2)
    FROM PLAYER
    WHERE POSITION LIKE 'MF')미드필더,
    (SELECT ROUND(AVG(HEIGHT),2)
    FROM PLAYER
    WHERE POSITION LIKE 'FW')포워드, 
    (SELECT ROUND(AVG(HEIGHT),2)
    FROM PLAYER
    WHERE POSITION LIKE 'DF')디펜더, 
    (SELECT ROUND(AVG(HEIGHT),2)
    FROM PLAYER
    WHERE POSITION LIKE 'GK')골키퍼, 
    (SELECT ROUND(AVG(HEIGHT),2)
    FROM PLAYER)전체평균키
FROM PLAYER 
;

SELECT ROUND(AVG(HEIGHT),2)
    FROM PLAYER
    WHERE POSITION LIKE 'DF';

-- SOCCER_SQL_024 
-- 소속팀별 키가 가장 작은 사람들의 정보

SELECT 
    P.TEAM_ID 팀아이디, 
    T.TEAM_NAME 팀명,
    P.PLAYER_NAME 선수, 
    P.POSITION 포지션, 
    P.BACK_NO 백넘버,
    AVG(P.HEIGHT)
FROM PLAYER P
    JOIN TEAM T
    ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY P.TEAM_ID, T.TEAM_NAME
ORDER BY P.TEAM_ID;

-- SOCCER_SQL_025 
-- 선수 자신이 속한 팀의 평균 키보다 작은 선수들의 정보

-- SOCCER_SQL_026 
-- 20120501 부터 20120602 사이에 경기가 있는 경기장 조회

-- SOCCER_SQL_027 
-- 선수정보와 해당 선수가 속한  팀의 평균키 조회
-- 단, 정렬시 평균키 내림차순