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
    T.TEAM_NAME ����,
    P.PLAYER_NAME ����, 
    P.POSITION ������, 
    P.BACK_NO ��ѹ�,
    AVG(P.HEIGHT)
FROM PLAYER P
    JOIN TEAM T
    ON T.TEAM_ID LIKE P.TEAM_ID
GROUP BY P.TEAM_ID, T.TEAM_NAME
ORDER BY P.TEAM_ID;

-- SOCCER_SQL_025 
-- ���� �ڽ��� ���� ���� ��� Ű���� ���� �������� ����

-- SOCCER_SQL_026 
-- 20120501 ���� 20120602 ���̿� ��Ⱑ �ִ� ����� ��ȸ

-- SOCCER_SQL_027 
-- ���������� �ش� ������ ����  ���� ���Ű ��ȸ
-- ��, ���Ľ� ���Ű ��������