-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Edita los Departamentos
-- =============================================
IF ( OBJECT_ID('dbo.DepartamentoEditar') IS NOT NULL ) 
   DROP PROCEDURE dbo.DepartamentoEditar
GO
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
CREATE PROCEDURE dbo.DepartamentoEditar(
	@DptoId INT,
	@Nombre VARCHAR(50),
	@Descripcion VARCHAR(125))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF ISNUMERIC(@DptoId) = 1
			IF @DptoId IS NOT NULL AND @DptoId <> ''
				AND ISNULL(LTRIM(RTRIM(@Nombre)),'') <> ''
				IF NOT EXISTS(SELECT DptoId 
						FROM dbo.Departamentos
						WHERE DptoId = @DptoId)
					BEGIN
						RAISERROR ('Error! No existe este Departamento', 16, 1);
						RETURN 1;					
					END
				BEGIN
					UPDATE dbo.Departamentos SET Nombre = @Nombre,
										Descripcion = @Descripcion
					WHERE DptoId = @DptoId
				END
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO