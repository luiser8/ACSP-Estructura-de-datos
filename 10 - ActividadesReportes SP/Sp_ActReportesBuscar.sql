-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Buscar Actividades al Reportes
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ActReporteBuscar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ActReporteBuscar
GO
CREATE PROCEDURE dbo.ActReporteBuscar
	@ActRepId INT = NULL,
	@ReporteId INT = NULL
AS
SET NOCOUNT ON;
BEGIN
	BEGIN TRY
		IF @ActRepId IS NOT NULL --Por Id
			BEGIN
				SELECT ActRepId, ReporteId, DescAct, PrimAct, 
						SegAct, TercAct, CuartAct, 
							SemAct, Contenido, Estado, Fecha
							FROM dbo.ActReportes WITH (NOLOCK)
								WHERE ActRepId = @ActRepId
			END
		ELSE IF @ReporteId IS NULL AND @ActRepId IS NULL --Todos
			BEGIN
				SELECT ActRepId, ReporteId, DescAct, PrimAct, 
						SegAct, TercAct, CuartAct, 
							SemAct, Contenido, Estado, Fecha
							FROM dbo.ActReportes WITH (NOLOCK)
			END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END