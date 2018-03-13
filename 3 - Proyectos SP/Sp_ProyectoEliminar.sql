-- =============================================
-- Author: Luis E. Rond�n
-- Create date: 12-03-2018
-- Description: Borrado l�gico Proyectos
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ProyectoEliminar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ProyectoEliminar
GO
CREATE PROCEDURE dbo.ProyectoEliminar(
	@ProyectoId INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY	
		IF NOT EXISTS(SELECT ProyectoId 
						FROM dbo.Proyectos
						WHERE ProyectoId = @ProyectoId)
				BEGIN
					RAISERROR ('Error! No existe este proyecto', 16, 1);
					RETURN 1;
				END	
		BEGIN
			UPDATE dbo.Proyectos SET Estado = 0 WHERE ProyectoId = @ProyectoId
		END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO