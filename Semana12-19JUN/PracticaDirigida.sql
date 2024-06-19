-- Paso 1: Preparando la BD

use master;
go

drop database perudev;
go

create database perudev;
go

use perudev;
go

alter database perudev
set recovery FULL;
go

select databasepropertyex( 'perudev','Recovery' ) [Conf. Recuperacion BD];
go



-- Paso 2: Crear el Device

EXEC sp_dropdevice 'PD';
go

exec sp_addumpdevice 'disk', 'PD', 'C:\Backup\PDDevice.bak';
go

select * from master.dbo.sysdevices;
go


-- Paso 3: Creando la tabla de prueba

create table perudev..test(
	id Int Identity Primary Key,
	dato varchar(100)
);
go


declare @k int;
set @k = 0;
while (@k < 10)
begin
	begin tran;
	insert into perudev..test(dato) values('La fe de cuto esta con ustedes.');
	commit tran;
	set @k = @k + 1;
end;
go

select * from perudev..test;
go


-- Paso 4: Backup completo de la BD del dia domingo

backup database perudev to pd
with
	format,
	name = 'BakBD Domingo',
	description = 'Backup completo de la base de datos';
go

restore headeronly from pd;
go


-- Paso 5: Actividades del lunes

declare @k int;
set @k = 0;
while (@k < 10)
begin
	begin tran;
	insert into perudev..test(dato) values('Actividades del lunes');
	commit tran;
	set @k = @k + 1;
end;
go

select * from perudev..test order by 1 desc;
go

backup database perudev to pd
with
	differential,
	name = 'BakDif01 Lunes',
	description = 'Backup diferencial del lunes';
go


restore headeronly from pd;
go


-- Paso 6: Actividades del martes

declare @k int;
set @k = 0;
while (@k < 10)
begin
	begin tran;
	insert into perudev..test(dato) values('Actividades del martes');
	commit tran;
	set @k = @k + 1;
end;
go

select * from perudev..test order by 1 desc;
go

backup database perudev to pd
with
	differential,
	name = 'BakDif02 Martes',
	description = 'Backup diferencial del martes';
go


restore headeronly from pd;
go


-- Paso 7: Actividades del miercoles y error

declare @k int;
set @k = 0;
while (@k < 10)
begin
	begin tran;
	insert into perudev..test(dato) values('Actividades del miercoles');
	commit tran;
	set @k = @k + 1;
end;
go

select * from perudev..test order by 1 desc;
go

-- Hay un error en la BD

backup log perudev to pd
with
	no_truncate,
	name = 'BakLog Miercoles',
	description = 'Backup del log.'
go


restore headeronly from pd;
go


