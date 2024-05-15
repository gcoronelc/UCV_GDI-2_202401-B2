drop table productos;
go


select * 
into productos
from Products;
go


select * from productos;
go


while(1=1)
begin
	insert into productos
	select ProductName, SupplierID, CategoryID, QuantityPerUnit,
	UnitPrice, UnitsInStock,UnitsOnOrder, ReorderLevel,Discontinued
	from Products;
end;
go


select count(1) from productos;
go


select * from productos
where ProductName ='Gorgonzola Telino';
go


select * from productos
where ProductName like 'Gorgonzola Telino';
go



create nonclustered index idx_productos_ProductName
on productos(ProductName);
go


select * from productos
where ProductName='Gorgonzola Telino';
go



select * from productos
where ProductID=5000000;
go



alter table productos
add constraint pk_productos
primary key ( productid );
go


select * from productos
where ProductID=5000000;
go



select *  
from productos
where CategoryID = 2 and UnitPrice <= 10;
go


select ProductID, ProductName 
from productos
where CategoryID = 2 and UnitPrice <= 10;
go


select * 
from Products p
join Categories c on p.CategoryID = c.CategoryID;
go

select * 
into categorias
from Categories;
go


select * 
from productos p
join categorias c on p.CategoryID = c.CategoryID;
go



-- Consultar el producto masvendido por categoria

select *
from (
	select t.CategoryID, t.ProductID, t.cant,
	RANK() OVER (PARTITION BY t.CategoryID ORDER BY t.cant DESC)
		AS cant_rank
	from (
		select p.CategoryID, p.ProductID,  sum(d.Quantity) cant
		from [Order Details] d
		join Products p on d.ProductID = p.ProductID
		group by p.CategoryID, p.ProductID
	) t
) x
where x.cant_rank = 1;

select p.*
from Products p
join ( 
select *
from (
	select t.CategoryID, t.ProductID, t.cant,
	RANK() OVER (PARTITION BY t.CategoryID ORDER BY t.cant DESC)
		AS cant_rank
	from (
		select p.CategoryID, p.ProductID,  sum(d.Quantity) cant
		from [Order Details] d
		join Products p on d.ProductID = p.ProductID
		group by p.CategoryID, p.ProductID
	) t
) x
where x.cant_rank = 1 ) t
on ( p.CategoryID=t.CategoryID and p.ProductID = t.ProductID );
go
























