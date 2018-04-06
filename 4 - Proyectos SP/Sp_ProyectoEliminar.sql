-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Borrado lógico Proyectos
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ProyectoEliminar') IS NOT NULL ) 
   DROP PROCEDURE app.ProyectoEliminar
GO
CREATE PROCEDURE app.ProyectoEliminar(
	@ProyectoId INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY	
		IF NOT EXISTS(SELECT ProyectoId 
						FROM [app].[Proyectos]
						WHERE ProyectoId = @ProyectoId)
				BEGIN
					RAISERROR ('Error! No existe este proyecto', 16, 1);
					RETURN 1;
				END	
		BEGIN
			UPDATE [app].[Proyectos] SET Estado = 0 WHERE ProyectoId = @ProyectoId
		END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO