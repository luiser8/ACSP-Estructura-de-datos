-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Buscar SerieReportes
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.SerieReporteBuscar') IS NOT NULL ) 
   DROP PROCEDURE app.SerieReporteBuscar
GO
CREATE PROCEDURE app.SerieReporteBuscar
	@ReporteId INT = NULL,
	@Estado BIT = NULL
AS
BEGIN
	BEGIN TRY
		IF @ReporteId IS NOT NULL --Por Id
			BEGIN
				SELECT SerieRepId, ReporteId, PrimeraSerie, 
						SegundaSerie, TerceraSerie, CuartaSerie, 
							Estado, Fecha
								FROM [app].[SeriesReportes] WITH (NOLOCK)
									WHERE ReporteId = @ReporteId
			END
		ELSE IF @ReporteId IS NULL AND @Estado IS NULL --Todos
			BEGIN
				SELECT SerieRepId, ReporteId, PrimeraSerie, 
						SegundaSerie, TerceraSerie, CuartaSerie, 
							Estado, Fecha
								FROM [app].[SeriesReportes] WITH (NOLOCK)
			END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO