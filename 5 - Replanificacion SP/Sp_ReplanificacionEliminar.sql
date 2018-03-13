-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Borrado lógico replanificacion de Proyectos
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ReplanificacionEliminar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ReplanificacionEliminar
GO
CREATE PROCEDURE dbo.ReplanificacionEliminar(
	@ReplanId INT,
	@ProyectoId INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY	
		IF NOT EXISTS(SELECT ReplanId, ProyectoId
						FROM dbo.Replanificacion
						WHERE ReplanId = @ReplanId AND 
								ProyectoId = @ProyectoId)
					BEGIN
						RAISERROR ('Error! does not exist Project', 16, 1);
						RETURN 1;					
					END
			BEGIN
				UPDATE dbo.Replanificacion SET Estado = 0 
						WHERE ReplanId = @ReplanId AND ProyectoId = @ProyectoId
			END
				IF EXISTS(SELECT ProyectoId, Estado
					FROM dbo.Proyectos
					WHERE ProyectoId = @ProyectoId AND
							Estado = 3)			
					BEGIN
						UPDATE dbo.Proyectos SET Estado = 1
						WHERE ProyectoId = @ProyectoId
					END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO