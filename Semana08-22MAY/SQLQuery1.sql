CREATE PROCEDURE USP_EJERCICIO_01
AS
BEGIN
	DECLARE @title_id VARCHAR(6);
	DECLARE @title VARCHAR(80);
	DECLARE @fname VARCHAR(20);
	DECLARE @lname VARCHAR(30);

	DECLARE title_cursor CURSOR FOR
	SELECT title_id, title 
	FROM titles;

	OPEN title_cursor

	-- Se lee la primera fila
	FETCH NEXT FROM title_cursor INTO @title_id, @title;

	WHILE @@FETCH_STATUS = 0
	BEGIN

		-- Autor del libro
		SELECT @fname = au_fname, @lname = au_lname
		FROM authors a
		JOIN titleauthor ta ON a.au_id = ta.au_id
		WHERE ta.title_id = @title_id;
		-- Imprime el autor
		PRINT @title + ' - ' + @fname + ' ' + @lname;
		-- Lee el siguiente libro
		FETCH NEXT FROM title_cursor INTO @title_id, @title;
	END

	CLOSE title_cursor;
	DEALLOCATE title_cursor;
END;
GO



EXEC USP_EJERCICIO_01;
GO



