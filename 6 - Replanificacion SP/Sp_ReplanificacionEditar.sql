-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Edita parametros de Proyectos
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ReplanificacionEditar') IS NOT NULL ) 
   DROP PROCEDURE app.ReplanificacionEditar
GO
CREATE PROCEDURE app.ReplanificacionEditar(
	@ReplanId INT,
	@ProyectoId INT,
	@Descripcion VARCHAR(125),
	@FechaAnterior VARCHAR(11),
	@FechaPosterior VARCHAR(11))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF ISNUMERIC(@ReplanId) = 1
			IF @ProyectoId IS NOT NULL AND @ProyectoId <> ''
				IF NOT EXISTS(SELECT ProyectoId
						FROM [app].[Proyectos]
						WHERE ProyectoId = @ProyectoId AND Estado != 0)
					BEGIN
						RAISERROR ('Error! No existe este proyecto', 16, 1);
						RETURN 1;					
					END
				BEGIN
					UPDATE [app].[Replanificacion] SET Descripcion = @Descripcion, 
										FechaAnterior = CONVERT(DATE, @FechaAnterior, 105), 
										FechaPosterior = CONVERT(DATE, @FechaPosterior, 105) 
					WHERE ReplanId = @ReplanId
				END
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO