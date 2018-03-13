-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Borrado lógico Departamentos
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.DepartamentoEliminar') IS NOT NULL ) 
   DROP PROCEDURE dbo.DepartamentoEliminar
GO
CREATE PROCEDURE dbo.DepartamentoEliminar(
	@DptoId INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF NOT EXISTS(SELECT DptoId 
						FROM dbo.Departamentos
						WHERE DptoId = @DptoId)
			BEGIN
				RAISERROR ('Error! No existe este Departamento', 16, 1);
				RETURN 1;					
			END
		BEGIN
			UPDATE dbo.Departamentos SET Estado = 0
				WHERE DptoId = @DptoId
		END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO