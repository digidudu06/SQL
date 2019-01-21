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
    T.TEAM_NAME ���̸�,
    S.STADIUM_NAME ��Ÿ���, 
    SCH.AWAYTEAM_ID "������� �̸�"
FROM STADIUM S
    JOIN TEAM T
        ON T.STADIUM_ID LIKE S.STADIUM_ID
    JOIN SCHEDULE SCH
        ON SCH.STADIUM_ID LIKE S.STADIUM_ID
WHERE SCHE_DATE LIKE '20120317'
ORDER BY T.TEAM_NAME;


-- SOCCER_SQL_013
-- 2012�� 3�� 17�� ��⿡ 
-- ���� ��ƿ���� �Ҽ� ��Ű��(GK)
-- ����, ������,���� (����������), 
-- ��Ÿ���, ��⳯¥�� ���Ͻÿ�
-- �������� ���̸��� ������ ���ÿ�
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

SELECT * FROM TEAM;
SELECT * FROM STADIUM;
SELECT * FROM SCHEDULE;

-- SOCCER_SQL_014
-- Ȩ���� 3���̻� ���̷� �¸��� ����� 
-- ����� �̸�, ��� ����
-- Ȩ�� �̸��� ������ �̸���
-- ���Ͻÿ�
SELECT * FROM SCHEDULE;
SELECT 
    S.STADIUM_NAME "����� �̸�", 
    SCH.SCHE_DATE "��� ����", 
    SCH.HOMETEAM_ID "Ȩ�� �̸�", 
    SCH.AWAYTEAM_ID "������ �̸�"
FROM TEAM T
    JOIN STADIUM S
        ON S.STADIUM_ID = T.STADIUM_ID;
    
SELECT * FROM TEAM;
SELECT 

-- SOCCER_SQL_015
-- STADIUM �� ��ϵ� ��� �߿���
-- Ȩ���� ���� �������� ���� ��������
-- ī��Ʈ ���� 20

-- SOCCER_SQL_016
-- ���Ű�� ��õ ������Ƽ������ ���Ű ���� ���� ���� 
-- ��ID, ����, ���Ű ����

-- SOCCER_SQL_017
-- �������� MF �� ��������  �Ҽ����� �� ������, ��ѹ� ���\

-- SOCCER_SQL_018
-- ���� Űū ���� 5 ����, ����Ŭ, �� Ű ���� ������ ����

-- SOCCER_SQL_019
-- ���� �ڽ��� ���� ���� ���Ű���� ���� ���� ���� ���

-- SOCCER_SQL_020
-- 2012�� 5�� �Ѵް� ��Ⱑ �ִ� ����� ��ȸ
-- EXISTS ������ �׻� ���������� ����Ѵ�.
-- ���� �ƹ��� ������ �����ϴ� ���� ���� ���̶�
-- ������ �����ϴ� 1�Ǹ� ã���� �߰����� �˻��� �������� �ʴ´�.