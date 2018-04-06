-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Borrado lógico Actividades al Reportes
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ActReporteEliminar') IS NOT NULL ) 
   DROP PROCEDURE app.ActReporteEliminar
GO
CREATE PROCEDURE app.ActReporteEliminar(
	@ActRepId INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @ActRepId IS NOT NULL 			
			IF EXISTS(SELECT ActRepId
							FROM [app].[ActReportes]
							WHERE ActRepId = @ActRepId)
				BEGIN
					UPDATE [app].[ActReportes] SET Estado = 0
						WHERE ActRepId = @ActRepId
				END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END