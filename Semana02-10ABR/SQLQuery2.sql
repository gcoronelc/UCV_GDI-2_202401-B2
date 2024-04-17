/*
Se necesita el importe de venta por categoria
y el porcentaje que representa del total.

IDCATE   NOMBCATE    VENTA    PORCENTE
============================================
  1      CATE1       67,000    37.02
  2      CATE2       56,000    30.94
  3      CATE3       58,000    32.04
============================================
bd: Northwind
*/

-- Paso 1: Importe de venta por categoría

select 
	p.CategoryID, 
	sum(od.UnitPrice * od.Quantity) importe
from Northwind..[Order Details] od
join Northwind..Products p
on od.ProductID = p.ProductID
group by p.CategoryID;
go


-- Paso 2: Encontrar el importe total de ventas

with
t1 as (
	select 
		p.CategoryID, 
		sum(od.UnitPrice * od.Quantity) importe
	from Northwind..[Order Details] od
	join Northwind..Products p
	on od.ProductID = p.ProductID
	group by p.CategoryID
)
select sum(importe) total from t1;
go


-- Paso 3: Encontrar el importe total de ventas

with
t1 as (
	select 
		p.CategoryID, 
		sum(od.UnitPrice * od.Quantity) importe
	from Northwind..[Order Details] od
	join Northwind..Products p
	on od.ProductID = p.ProductID
	group by p.CategoryID
),
t2 as (select sum(importe) total from t1)
select 
	c.CategoryID, c.CategoryName,
	t1.importe, 
	cast(t1.importe*100.0/t2.total as numeric(10,2)) Porcentaje
from Northwind..Categories c
join t1 on c.CategoryID = t1.CategoryID
cross join t2
go





