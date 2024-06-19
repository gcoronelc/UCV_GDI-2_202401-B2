-- PRACTICA DIRIGIDA - RESTAURACION DE LA BASE DE DATOS
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







