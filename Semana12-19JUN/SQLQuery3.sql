-- PRACTICA DIRIGIDA - BACKUP
-- ===============================================

-- Activar la base de datos master
use master;
go 

-- Creación de la base de datos
create database perudev; 
go

-- Modo de recuperacion de la BD completa

alter database perudev set recovery FULL;
go

select databasepropertyex( 'perudev','Recovery' ); 
go

-- Crear el dispositivo

select * from master.dbo.sysdevices;
go

exec sp_addumpdevice 'disk', 'PD', 'F:\Backup\PDDevice.bak' 
go


-- Tabla de prueba

create table perudev..test( 
	id Int Identity Primary Key, 
	dato varchar(100) 
);
go

insert into perudev..test(dato) 
values('Datos iniciales');
go

select * from perudev..test;
go

-- Backup del día domingo

backup database perudev to pd 
with format, 
	name = 'DOMINGO', 
	description = 'Backup completo de la base de datos.';
go

restore headeronly from pd;
go

-- Trabajando el día lunes

insert into perudev..test(dato) 
values('Datos del LUNES.');
go

select * from perudev..test;
go

backup database perudev to pd 
with differential, 
	name = 'LUNES', 
	description = 'Backup diferencial del dia LUNES.';
go

restore headeronly from pd;
go


-- Trabajando el día martes

insert into perudev..test(dato) 
values('Datos del MARTES.');
go

select * from perudev..test;
go

backup database perudev to pd 
with differential, 
	name = 'MARTES', 
	description = 'Backup diferencial del dia MARTES.';
go

restore headeronly from pd;
go

-- Trabajando el miercoles por la mañana

insert into perudev..test(dato) 
values('MIERCOLES por la mañana.');
go

select * from perudev..test;
go


-- MIERCOLES 12 del dia
-- FALLA EN EL SERVIDOR
-- Urgente hacer un backup del log.

backup log perudev to pd 
with no_truncate, 
	name = 'LOG', description = 'Backup del log.';
go

restore headeronly from pd;
go


-- PRACTICA DIRIGIDA - RESTAURACION DE LA BASE DE DATOs
-- ==============================================================

drop database perudev;
go

restore headeronly from pd;
go

RESTORE DATABASE perudev FROM PD WITH FILE=1, RECOVERY;
GO

select * from perudev..test;
go


-- PRACTICA DIRIGIDA - RESTAURACION HASTA EL DIA LUNES
-- ==============================================================

drop database perudev;
go

restore headeronly from pd;
go

RESTORE DATABASE perudev FROM PD WITH FILE=1, NORECOVERY;
GO

RESTORE DATABASE perudev FROM PD WITH FILE=2, RECOVERY;
GO

select * from perudev..test;
go

-- PRACTICA DIRIGIDA - RESTAURACION HASTA EL DIA MARTES
-- ==============================================================

drop database perudev;
go

restore headeronly from pd;
go

RESTORE DATABASE perudev FROM PD WITH FILE=1, NORECOVERY;
GO

RESTORE DATABASE perudev FROM PD WITH FILE=3, RECOVERY;
GO

select * from perudev..test;
go


-- PRACTICA DIRIGIDA - RESTAURACION HASTA EL DIA MIERCOLES
-- ==============================================================

drop database perudev;
go

restore headeronly from pd;
go

RESTORE DATABASE perudev FROM PD WITH FILE=1, NORECOVERY;
GO

RESTORE DATABASE perudev FROM PD WITH FILE=3, NORECOVERY;
GO

RESTORE LOG perudev FROM PD WITH FILE = 4, RECOVERY;
GO

select * from perudev..test;
go







