-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Borrado lógico SerieReportes
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.SerieReporteEliminar') IS NOT NULL ) 
   DROP PROCEDURE app.SerieReporteEliminar
GO
CREATE PROCEDURE app.SerieReporteEliminar(
	@ReporteId INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF EXISTS(SELECT ReporteId 
						FROM [app].[SeriesReportes]
						WHERE ReporteId = @ReporteId)
		BEGIN
			UPDATE [app].[SeriesReportes] SET Estado = 0 WHERE ReporteId = @ReporteId
		END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO