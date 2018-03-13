-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Borrado lógico SerieReportes
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.SerieReporteEliminar') IS NOT NULL ) 
   DROP PROCEDURE dbo.SerieReporteEliminar
GO
CREATE PROCEDURE dbo.SerieReporteEliminar(
	@ReporteId INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF EXISTS(SELECT ReporteId 
						FROM dbo.SeriesReportes
						WHERE ReporteId = @ReporteId)
		BEGIN
			UPDATE dbo.SeriesReportes SET Estado = 0 WHERE ReporteId = @ReporteId
		END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO