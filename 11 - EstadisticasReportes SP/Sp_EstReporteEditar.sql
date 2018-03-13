-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Editar estadistica a los Reportes
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.EstReporteEditar') IS NOT NULL ) 
   DROP PROCEDURE dbo.EstReporteEditar
GO
CREATE PROCEDURE dbo.EstReporteEditar(
	@EstRepId INT,
	@ReporteId INT, 
	@Descripcion VARCHAR(125),
	@FechaEst VARCHAR(11))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @EstRepId IS NOT NULL			
			IF EXISTS(SELECT EstRepId, ReporteId 
							FROM dbo.EstReportes
							WHERE EstRepId = @EstRepId)
				BEGIN
					UPDATE dbo.EstReportes
						SET ReporteId = @ReporteId, 
							Descripcion = @Descripcion, 
							FechaEst = @FechaEst
								WHERE EstRepId = @EstRepId
				END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO