-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Join Actividades al Reportes
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ActReporteJoin') IS NOT NULL ) 
   DROP PROCEDURE dbo.ActReporteJoin
GO
CREATE PROCEDURE dbo.ActReporteJoin
	@ReporteId INT = NULL
AS
SET NOCOUNT ON;
BEGIN
	BEGIN TRY
		IF @ReporteId IS NOT NULL --Por Id
			IF EXISTS(SELECT ReporteId
							FROM dbo.Reportes
							WHERE ReporteId = @ReporteId)
				BEGIN
					SELECT ActReportes.ActRepId, ActReportes.ReporteId,
							ActReportes.DescAct, ActReportes.PrimAct,
							ActReportes.SegAct, ActReportes.TercAct,
							ActReportes.CuartAct, ActReportes.Contenido, ActReportes.SemAct,
								SeriesReportes.SerieRepId, SeriesReportes.ReporteId,
								SeriesReportes.PrimSerie, SeriesReportes.SegSerie,
								SeriesReportes.TercSerie, SeriesReportes.CuarSerie,
									Reportes.ReporteId, Reportes.Codigo, 
									Reportes.UsuarioId, Reportes.DptoId,
									Reportes.Nombre, Reportes.Descripcion, 
									Reportes.Grafico, Reportes.Simbolo,
									Reportes.FechaInicio, Reportes.Anio
						 FROM dbo.ActReportes WITH (NOLOCK)
						 INNER JOIN Reportes AS Reportes ON Reportes.ReporteId = ActReportes.ReporteId
						 LEFT OUTER JOIN SeriesReportes AS SeriesReportes ON Reportes.ReporteId = SeriesReportes.ReporteId
							WHERE ActReportes.ReporteId = @ReporteId AND ActReportes.SemAct IN
								(SELECT MAX(ActReportes.SemAct)
									FROM dbo.ActReportes 
										WHERE ActReportes.ReporteId = @ReporteId)
				END	
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END