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












