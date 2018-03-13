-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Busca replanificacion de Proyectos
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ReplanificacionBuscar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ReplanificacionBuscar
GO
CREATE PROCEDURE dbo.ReplanificacionBuscar
	@ReplanId INT = NULL,
	@Estado INT = NULL
AS
BEGIN
	BEGIN TRY
		IF @ReplanId IS NOT NULL --Por Id
			BEGIN
					SELECT ReplanId, ProyectoId, Descripcion,
							FechaAnterior, FechaPosterior, Estado, Fecha 
								FROM dbo.Replanificacion WITH (NOLOCK)
									WHERE ReplanId = @ReplanId
				END
			ELSE IF @ReplanId IS NULL AND @Estado IS NULL --Todos
				BEGIN
					SELECT ReplanId, ProyectoId, Descripcion,
							FechaAnterior, FechaPosterior, Estado, Fecha 
								FROM dbo.Replanificacion WITH (NOLOCK)
				END
	END TRY
	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO