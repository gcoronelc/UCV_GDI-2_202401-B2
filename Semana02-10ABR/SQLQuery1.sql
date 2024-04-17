/*
El empleado con el mayor sueldo por departamento.
BD: RH
*/

-- Solucion 1
-- Paso 1

select iddepartamento, max(sueldo) sueldo_max
from RH..empleado
group by iddepartamento;
go


-- Paso 2: Tabla derivada

select e.*
from RH..empleado e
join (
	select iddepartamento, max(sueldo) sueldo_max
	from RH..empleado
	group by iddepartamento
) t
on e.iddepartamento = t.iddepartamento
and e.sueldo = t.sueldo_max;
go


-- Paso 2: Aplicando CTE

with
t1 as (
	select iddepartamento, max(sueldo) sueldo_max
	from RH..empleado
	group by iddepartamento
)
select * 
from RH..empleado e
join t1 
on e.iddepartamento = t1.iddepartamento
and e.sueldo = t1.sueldo_max;
go

-- Paso 2: Usando ORden Patition
-- Reto








