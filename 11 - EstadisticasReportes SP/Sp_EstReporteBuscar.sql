-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Buscar estadistica a los Reportes
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.EstReporteBuscar') IS NOT NULL ) 
   DROP PROCEDURE dbo.EstReporteBuscar
GO
CREATE PROCEDURE dbo.EstReporteBuscar
	@ReporteId INT = NULL,
	@Estado  INT = NULL
AS
SET NOCOUNT ON;
BEGIN
	BEGIN TRY
		IF @ReporteId IS NOT NULL --Por Id
			BEGIN
				SELECT EstRepId, ReporteId, Descripcion, 
						FechaEst, Estado, Fecha
					FROM dbo.EstReportes WITH (NOLOCK)
						WHERE ReporteId = @ReporteId
			END
		ELSE IF @ReporteId IS NULL AND @Estado IS NULL --Todos
			BEGIN
				SELECT EstRepId, ReporteId, Descripcion, 
						FechaEst, Estado, Fecha
					FROM dbo.EstReportes WITH (NOLOCK)
			END	
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END