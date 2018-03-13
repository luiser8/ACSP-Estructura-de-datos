-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Borrado lógico estadistica a los Reportes
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.EstReporteEliminar') IS NOT NULL ) 
   DROP PROCEDURE dbo.EstReporteEliminar
GO
CREATE PROCEDURE dbo.EstReporteEliminar(
	@EstRepId INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @EstRepId IS NOT NULL 		
			IF EXISTS(SELECT EstRepId
							FROM dbo.EstReportes
							WHERE EstRepId = @EstRepId)
				BEGIN
					UPDATE dbo.EstReportes SET Estado = 0 
						WHERE EstRepId = @EstRepId
				END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END