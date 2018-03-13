-- =============================================
-- Author: Luis E. Rond�n
-- Create date: 12-03-2018
-- Description: Borrado l�gico Actividades al Reportes
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ActReporteEliminar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ActReporteEliminar
GO
CREATE PROCEDURE dbo.ActReporteEliminar(
	@ActRepId INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @ActRepId IS NOT NULL 			
			IF EXISTS(SELECT ActRepId
							FROM dbo.ActReportes
							WHERE ActRepId = @ActRepId)
				BEGIN
					UPDATE dbo.ActReportes SET Estado = 0
						WHERE ActRepId = @ActRepId
				END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END