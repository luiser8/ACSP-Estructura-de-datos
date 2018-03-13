-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Editar SerieReportes
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.SerieReporteEditar') IS NOT NULL ) 
   DROP PROCEDURE dbo.SerieReporteEditar
GO
CREATE PROCEDURE dbo.SerieReporteEditar(
	@SerieRepId VARCHAR(50),
	@ReporteId VARCHAR(50),
	@PrimSerie VARCHAR(125),
	@SegSerie VARCHAR(125),
	@TercSerie VARCHAR(125),
	@CuarSerie VARCHAR(125))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY	
		IF ISNUMERIC(@ReporteId) = 1
				IF EXISTS(SELECT ReporteId, @ReporteId
						FROM dbo.SeriesReportes
						WHERE ReporteId = @ReporteId)
				BEGIN
					UPDATE dbo.SeriesReportes SET ReporteId = @ReporteId, PrimSerie = @PrimSerie,
												SegSerie = @SegSerie, TercSerie = @TercSerie,
												CuarSerie = @CuarSerie
												WHERE SerieRepId = @SerieRepId
				END
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO