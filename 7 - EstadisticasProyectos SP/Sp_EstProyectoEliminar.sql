-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Borrado lógico Estadistica del proyecto
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.EstProyectoEliminar') IS NOT NULL ) 
   DROP PROCEDURE dbo.EstProyectoEliminar
GO
CREATE PROCEDURE dbo.EstProyectoEliminar(
	@EstProyId INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @EstProyId IS NOT NULL 
			
			IF EXISTS(SELECT EstProyId 
							FROM dbo.EstProyectos
							WHERE EstProyId = @EstProyId)
				BEGIN
					UPDATE dbo.EstProyectos SET Estado = 0
						WHERE EstProyId = @EstProyId
				END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END