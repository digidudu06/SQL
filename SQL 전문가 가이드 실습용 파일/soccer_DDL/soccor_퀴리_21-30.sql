-- SOCCER_SQL_021
-- ���� ���� �Ҽ����� ������� ���
SELECT PLAYER_NAME ������, POSITION ������, BACK_NO ��ѹ�
FROM (SELECT PLAYER_NAME, POSITION, BACK_NO
        FROM PLAYER
        WHERE TEAM_ID LIKE 
            (SELECT TEAM_ID
            FROM PLAYER
            WHERE PLAYER_NAME LIKE '����'))
ORDER BY PLAYER_NAME;


-- SOCCER_SQL_022
-- NULL ó���� �־�
-- SUM(NVL(SAL,0)) �� ��������
-- NVL(SUM(SAL),0) ���� �ؾ� �ڿ����� �پ���
-- ���� �����Ǻ� �ο����� ���� ��ü �ο��� ���
-- Oracle, Simple Case Expr 
SELECT 
    TEAM_ID,
    NVL(SUM(CASE POSITION WHEN 'FW' THEN 1 END),0) FW,
    NVL(SUM(CASE POSITION WHEN 'MF' THEN 1 END),0) MF,
    NVL(SUM(CASE POSITION WHEN 'DF' THEN 1 END),0) DF,
    NVL(SUM(CASE POSITION WHEN 'GK' THEN 1 END),0) GK,
    COUNT(*) SUM
FROM PLAYER
GROUP BY TEAM_ID;

-- SOCCER_SQL_023
-- GROUP BY �� ���� ��ü �������� �����Ǻ� ��� Ű �� ��ü ��� Ű ���
SELECT DISTINCT
    (SELECT ROUND(AVG(HEIGHT),2)
    FROM PLAYER
    WHERE POSITION LIKE 'MF')�̵��ʴ�,
    (SELECT ROUND(AVG(HEIGHT),2)
    FROM PLAYER
    WHERE POSITION LIKE 'FW')������, 
    (SELECT ROUND(AVG(HEIGHT),2)
    FROM PLAYER
    WHERE POSITION LIKE 'DF')�����, 
    (SELECT ROUND(AVG(HEIGHT),2)
    FROM PLAYER
    WHERE POSITION LIKE 'GK')��Ű��, 
    (SELECT ROUND(AVG(HEIGHT),2)
    FROM PLAYER)��ü���Ű
FROM PLAYER 
;

SELECT ROUND(AVG(HEIGHT),2)
    FROM PLAYER
    WHERE POSITION LIKE 'DF';

-- SOCCER_SQL_024 
-- �Ҽ����� Ű�� ���� ���� ������� ����

SELECT 
    P.TEAM_ID �����̵�, 
    (SELECT TEAM_NAME
    FROM TEAM
    WHERE TEAM_ID LIKE P.TEAM_ID) ����,
    P.PLAYER_NAME ����, 
    P.POSITION ������, 
    P.BACK_NO ��ѹ�,
    P.HEIGHT
FROM PLAYER P
WHERE (TEAM_ID, HEIGHT) IN(SELECT TEAM_ID, MIN(HEIGHT) 
                            FROM PLAYER
                            GROUP BY TEAM_ID)
ORDER BY P.TEAM_ID;

-- SOCCER_SQL_025 
-- K-���� 2012�� 8�� ������� �� ������ �������� ABS �Լ��� ����Ͽ�
-- ���밪���� ����ϱ�
SELECT 
    SCHE_DATE, 
   (SELECT T.TEAM_NAME
   FROM TEAM T
   WHERE T.TEAM_ID LIKE SCH.HOMETEAM_ID) ||'-'||
   (SELECT T.TEAM_NAME
   FROM TEAM T
   WHERE T.TEAM_ID LIKE SCH.AWAYTEAM_ID) ����,
    SCH.HOME_SCORE||'-'||SCH.AWAY_SCORE ����,
    ABS(SCH.HOME_SCORE-SCH.AWAY_SCORE) ������
FROM (SELECT 
        STADIUM_ID, 
        SCHE_DATE, 
        HOMETEAM_ID, 
        AWAYTEAM_ID, 
        HOME_SCORE, 
        AWAY_SCORE
     FROM SCHEDULE
     WHERE SCHE_DATE LIKE '201208%'
     ORDER BY SCHE_DATE) SCH
    JOIN STADIUM S
        ON SCH.STADIUM_ID LIKE S.STADIUM_ID
    JOIN TEAM T
        ON T.STADIUM_ID LIKE S.STADIUM_ID;

-- SOCCER_SQL_026 
-- 20120501 ���� 20120602 ���̿� ��Ⱑ �ִ� ����� ��ȸ
SELECT 
    S.STADIUM_ID "��Ÿ��� �ڵ�",
    S.STADIUM_NAME �����,
    SCH.SCHE_DATE �������
FROM STADIUM S
    JOIN SCHEDULE SCH
        ON S.STADIUM_ID LIKE SCH.STADIUM_ID
WHERE SCH.SCHE_DATE BETWEEN '20120501' AND '20120602'
ORDER BY SCH.SCHE_DATE;

-- SOCCER_SQL_027 
-- ���������� �ش� ������ ���� ���� ���Ű ��ȸ
-- ��, ���Ľ� ���Ű ��������
SELECT 
    T.TEAM_NAME ����, 
    P.PLAYER_NAME ������, 
    P.HEIGHT Ű, 
    (SELECT ROUND(AVG(P1.HEIGHT))
                FROM PLAYER P1
                WHERE P1.TEAM_ID LIKE T.TEAM_ID) ���Ű
FROM PLAYER P
    JOIN TEAM T
    ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY T.TEAM_ID, T.TEAM_NAME, P.PLAYER_NAME, P.HEIGHT
ORDER BY 4 DESC;


-- SOCCER_SQL_028 
-- ���Ű�� �Ｚ ������� ���� ���Ű���� ���� ���� 
-- �̸��� �ش� ���� ���Ű
SELECT 
    T.TEAM_NAME ����,
    P.TEAM_ID,
    ROUND(AVG(P.HEIGHT),2) ���Ű
FROM PLAYER P
    JOIN TEAM T
        ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY P.TEAM_ID, T.TEAM_NAME
HAVING AVG(P.HEIGHT) < 
    (SELECT AVG(P.HEIGHT)
    FROM PLAYER P
        JOIN TEAM T
        ON T.TEAM_ID LIKE P.TEAM_ID
    WHERE T.TEAM_NAME LIKE '�Ｚ�������');

-- SOCCER_SQL_029 
-- �巡����,FC����,��ȭõ�� ������ �� �Ҽ��� GK, MF ���� ����
SELECT 
    T.TEAM_NAME �Ҽ���, 
    P.POSITION ������, 
    P.BACK_NO ��ѹ�, 
    P.PLAYER_NAME ������, 
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
    ON T.TEAM_ID LIKE P.TEAM_ID
WHERE TEAM_NAME IN('�巡����','FC����','��ȭõ��')
            AND P.POSITION IN('GK', 'MF')
ORDER BY 1,2,3,4,5;

-- SOCCER_SQL_030 
-- 29������ ������ ���� �������� �ƴ� �������� ��
SELECT 
    T.TEAM_NAME �Ҽ���, 
    P.POSITION ������, 
    P.BACK_NO ��ѹ�, 
    P.PLAYER_NAME ������, 
    P.HEIGHT Ű
FROM PLAYER P
    JOIN TEAM T
    ON T.TEAM_ID LIKE P.TEAM_ID
WHERE TEAM_NAME NOT IN('�巡����','FC����','��ȭõ��')
            AND P.POSITION NOT IN('GK', 'MF')
ORDER BY T.TEAM_NAME;