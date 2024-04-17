
select * 
from Northwind..Orders;
go

select ShipCountry, count( CustomerID) Clientes  
from Northwind..Orders
group by ShipCountry;
go




