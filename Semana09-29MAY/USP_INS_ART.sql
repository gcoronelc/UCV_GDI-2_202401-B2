
alter procedure usp_reg_art
(
	@catego int,
	@nombre varchar(35),
	@precio money,
	@codigo char(8) output,
	@estado int output,
	@mensaje varchar(200) output
)
as
declare @conta int, @prefijo char(3);
begin
	BEGIN TRY
		-- Paso 1: Inicio de transaccion
		BEGIN TRANSACTION;
		-- Paso 2: Validar precio
		if(@precio<=0.0)
			RAISERROR('El precio debe ser un valor positivo.',16,1);
		-- Paso 3: Validar si existe la categoria
		select @conta = count(1) from Categoria
		where IdCategoria = @catego;
		if(@conta <> 1)
			RAISERROR('La categoria no existe.',16,1);
		-- Paso 4: Incrementar el contador
		update Categoria
		set ConCategoria = ConCategoria + 1
		where IdCategoria = @catego;
		if(@@ROWCOUNT <> 1)
			RAISERROR('No se puede actualizar el contador.',16,1);
		-- Paso 5: Obtener datos para elcodigo delarticulo
		select @prefijo = Prefijo, @conta = ConCategoria
		from Categoria where IdCategoria = @catego;
		if(@@ROWCOUNT <> 1)
			RAISERROR('No se pudo leer los datos para el codigo.',16,1);
		-- Paso 6: Crear el nuevo codigo
		set @codigo = CONCAT('00000',cast(@conta as varchar(10)));
		print @codigo;
		set @codigo = concat(@prefijo,RIGHT(trim(@codigo),5));
		-- Paso 7: Registrar articulo
		insert into Articulo(IdArticulo,IdCategoria,NomArticulo,PreArticulo)
		values(@codigo,@catego,@nombre,@precio);
		-- Paso 8: Confirmar transaccion
		COMMIT TRANSACTION;
		set @estado = 1;
		set @mensaje = 'Proceso ejecutado vorrectamente.';
	END TRY
	BEGIN CATCH
		set @estado = -1;
		set @mensaje = ERROR_MESSAGE();
		-- Cancela la transaccion
		ROLLBACK TRANSACTION;
	END CATCH;
end;
go


declare @codigo char(8), @estado int, @mensaje varchar(200);
exec usp_reg_art 2, 'Demo', 50.0, 
	@codigo output, @estado output, @mensaje output;
select @codigo, @estado, @mensaje;
go






