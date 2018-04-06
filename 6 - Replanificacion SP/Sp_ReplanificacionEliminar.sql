-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Borrado lógico replanificacion de Proyectos
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ReplanificacionEliminar') IS NOT NULL ) 
   DROP PROCEDURE app.ReplanificacionEliminar
GO
CREATE PROCEDURE app.ReplanificacionEliminar(
	@ReplanId INT,
	@ProyectoId INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY	
		IF NOT EXISTS(SELECT ReplanId, ProyectoId
						FROM [app].[Replanificacion]
						WHERE ReplanId = @ReplanId AND 
								ProyectoId = @ProyectoId)
					BEGIN
						RAISERROR ('Error! does not exist Project', 16, 1);
						RETURN 1;					
					END
			BEGIN
				UPDATE [app].[Replanificacion] SET Estado = 0 
						WHERE ReplanId = @ReplanId AND ProyectoId = @ProyectoId
			END
				IF EXISTS(SELECT ProyectoId, Estado
					FROM [app].[Proyectos]
					WHERE ProyectoId = @ProyectoId AND
							Estado = 3)			
					BEGIN
						UPDATE [app].[Proyectos] SET Estado = 1
						WHERE ProyectoId = @ProyectoId
					END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO