-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Agrega replanificacion de Proyectos
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ReplanificacionInsertar') IS NOT NULL ) 
   DROP PROCEDURE app.ReplanificacionInsertar
GO
CREATE PROCEDURE app.ReplanificacionInsertar(
	@ProyectoId VARCHAR(50),
	@Descripcion VARCHAR(125),
	@FechaAnterior VARCHAR(11),
	@FechaPosterior VARCHAR(11))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @ProyectoId IS NOT NULL 
			AND ISNULL(LTRIM(RTRIM(@ProyectoId)),'') <> ''
				IF EXISTS(SELECT ProyectoId, Estado
							FROM [app].[Proyectos]
							WHERE ProyectoId = @ProyectoId AND Estado = 0)
						BEGIN
							RAISERROR('Error! No existe este proyecto', 16, 1);
							RETURN 1;					
						END 
			BEGIN
				IF NOT EXISTS(SELECT ProyectoId
								FROM [app].[Replanificacion]
								WHERE ProyectoId = @ProyectoId AND Estado = 1)
					BEGIN
						INSERT INTO [app].[Replanificacion](ProyectoId, Descripcion,
											FechaAnterior, FechaPosterior)
						VALUES(@ProyectoId, @Descripcion, CONVERT(DATE, @FechaAnterior, 105), CONVERT(DATE, @FechaPosterior, 105))						
					END	
			END			
				IF EXISTS(SELECT ProyectoId, Estado
							FROM [app].[Proyectos]
							WHERE ProyectoId = @ProyectoId AND
									Estado != 3)
				BEGIN
					UPDATE [app].[Proyectos] SET Estado = 3
					WHERE ProyectoId = @ProyectoId
				END			
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO