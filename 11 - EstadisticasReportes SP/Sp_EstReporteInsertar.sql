-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Agregar estadistica a los Reportes
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.EstReporteInsertar') IS NOT NULL ) 
   DROP PROCEDURE dbo.EstReporteInsertar
GO
CREATE PROCEDURE dbo.EstReporteInsertar(
	@ReporteId INT, 
	@Descripcion VARCHAR(125),
	@FechaEst VARCHAR(11))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @ReporteId IS NOT NULL 
			AND ISNULL(LTRIM(RTRIM(@ReporteId)),'') <> ''
			IF EXISTS(SELECT ReporteId 
							FROM dbo.ActReportes
							WHERE ReporteId = @ReporteId)
			BEGIN
				INSERT INTO dbo.EstReportes(ReporteId, Descripcion, FechaEst)
				VALUES(@ReporteId, @Descripcion, @FechaEst)
			END				
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO