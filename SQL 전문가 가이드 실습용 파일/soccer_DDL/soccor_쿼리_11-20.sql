-- SOCCER_SQL_011
-- ���� ��Ÿ����� �����Ͽ�
-- ���̸�, ��Ÿ��� �̸� ���
SELECT T.TEAM_NAME �̸�, S.STADIUM_NAME ��Ÿ���
FROM (SELECT TEAM_NAME, STADIUM_ID
      FROM TEAM) T
    JOIN STADIUM S
        ON T.STADIUM_ID LIKE S.STADIUM_ID;


-- SOCCER_SQL_012
-- ���� ��Ÿ���, �������� �����Ͽ�
-- 2012�� 3�� 17�Ͽ� ���� �� ����� 
-- ���̸�, ��Ÿ���, ������� �̸� ���
-- �������̺� join �� ã�Ƽ� �ذ��Ͻÿ�
SELECT 
    S.STADIUM_NAME ��Ÿ���,
    SCH.SCHE_DATE �������,
    T.TEAM_NAME Ȩ��,
    (SELECT TEAM_NAME FROM TEAM WHERE TEAM_ID LIKE SCH.AWAYTEAM_ID) �������   
FROM (SELECT SCHE_DATE, STADIUM_ID, AWAYTEAM_ID
     FROM SCHEDULE
     WHERE SCHE_DATE LIKE '20120317') SCH
    JOIN TEAM T
        ON T.STADIUM_ID LIKE SCH.STADIUM_ID
    JOIN STADIUM S
        ON SCH.STADIUM_ID LIKE S.STADIUM_ID

ORDER BY T.TEAM_NAME;


-- SOCCER_SQL_013
-- 2012�� 3�� 17�� ��⿡ 
-- ���� ��ƿ���� �Ҽ� ��Ű��(GK)
-- ����, ������,���� (����������), 
-- ��Ÿ���, ��⳯¥�� ���Ͻÿ�
-- �������� ���̸��� ������ ���ÿ�
-- 01.
SELECT 
    P.PLAYER_NAME ����,
    P.POSITION ������,
    T.REGION_NAME||' '||T.TEAM_NAME ����,
    S.STADIUM_NAME ��Ÿ���,
    SCH.SCHE_DATE ��⳯¥
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
     AND T.TEAM_NAME LIKE '��ƿ����'
ORDER BY P.PLAYER_NAME;

-- 02.
SELECT 
    P.PLAYER_NAME ����,
    P.POSITION ������,
    T.REGION_NAME||' '||T.TEAM_NAME ����,
    S.STADIUM_NAME ��Ÿ���,
    SCH.SCHE_DATE ��⳯¥
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
     AND T.TEAM_NAME LIKE '��ƿ����'
ORDER BY P.PLAYER_NAME;

-- SOCCER_SQL_014
-- Ȩ���� 3���̻� ���̷� �¸��� ����� 
-- ����� �̸�, ��� ����
-- Ȩ�� �̸��� ������ �̸���
-- ���Ͻÿ�
SELECT * FROM SCHEDULE;
SELECT 
    S.STADIUM_NAME "����� �̸�", 
    SCH.SCHE_DATE "��� ����", 
    (SELECT TEAM_NAME
    FROM TEAM
    WHERE TEAM_ID LIKE SCH.HOMETEAM_ID) "Ȩ�� �̸�", 
    (SELECT TEAM_NAME
    FROM TEAM
    WHERE TEAM_ID LIKE SCH.AWAYTEAM_ID) "������ �̸�",
    SCH.HOME_SCORE "Ȩ�� ����",
    SCH.AWAY_SCORE "������ ����"
FROM STADIUM S
    JOIN TEAM T
        ON S.STADIUM_ID LIKE T.STADIUM_ID
    JOIN (SELECT SCHE_DATE, HOMETEAM_ID, AWAYTEAM_ID, HOME_SCORE, AWAY_SCORE
            FROM SCHEDULE
            WHERE HOME_SCORE - AWAY_SCORE >= 3) SCH
        ON S.HOMETEAM_ID = SCH.HOMETEAM_ID;

-- SOCCER_SQL_015
-- STADIUM �� ��ϵ� ��� �߿���
-- Ȩ���� ���� �������� ���� ��������
-- ī��Ʈ ���� 20
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
-- ���Ű�� ��õ ������Ƽ������ ���Ű ���� ���� ���� 
-- ��ID, ����, ���Ű ����
SELECT
    P.TEAM_ID ��ID,
    (SELECT TEAM_NAME
    FROM TEAM
    WHERE TEAM_ID LIKE P.TEAM_ID) ����,
    ROUND(AVG(P.HEIGHT),1) ���Ű
FROM PLAYER P
GROUP BY P.TEAM_ID
HAVING
(SELECT 
    ROUND(AVG(HEIGHT),1) ���Ű
FROM PLAYER 
GROUP BY TEAM_ID
HAVING P.TEAM_ID LIKE 'K04') 
> 
(SELECT 
    ROUND(AVG(HEIGHT),1) ���Ű
FROM PLAYER 
GROUP BY TEAM_ID) ;


--���� ���Ű
SELECT 
    ROUND(AVG(HEIGHT),1) ���Ű
FROM PLAYER 
GROUP BY TEAM_ID;


SELECT T.TEAM_ID,T.TEAM_NAME,ROUND(AVG(P.HEIGHT),2) ���Ű
    FROM (SELECT HEIGHT,TEAM_ID
          FROM PLAYER) P
    JOIN TEAM T ON P.TEAM_ID LIKE T.TEAM_ID
    GROUP BY T.TEAM_ID,T.TEAM_NAME
    HAVING ROUND(AVG(P.HEIGHT),2)<180.51 ;


-- SOCCER_SQL_017
-- �������� MF �� ��������  �Ҽ����� �� ������, ��ѹ� ���
SELECT 
    (SELECT TEAM_NAME
    FROM TEAM
    WHERE TEAM_ID LIKE P.TEAM_ID) �Ҽ�����,
    P.PLAYER_NAME ������,
    P.BACK_NO ��ѹ�
FROM PLAYER P
WHERE POSITION LIKE 'MF';

-- SOCCER_SQL_018
-- ���� Űū ���� 5 ����, ����Ŭ, �� Ű ���� ������ ����
SELECT 
    PLAYER_NAME ������,
    BACK_NO ��ѹ�,
    POSITION ������,
    HEIGHT Ű
FROM (SELECT PLAYER_NAME , BACK_NO, POSITION, HEIGHT
    FROM PLAYER
    WHERE HEIGHT IS NOT NULL
    ORDER BY HEIGHT DESC)
WHERE ROWNUM <= 5;


-- SOCCER_SQL_019
-- ���� �ڽ��� ���� ���� ���Ű���� ���� ���� ���� ���


-- SOCCER_SQL_020
-- 2012�� 5�� �Ѵް� ��Ⱑ �ִ� ����� ��ȸ
-- EXISTS ������ �׻� ���������� ����Ѵ�.
-- ���� �ƹ��� ������ �����ϴ� ���� ���� ���̶�
-- ������ �����ϴ� 1�Ǹ� ã���� �߰����� �˻��� �������� �ʴ´�.

