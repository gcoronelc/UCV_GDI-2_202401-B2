/*
Calcular la planilla por departamento
*/


select * 
from RH..empleado;
go

select iddepartamento, 
sum(sueldo) planilla1, 
sum(sueldo + isnull(comision,0)) planilla2
from RH..empleado
group by iddepartamento;
go





