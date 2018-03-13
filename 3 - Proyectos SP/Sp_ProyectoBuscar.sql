-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Busca Proyectos
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ProyectoBuscar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ProyectoBuscar
GO
CREATE PROCEDURE dbo.ProyectoBuscar
	@ProyectoId INT = NULL,
	@Estado INT = NULL
AS
BEGIN
	BEGIN TRY
			IF @ProyectoId IS NOT NULL --Por Id
				BEGIN
					SELECT ProyectoId, Codigo, DptoId,
							UsuarioId, Nombre, Descripcion,
							 Grafico, Anio, FechaInicio,
							  FechaFin, Estado, Fecha 
								FROM dbo.Proyectos WITH (NOLOCK)
									WHERE ProyectoId = @ProyectoId
				END
			ELSE IF @ProyectoId IS NULL AND @Estado IS NULL --Todos
				BEGIN
						SELECT ProyectoId, Codigo, DptoId,
							UsuarioId, Nombre, Descripcion,
							 Grafico, Anio, FechaInicio,
							  FechaFin, Estado, Fecha 
								FROM dbo.Proyectos WITH (NOLOCK)
				END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
					ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO