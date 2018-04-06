-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Agrega SerieReportes
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.SerieReporteInsertar') IS NOT NULL ) 
   DROP PROCEDURE app.SerieReporteInsertar
GO
CREATE PROCEDURE app.SerieReporteInsertar(
	@ReporteId VARCHAR(50),
	@PrimeraSerie VARCHAR(125),
	@SegundaSerie VARCHAR(125),
	@TerceraSerie VARCHAR(125),
	@CuartaSerie VARCHAR(125))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @ReporteId IS NOT NULL
				AND ISNULL(LTRIM(RTRIM(@ReporteId)),'') <> ''
				IF EXISTS(SELECT ReporteId 
								FROM [app].[Reportes]
								WHERE ReporteId = @ReporteId)
				BEGIN
					INSERT INTO [app].[SeriesReportes](ReporteId, PrimeraSerie, SegundaSerie, 
									TerceraSerie, CuartaSerie)
					VALUES(@ReporteId, @PrimeraSerie, @SegundaSerie, @TerceraSerie, @CuartaSerie)
				END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO