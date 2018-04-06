-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Busca replanificacion de Proyectos
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ReplanificacionBuscar') IS NOT NULL ) 
   DROP PROCEDURE app.ReplanificacionBuscar
GO
CREATE PROCEDURE app.ReplanificacionBuscar
	@ReplanId INT = NULL,
	@Estado BIT = NULL
AS
BEGIN
	BEGIN TRY
		IF @ReplanId IS NOT NULL --Por Id
			BEGIN
					SELECT ReplanId, ProyectoId, Descripcion,
							FechaAnterior, FechaPosterior, Estado, Fecha 
								FROM [app].[Replanificacion] WITH (NOLOCK)
									WHERE ReplanId = @ReplanId
				END
			ELSE IF @ReplanId IS NULL AND @Estado IS NULL --Todos
				BEGIN
					SELECT ReplanId, ProyectoId, Descripcion,
							FechaAnterior, FechaPosterior, Estado, Fecha 
								FROM [app].[Replanificacion] WITH (NOLOCK)
				END
	END TRY
	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO