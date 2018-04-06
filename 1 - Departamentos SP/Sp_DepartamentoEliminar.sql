-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Borrado lógico Departamentos
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.DepartamentoEliminar') IS NOT NULL ) 
   DROP PROCEDURE app.DepartamentoEliminar
GO
CREATE PROCEDURE app.DepartamentoEliminar(
	@DptoId INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF NOT EXISTS(SELECT DptoId 
						FROM [app].[Departamentos]
						WHERE DptoId = @DptoId)
			BEGIN
				RAISERROR ('Error! No existe este Departamento', 16, 1);
				RETURN 1;					
			END
		BEGIN
			UPDATE [app].[Departamentos] SET Estado = 0
				WHERE DptoId = @DptoId
		END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO