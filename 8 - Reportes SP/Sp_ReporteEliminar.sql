-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Borrado lógico Reportes
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ReporteEliminar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ReporteEliminar
GO
CREATE PROCEDURE dbo.ReporteEliminar(
	@ReporteId INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF EXISTS(SELECT ReporteId 
						FROM dbo.Reportes
						WHERE ReporteId = @ReporteId)
		BEGIN
			UPDATE dbo.Reportes SET Estado = 0 WHERE ReporteId = @ReporteId
		END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO