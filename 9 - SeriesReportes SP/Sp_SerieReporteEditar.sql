-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Editar SerieReportes
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.SerieReporteEditar') IS NOT NULL ) 
   DROP PROCEDURE app.SerieReporteEditar
GO
CREATE PROCEDURE app.SerieReporteEditar(
	@SerieRepId VARCHAR(50),
	@ReporteId VARCHAR(50),
	@PrimeraSerie VARCHAR(125),
	@SegundaSerie VARCHAR(125),
	@TerceraSerie VARCHAR(125),
	@CuartaSerie VARCHAR(125))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY	
		IF ISNUMERIC(@ReporteId) = 1
				IF EXISTS(SELECT ReporteId, @ReporteId
						FROM [app].[SeriesReportes]
						WHERE ReporteId = @ReporteId)
				BEGIN
					UPDATE [app].[SeriesReportes] SET ReporteId = @ReporteId, PrimeraSerie = @PrimeraSerie,
												SegundaSerie = @SegundaSerie, TerceraSerie = @TerceraSerie,
												CuartaSerie = @CuartaSerie
												WHERE SerieRepId = @SerieRepId
				END
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO