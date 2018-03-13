-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Edita parametros de Proyectos
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ReplanificacionEditar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ReplanificacionEditar
GO
CREATE PROCEDURE dbo.ReplanificacionEditar(
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
						FROM dbo.Proyectos
						WHERE ProyectoId = @ProyectoId AND Estado != 0)
					BEGIN
						RAISERROR ('Error! No existe este proyecto', 16, 1);
						RETURN 1;					
					END
				BEGIN
					UPDATE dbo.Replanificacion SET Descripcion = @Descripcion, 
										FechaAnterior = @FechaAnterior, 
										FechaPosterior = @FechaPosterior 
					WHERE ReplanId = @ReplanId
				END
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO