-- SQL_TEST_001
-- ��ü �౸�� ���. �̸� ��������
SELECT
    TEAM_NAME "��ü �౸�� ���"
FROM TEAM
ORDER BY TEAM_NAME;

-- SQL_TEST_002
-- ������ ����(�ߺ�����,������ �����)
SELECT
    DISTINCT POSITION ������
FROM PLAYER;

-- SQL_TEST_003
-- ������ ����(�ߺ�����,������ �������� ����)
-- nvl2()���
SELECT
    DISTINCT NVL2(POSITION,POSITION,'����') ������
FROM PLAYER;

-- SQL_TEST_004
-- ������(ID: K02)��Ű��
SELECT
    PLAYER_NAME
FROM (SELECT
        PLAYER_NAME
     FROM PLAYER
     WHERE TEAM_ID LIKE 'K02'
     AND POSITION LIKE 'GK')
ORDER BY PLAYER_NAME;


-- SQL_TEST_005
-- ������(ID: K02)Ű�� 170 �̻� ����
-- �̸鼭 ���� ���� ����
SELECT
    POSITION ������,
    PLAYER_NAME �̸�
FROM PLAYER
WHERE TEAM_ID = 'K02'
    AND HEIGHT >= 170
    AND PLAYER_NAME LIKE '��%';
-- SQL_TEST_006
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� cm �� kg ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- Ű ��������
SELECT
    PLAYER_NAME �̸�,
    NVL2(HEIGHT, HEIGHT,'0')||'cm' Ű,
    NVL2(WEIGHT, WEIGHT,'0')||'kg' ������
FROM PLAYER
WHERE TEAM_ID = 'K02'
ORDER BY HEIGHT DESC;


-- SQL_TEST_007
-- ������(ID: K02) ������ �̸�,
-- Ű�� ������ ����Ʈ (���� cm �� kg ����)
-- Ű�� �����԰� ������ "0" ǥ��
-- BMI���� 
-- Ű ��������
SELECT
    PLAYER_NAME||'����' �̸�,
    NVL2(HEIGHT, HEIGHT,'0')||'cm' Ű,
    NVL2(WEIGHT, WEIGHT,'0')||'kg' ������,
    ROUND(WEIGHT/((HEIGHT*HEIGHT)*0.0001),2) "BMI ����"
FROM (SELECT
        *
     FROM PLAYER
     WHERE TEAM_ID='K02')
ORDER BY HEIGHT DESC;

-- SQL_TEST_008
-- ������(ID: K02) �� ������(ID: K10)������ �� 
--  �������� GK ��  ����
-- ����, ����� ��������

-- INNER JOIN
SELECT
    T.TEAM_NAME,
    P.POSITION,
    P.PLAYER_NAME
FROM PLAYER P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
WHERE P.POSITION LIKE 'GK' AND T.TEAM_ID IN('K02','K10')
ORDER BY T.TEAM_NAME, P.PLAYER_NAME;

--NATYURAL JOIN(����, �����)
SELECT
    T.TEAM_NAME,
    P.POSITION,
    P.PLAYER_NAME
FROM PLAYER P, TEAM T
WHERE P.TEAM_ID = T.TEAM_ID --���� ���� ��ǥ��
    AND P.POSITION LIKE 'GK' AND T.TEAM_ID IN('K02','K10')
ORDER BY T.TEAM_NAME, P.PLAYER_NAME;


-- SQL_TEST_009
-- ������(ID: K02) �� ������(ID: K10)������ �� ��
-- Ű�� 180 �̻� 183 ������ ������
-- Ű, ����, ����� ��������
SELECT
    T.TEAM_NAME ����,
    P.PLAYER_NAME �����,
    P.HEIGHT||'cm' Ű       
FROM (SELECT TEAM_NAME, TEAM_ID FROM TEAM WHERE TEAM_ID IN('K02','K10')) T
    JOIN PLAYER P
        ON T.TEAM_ID LIKE P.TEAM_ID
WHERE P.HEIGHT BETWEEN 180 AND 183
ORDER BY P.HEIGHT, T.TEAM_NAME, P.PLAYER_NAME;

-- SOCCER_SQL_010
-- ��� ������ ��
-- �������� �������� ���� �������� ���� �̸�
-- ����, ����� ��������
SELECT T.TEAM_NAME ����, P.PLAYER_NAME �����
FROM (SELECT TEAM_ID, PLAYER_NAME
      FROM PLAYER
      WHERE POSITION IS NULL) P
    JOIN TEAM T
        ON P.TEAM_ID LIKE T.TEAM_ID
ORDER BY T.TEAM_NAME, P.PLAYER_NAME;