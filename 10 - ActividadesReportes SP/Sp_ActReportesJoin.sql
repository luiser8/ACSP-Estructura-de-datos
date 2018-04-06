-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Join Actividades al Reportes
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ActReporteJoin') IS NOT NULL ) 
   DROP PROCEDURE app.ActReporteJoin
GO
CREATE PROCEDURE app.ActReporteJoin
	@ReporteId INT = NULL
AS
SET NOCOUNT ON;
BEGIN
	BEGIN TRY
		IF @ReporteId IS NOT NULL --Por Id
			IF EXISTS(SELECT ReporteId
							FROM [app].[Reportes]
							WHERE ReporteId = @ReporteId)
				BEGIN
					SELECT [app].[ActReportes].ActRepId, [app].[ActReportes].ReporteId,
							[app].[ActReportes].Descripcion, [app].[ActReportes].PrimeraAct,
							[app].[ActReportes].SegundaAct, [app].[ActReportes].TerceraAct,
							[app].[ActReportes].CuartaAct, [app].[ActReportes].Contenido, [app].[ActReportes].SemanaAct,
								[app].[SeriesReportes].SerieRepId, [app].[SeriesReportes].ReporteId,
								[app].[SeriesReportes].PrimeraSerie, [app].[SeriesReportes].SegundaSerie,
								[app].[SeriesReportes].TerceraSerie, [app].[SeriesReportes].CuartaSerie,
									[app].[Reportes].ReporteId, [app].[Reportes].Codigo, 
									[app].[Reportes].UsuarioId, [app].[Reportes].DptoId,
									[app].[Reportes].Nombre, [app].[Reportes].Descripcion, 
									[app].[Reportes].Simbolo, [app].[Reportes].FechaInicio, 
									[app].[Reportes].Anio, [app].[Graficos].GraficoId, [app].[Graficos].Nombre
						 FROM [app].[ActReportes] WITH (NOLOCK)
						 INNER JOIN [app].[Reportes] ON [app].[Reportes].ReporteId = [app].[ActReportes].ReporteId
						 INNER JOIN [app].[SeriesReportes] ON [app].[Reportes].ReporteId = [app].[SeriesReportes].ReporteId
						 INNER JOIN [app].[Graficos] ON [app].[Graficos].GraficoId = [app].[Reportes].GraficoId
							WHERE [app].[ActReportes].ReporteId = @ReporteId AND [app].[ActReportes].SemanaAct IN
								(SELECT MAX([app].[ActReportes].SemanaAct)
									FROM [app].[ActReportes] 
										WHERE [app].[ActReportes].ReporteId = @ReporteId AND [app].[ActReportes].Estado = 1)
				END	
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END