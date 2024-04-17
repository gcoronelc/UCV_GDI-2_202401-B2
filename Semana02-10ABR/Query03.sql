Select idcargo, 
count(idempleado) empleados 
from RH..empleado
group by idcargo 
having count(idempleado) > 3
go

select ShipCountry,ShipCity,
COUNT(OrderID) orders
from Northwind..Orders
group by ShipCountry,ShipCity
order by 1,2
go
