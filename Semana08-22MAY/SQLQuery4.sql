-- Ejercicio 2: Grupo 11
/*
Desarrollar un procedimiento que permita obtener la comision
de un empleado en un determinado mes.
La comision por venta es el 3% del importe de la venta.
*/

use Northwind
go

ALTER PROCEDURE Obtenercomision
(@EmployeeID INT, @Mes INT, @Anio INT, @Comision DECIMAL(10,2)OUTPUT)
as
begin
select @Comision =  sum (od.Quantity * od.UnitPrice)
from [Order Details] OD
join Orders O ON OD.OrderID=O.OrderID 
Where o.EmployeeID=@EmployeeID
and MONTH(o.OrderDate) = @Mes 
and year(o.OrderDate) = @Anio;
SET @Comision = @Comision * 0.03;
end;
go


DECLARE @Comision DECIMAL(10,2);
execute Obtenercomision 2, 4,1997,@Comision output
PRINT 'COMISION: ' + CAST (@COMISION AS VARCHAR(20))
go

SELECT * FROM Employees
go
