-- =============================================
-- Author: Luis E. Rond�n
-- Create date: 12-03-2018
-- Description: Busca Proyectos
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ProyectoBuscar') IS NOT NULL ) 
   DROP PROCEDURE app.ProyectoBuscar
GO
CREATE PROCEDURE app.ProyectoBuscar
	@ProyectoId INT = NULL,
	@Estado BIT = NULL
AS
BEGIN
	BEGIN TRY
			IF @ProyectoId IS NOT NULL --Por Id
				BEGIN
					SELECT ProyectoId, Codigo, DptoId,
							UsuarioId, Nombre, Descripcion,
							 GraficoId, Anio, FechaInicio,
							  FechaFin, Estado, Fecha 
								FROM [app].[Proyectos] WITH (NOLOCK)
									WHERE ProyectoId = @ProyectoId
				END
			ELSE IF @ProyectoId IS NULL AND @Estado IS NULL --Todos
				BEGIN
						SELECT ProyectoId, Codigo, DptoId,
							UsuarioId, Nombre, Descripcion,
							 GraficoId, Anio, FechaInicio,
							  FechaFin, Estado, Fecha 
								FROM [app].[Proyectos] WITH (NOLOCK)
				END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
					ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO