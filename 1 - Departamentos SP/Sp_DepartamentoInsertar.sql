-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Agrega los Departamentos
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.DepartamentoInsertar') IS NOT NULL ) 
   DROP PROCEDURE dbo.DepartamentoInsertar
GO
CREATE PROCEDURE dbo.DepartamentoInsertar(
	@Nombre VARCHAR(50),
	@Descripcion VARCHAR(125))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @Nombre IS NOT NULL 
			AND ISNULL(LTRIM(RTRIM(@Nombre)),'') <> ''
			IF EXISTS(SELECT Nombre
							FROM dbo.Departamentos
							WHERE Nombre = @Nombre)
				BEGIN
					RAISERROR ('Error! Existe este Departamento!', 16, 1);
					RETURN 1;					
				END
			BEGIN
				INSERT INTO dbo.Departamentos(Nombre, Descripcion)
				VALUES(@Nombre, @Descripcion)
			END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO