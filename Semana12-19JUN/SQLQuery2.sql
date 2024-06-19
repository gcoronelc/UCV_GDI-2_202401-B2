
USE MASTER;
GO

RESTORE HEADERONLY  FROM [SQL3-63999];
GO

-- Backup full

BACKUP DATABASE EDUCA TO [SQL3-63999] 
WITH INIT, name = 'EDUCA FULL', description = 'Backup completo de la base de datos EDUCA.';
GO

-- Agregar un nuevo curso

select * from EDUCA..CURSO;
go

-- Transacción de confirmación automática
insert into educa..CURSO values('SQL ADMINISTRACION',30,0,'Gustavo Coronel',1500);
go

-- Transacción incompleta

begin tran;
go

select @@TRANCOUNT;
go

insert into educa..matricula values(8,1,getdate(),1500,1,null);
go

select * from educa..MATRICULA;
go

-- Backup diferencial
-- Se debe ejecutar desde otra conexión

BACKUP DATABASE EDUCA TO [SQL3-63999] 
WITH differential, name = 'EDUCA DIFERENCIAL', 
	description = 'Backup diferencial de la base de datos EDUCA.';
GO

-- Verificando los backup
RESTORE HEADERONLY  FROM [SQL3-63999];
GO

-- Restaurar solo el backup completo

RESTORE DATABASE EDUCA FROM [SQL3-63999] WITH FILE=1, RECOVERY;
GO

select * from educa..curso;
go

-- Restaurar solo el backup completo y diferencial

RESTORE DATABASE EDUCA FROM [SQL3-63999] WITH FILE=1, NORECOVERY;
GO

RESTORE DATABASE EDUCA FROM [SQL3-63999] WITH FILE=2, RECOVERY;
GO

select * from educa..curso;
go

select * from educa..MATRICULA;
go



