-- OVER PARTITION
-- https://www.sqlshack.com/es/descripcion-general-de-la-clausula-partition-by-de-sql/
/*
OVER ([PARTITION BY columns] [ORDER BY columns])
*/

-- EJEMPLO 1

SELECT ProductID, SUM(Quantity) CANTIDAD
FROM Northwind..[Order Details]
GROUP BY ProductID 
ORDER BY ProductID;
GO

SELECT 
	OrderID,
	ProductID,
	Quantity,
	SUM(Quantity) OVER(PARTITION BY ProductID) CANTIDAD_TOTAL
FROM Northwind..[Order Details];
GO

-- PARTITION BY con ROW_ NUMBER ()
/*
ROW_ NUMBER () OVER (PARTITION BY columns ORDER BY columns)
*/

-- Ejemplo 2

SELECT 
	ShipCountry, 
	ROW_NUMBER() OVER( PARTITION BY ShipCountry ORDER BY OrderID) FILA,
	OrderID, CustomerID
FROM Northwind..Orders;
GO


