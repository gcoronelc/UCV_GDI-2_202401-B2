-- Ejercicio 1: Grupo 7
/*
Desarrollar un procedimiento almacenado que permita
encontrar el mayor de 3 numeros enteros.
*/

use Northwind;
go

create procedure USP_MayorN
(@n1 int, @n2 int, @n3 int, @mayor int output)
as
begin
if @n1 >= @n2 and @n1 >= @n3
begin
set @mayor = @n1
return
end
if @n2 >= @n1 and @n2 >= @n3
begin
set @mayor = @n2
return
end
set @mayor = @n3
end
go

declare @mayor int
exec USP_MayorN 600, 100, 15, @mayor output
select @mayor as mayor
go