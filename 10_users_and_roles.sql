SELECT * FROM sys.database_principals WHERE type IN ('S', 'U');

CREATE LOGIN Taras WITH PASSWORD = 'Vladik';
CREATE LOGIN Andrii WITH PASSWORD = 'Vladik';
CREATE LOGIN performer_user WITH PASSWORD = '12345';
CREATE LOGIN customer_user WITH PASSWORD = '1111';

CREATE USER Taras FOR LOGIN Taras;
CREATE USER Andrii FOR LOGIN Andrii;
CREATE USER performer_user FOR LOGIN performer_user;
CREATE USER customer_user FOR LOGIN customer_user;

ALTER ROLE db_owner ADD MEMBER Andrii;

EXECUTE AS USER = 'Andrii';
SELECT SUSER_NAME() AS CurrentLogin, USER_NAME() AS CurrentUser;

SELECT USER_NAME() AS CurrentUser;

EXECUTE AS USER = 'customer_user';
UPDATE Project
SET project_manager = 'no one'
WHERE project_id = 5

GRANT SELECT ON Customer_Bill TO customer_user;
GRANT SELECT ON Project TO customer_user;

GRANT SELECT ON Project TO performer_user;
GRANT SELECT, INSERT ON Report TO performer_user;
GRANT SELECT ON Salary TO performer_user;

GRANT SELECT ON Salary TO Taras;

CREATE ROLE admin_role;
CREATE ROLE performer_role;

GRANT CONTROL ON DATABASE::var5 TO admin_role;

GRANT SELECT ON Project TO performer_role;
GRANT SELECT, INSERT ON Reports TO performer_role;
GRANT SELECT ON Salary TO performer_role;

ALTER ROLE admin_role ADD MEMBER Andrii;
ALTER ROLE performer_role ADD MEMBER performer_user;
ALTER ROLE performer_role ADD MEMBER Taras;

SELECT r.name AS RoleName, m.name AS UserName
FROM sys.database_role_members rm
JOIN sys.database_principals r ON rm.role_principal_id = r.principal_id
JOIN sys.database_principals m ON rm.member_principal_id = m.principal_id
WHERE m.name = 'Andrii';


REVOKE SELECT ON Project FROM performer_user;

EXECUTE AS USER = 'Andrii';
ALTER ROLE performer_role ADD MEMBER Taras;
SELECT * FROM Project;

EXECUTE AS USER = 'Taras';
SELECT * FROM Project;


REVOKE CONTROL ON DATABASE::var5 FROM admin_role;
REVOKE CONTROL ON DATABASE::var5 FROM Andrii;

REVOKE CONTROL ON DATABASE::var5 FROM performer_role;
REVOKE CONTROL ON DATABASE::var5 FROM performer_user;

REVOKE CONTROL ON DATABASE::var5 FROM customer_user;

ALTER ROLE admin_role DROP MEMBER Andrii;
ALTER ROLE performer_role DROP MEMBER performer_user;
ALTER ROLE performer_role DROP MEMBER Taras;

DROP ROLE admin_role;
DROP ROLE performer_role;

DROP USER Andrii;
DROP USER Taras;
DROP USER performer_user;
DROP USER customer_user;