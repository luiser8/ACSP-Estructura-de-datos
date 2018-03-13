-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Borrado lógico Actividades al proyecto
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ActProyectoEliminar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ActProyectoEliminar
GO
CREATE PROCEDURE dbo.ActProyectoEliminar(
	@ActProyId INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @ActProyId IS NOT NULL 		
			IF EXISTS(SELECT ActProyId
							FROM dbo.ActProyectos
							WHERE ActProyId = @ActProyId)
				BEGIN
					UPDATE dbo.ActProyectos SET Estado = 0
						WHERE ActProyId = @ActProyId
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END