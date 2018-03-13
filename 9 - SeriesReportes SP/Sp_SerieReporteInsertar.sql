-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Agrega SerieReportes
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.SerieReporteInsertar') IS NOT NULL ) 
   DROP PROCEDURE dbo.SerieReporteInsertar
GO
CREATE PROCEDURE dbo.SerieReporteInsertar(
	@ReporteId VARCHAR(50),
	@PrimSerie VARCHAR(125),
	@SegSerie VARCHAR(125),
	@TercSerie VARCHAR(125),
	@CuarSerie VARCHAR(125))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @ReporteId IS NOT NULL
				AND ISNULL(LTRIM(RTRIM(@ReporteId)),'') <> ''
				IF EXISTS(SELECT ReporteId 
								FROM dbo.Reportes
								WHERE ReporteId = @ReporteId)
				BEGIN
					INSERT INTO dbo.SeriesReportes(ReporteId, PrimSerie, SegSerie, 
									TercSerie, CuarSerie)
					VALUES(@ReporteId, @PrimSerie, @SegSerie, @TercSerie, @CuarSerie)
				END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO