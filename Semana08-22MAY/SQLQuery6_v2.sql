-- Ejercicio 4: Grupo 12
/*
Crear un procedimiento que permita consultar la cantidad
de productos y el importe respectivo que se han despachado 
a brasil en un determinado semestre.
El parametro @estado vale 1 si hay filas y -1 si nolo hay
*/


ALTER PROCEDURE ConsultarVentasBrazilNorthwind
    @anio INT,
    @mes  INT,
	@estado INT OUTPUT,
	@cantidad INT  OUTPUT,
    @importe DECIMAL(10,2) OUTPUT
AS 
BEGIN
    SELECT
	 @cantidad = SUM(od.Quantity), 
	 @importe = SUM(od.UnitPrice * od.Quantity)
    FROM [Order Details] od
    INNER JOIN Orders o ON od.OrderID = o.OrderID
    WHERE o.ShipCountry = 'Brazil' 
	and MONTH(o.OrderDate) = @mes 
    and year(o.OrderDate) = @anio;
END;
GO

DECLARE @cantidad INT, @importe DECIMAL(10,2);
EXEC ConsultarVentasBrazilNorthwind 1999, 1, @cantidad OUTPUT, @importe OUTPUT
PRINT 'La cantidad es: ' + CAST(@cantidad AS VARCHAR(20))
PRINT 'El importe es: ' + CAST(@importe AS VARCHAR(20))
GO