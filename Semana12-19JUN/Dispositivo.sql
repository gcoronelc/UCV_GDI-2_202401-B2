
-- Crea un dispositivo de copia de seguridad

USE master 
EXEC sp_addumpdevice 'disk', 'SQL3-63999', 'F:\backup\SQL3-63999.bak'
go

-- Crea la copia de seguridad en un archivo

USE master 
BACKUP DATABASE EUREKABANK 
TO DISK = 'F:\backup\EUREKABANK01.bak'
GO

USE master 
BACKUP DATABASE NORTHWIND 
TO DISK = 'F:\backup\EUREKABANK01.bak'
WITH INIT
GO

RESTORE HEADERONLY 
FROM DISK = N'F:\backup\EUREKABANK01.bak';
GO

RESTORE VERIFYONLY 
FROM DISK = N'F:\backup\EUREKABANK01.bak';
GO


USE master 
BACKUP DATABASE EUREKABANK TO [SQL3-63999]
WITH FORMAT, NAME = 'Full Backup of EUREKABANK';
GO

RESTORE HEADERONLY  FROM [SQL3-63999];
GO