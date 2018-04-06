-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Borrado lógico Reportes
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ReporteEliminar') IS NOT NULL ) 
   DROP PROCEDURE app.ReporteEliminar
GO
CREATE PROCEDURE app.ReporteEliminar(
	@ReporteId INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF EXISTS(SELECT ReporteId 
						FROM [app].[Reportes]
						WHERE ReporteId = @ReporteId)
		BEGIN
			UPDATE [app].[Reportes] SET Estado = 0 WHERE ReporteId = @ReporteId
		END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO