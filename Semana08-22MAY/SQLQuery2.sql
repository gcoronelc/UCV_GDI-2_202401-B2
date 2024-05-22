alter PROCEDURE USP_EJERCICIO_02
AS
BEGIN
	DECLARE @pub_id CHAR(4);
	DECLARE @pub_name VARCHAR(40);
	DECLARE @total_books INT;
	-- Declarando el cursor
	DECLARE pub_cursor CURSOR FOR
	SELECT pub_id, pub_name 
	FROM publishers;
	-- Abrir el cursor
	OPEN pub_cursor;
	-- Lee la primera fila
	FETCH NEXT FROM pub_cursor INTO @pub_id, @pub_name;
	-- Verifica si la lectura tiene exito
	WHILE @@FETCH_STATUS = 0
	BEGIN
		-- Cuenta las publicaciones de la editorial
		SELECT @total_books = COUNT(*)
		FROM titles
		WHERE pub_id = @pub_id;
		-- Imprime el resultado
		IF( @total_books > 5 )
			PRINT @pub_name + ' - Total Books: ' + CAST(@total_books AS VARCHAR(10));
		-- Lee la siguiente fila
		FETCH NEXT FROM pub_cursor INTO @pub_id, @pub_name;
	END;
	-- Cierra el cursor
	CLOSE pub_cursor;
	-- Libera los recursos
	DEALLOCATE pub_cursor;
END;
GO


EXEC USP_EJERCICIO_02;
GO

