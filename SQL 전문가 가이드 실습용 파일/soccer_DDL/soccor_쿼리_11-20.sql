-- SOCCER_SQL_011
-- 팀과 스타디움을 조인하여
-- 팀이름, 스타디움 이름 출력
SELECT T.TEAM_NAME 이름, S.STADIUM_NAME 스타디움
FROM (SELECT TEAM_NAME, STADIUM_ID
      FROM TEAM) T
    JOIN STADIUM S
        ON T.STADIUM_ID LIKE S.STADIUM_ID;


-- SOCCER_SQL_012
-- 팀과 스타디움, 스케줄을 조인하여
-- 2012년 3월 17일에 열린 각 경기의 
-- 팀이름, 스타디움, 어웨이팀 이름 출력
-- 다중테이블 join 을 찾아서 해결하시오
SELECT 
    S.STADIUM_NAME 스타디움,
    SCH.SCHE_DATE 경기일정,
    T.TEAM_NAME 홈팀,
    (SELECT TEAM_NAME FROM TEAM WHERE TEAM_ID LIKE SCH.AWAYTEAM_ID) 어웨이팀   
FROM (SELECT SCHE_DATE, STADIUM_ID, AWAYTEAM_ID
     FROM SCHEDULE
     WHERE SCHE_DATE LIKE '20120317') SCH
    JOIN TEAM T
        ON T.STADIUM_ID LIKE SCH.STADIUM_ID
    JOIN STADIUM S
        ON SCH.STADIUM_ID LIKE S.STADIUM_ID

ORDER BY T.TEAM_NAME;


-- SOCCER_SQL_013
-- 2012년 3월 17일 경기에 
-- 포항 스틸러스 소속 골키퍼(GK)
-- 선수, 포지션,팀명 (연고지포함), 
-- 스타디움, 경기날짜를 구하시오
-- 연고지와 팀이름은 간격을 띄우시오
-- 01.
SELECT 
    P.PLAYER_NAME 선수,
    P.POSITION 포지션,
    T.REGION_NAME||' '||T.TEAM_NAME 팀명,
    S.STADIUM_NAME 스타디움,
    SCH.SCHE_DATE 경기날짜
FROM TEAM T
    JOIN STADIUM S
        ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN PLAYER P
        ON T.TEAM_ID LIKE P.TEAM_ID
    JOIN (SELECT STADIUM_ID, SCHE_DATE
          FROM SCHEDULE
          WHERE SCHE_DATE LIKE '20120317') SCH
        ON S.STADIUM_ID LIKE SCH.STADIUM_ID
WHERE P.POSITION LIKE 'GK'
     AND T.TEAM_NAME LIKE '스틸러스'
ORDER BY P.PLAYER_NAME;

-- 02.
SELECT 
    P.PLAYER_NAME 선수,
    P.POSITION 포지션,
    T.REGION_NAME||' '||T.TEAM_NAME 팀명,
    S.STADIUM_NAME 스타디움,
    SCH.SCHE_DATE 경기날짜
FROM TEAM T
    JOIN STADIUM S
        ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN PLAYER P
        ON T.TEAM_ID LIKE P.TEAM_ID
    JOIN (SELECT STADIUM_ID, SCHE_DATE
          FROM SCHEDULE
          WHERE SCHE_DATE LIKE '20120317') SCH
        ON S.STADIUM_ID LIKE SCH.STADIUM_ID
WHERE P.POSITION LIKE 'GK'
     AND T.TEAM_NAME LIKE '스틸러스'
ORDER BY P.PLAYER_NAME;

-- SOCCER_SQL_014
-- 홈팀이 3점이상 차이로 승리한 경기의 
-- 경기장 이름, 경기 일정
-- 홈팀 이름과 원정팀 이름을
-- 구하시오
SELECT * FROM SCHEDULE;
SELECT 
    S.STADIUM_NAME "경기장 이름", 
    SCH.SCHE_DATE "경기 일정", 
    (SELECT TEAM_NAME
    FROM TEAM
    WHERE TEAM_ID LIKE SCH.HOMETEAM_ID) "홈팀 이름", 
    (SELECT TEAM_NAME
    FROM TEAM
    WHERE TEAM_ID LIKE SCH.AWAYTEAM_ID) "원정팀 이름",
    SCH.HOME_SCORE "홈팀 점수",
    SCH.AWAY_SCORE "원정팀 점수"
FROM STADIUM S
    JOIN TEAM T
        ON S.STADIUM_ID LIKE T.STADIUM_ID
    JOIN (SELECT SCHE_DATE, HOMETEAM_ID, AWAYTEAM_ID, HOME_SCORE, AWAY_SCORE
            FROM SCHEDULE
            WHERE HOME_SCORE - AWAY_SCORE >= 3) SCH
        ON S.HOMETEAM_ID = SCH.HOMETEAM_ID;

-- SOCCER_SQL_015
-- STADIUM 에 등록된 운동장 중에서
-- 홈팀이 없는 경기장까지 전부 나오도록
-- 카운트 값은 20
SELECT 
    S.STADIUM_NAME,
    S.STADIUM_ID, 
    S.SEAT_COUNT, 
    S.HOMETEAM_ID, 
    (SELECT E_TEAM_NAME
    FROM TEAM
    WHERE STADIUM_ID LIKE S.STADIUM_ID) E_TEAM_NAME
FROM STADIUM S;

-- SOCCER_SQL_016
-- 평균키가 인천 유나이티스팀의 평균키 보다 작은 팀의 
-- 팀ID, 팀명, 평균키 추출
SELECT
    P.TEAM_ID 팀ID,
    (SELECT TEAM_NAME
    FROM TEAM
    WHERE TEAM_ID LIKE P.TEAM_ID) 팀명,
    ROUND(AVG(P.HEIGHT),1) 평균키
FROM PLAYER P
GROUP BY P.TEAM_ID
HAVING
(SELECT 
    ROUND(AVG(HEIGHT),1) 평균키
FROM PLAYER 
GROUP BY TEAM_ID
HAVING P.TEAM_ID LIKE 'K04') 
> 
(SELECT 
    ROUND(AVG(HEIGHT),1) 평균키
FROM PLAYER 
GROUP BY TEAM_ID) ;


--팀별 평균키
SELECT 
    ROUND(AVG(HEIGHT),1) 평균키
FROM PLAYER 
GROUP BY TEAM_ID;


SELECT T.TEAM_ID,T.TEAM_NAME,ROUND(AVG(P.HEIGHT),2) 평균키
    FROM (SELECT HEIGHT,TEAM_ID
          FROM PLAYER) P
    JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
    GROUP BY T.TEAM_ID,T.TEAM_NAME
    HAVING ROUND(AVG(P.HEIGHT),2)<180.51 ;


-- SOCCER_SQL_017
-- 포지션이 MF 인 선수들의  소속팀명 및 선수명, 백넘버 출력
SELECT 
    (SELECT TEAM_NAME
    FROM TEAM
    WHERE TEAM_ID LIKE P.TEAM_ID) 소속팀명,
    P.PLAYER_NAME 선수명,
    P.BACK_NO 백넘버
FROM PLAYER P
WHERE POSITION LIKE 'MF';

-- SOCCER_SQL_018
-- 가장 키큰 선수 5 추출, 오라클, 단 키 값이 없으면 제외
SELECT 
    PLAYER_NAME 선수명,
    BACK_NO 백넘버,
    POSITION 포지션,
    HEIGHT 키
FROM (SELECT PLAYER_NAME , BACK_NO, POSITION, HEIGHT
    FROM PLAYER
    WHERE HEIGHT IS NOT NULL
    ORDER BY HEIGHT DESC)
WHERE ROWNUM <= 5;


-- SOCCER_SQL_019
-- 선수 자신이 속한 팀의 평균키보다 작은 선수 정보 출력


-- SOCCER_SQL_020
-- 2012년 5월 한달간 경기가 있는 경기장 조회
-- EXISTS 쿼리는 항상 연관쿼리로 상요한다.
-- 또한 아무리 조건을 만족하는 건이 여러 건이라도
-- 조건을 만족하는 1건만 찾으면 추가적인 검색을 진행하지 않는다.

