-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Buscar Actividades al Reportes
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ActReporteBuscar') IS NOT NULL ) 
   DROP PROCEDURE app.ActReporteBuscar
GO
CREATE PROCEDURE app.ActReporteBuscar
	@ActRepId INT = NULL,
	@ReporteId INT = NULL
AS
SET NOCOUNT ON;
BEGIN
	BEGIN TRY
		IF @ActRepId IS NOT NULL --Por Id
			BEGIN
				SELECT ActRepId, ReporteId, Descripcion, PrimeraAct, 
						SegundaAct, TerceraAct, CuartaAct, 
							SemanaAct, Contenido, Estado, Fecha
							FROM [app].[ActReportes] WITH (NOLOCK)
								WHERE ActRepId = @ActRepId
			END
		ELSE IF @ReporteId IS NULL AND @ActRepId IS NULL --Todos
			BEGIN
				SELECT ActRepId, ReporteId, Descripcion, PrimeraAct, 
						SegundaAct, TerceraAct, CuartaAct, 
							SemanaAct, Contenido, Estado, Fecha
							FROM [app].[ActReportes] WITH (NOLOCK)
			END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END