-- Ejercicio 3: Grupo 1
/*
Crear un procedimiento almacenado que permita
obtener el precio de un producto, si el producto
no existe debe retornar -1.
El valor de retorno debe ser mediante un parametro de salida.
*/

Alter procedure ObtenerPrecioProducto
(@ProductoID INT,
 @Precio Decimal (10, 2) Output
 )
 As
 Begin
	 Select @Precio = UnitPrice
	 From dbo.Products 
	 Where ProductID = @ProductoID;
	 If @@ROWCOUNT = 0
		Set @Precio = -1;
 END
 Go

DECLARE @Precio Decimal(10,2);
execute ObtenerPrecioProducto 99999,@Precio output
PRINT 'Precio: ' + CAST (@Precio AS VARCHAR(20))
go
