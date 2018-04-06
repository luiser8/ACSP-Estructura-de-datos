-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Busca Actividades al proyecto
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ActProyectoBuscar') IS NOT NULL ) 
   DROP PROCEDURE app.ActProyectoBuscar
GO
CREATE PROCEDURE app.ActProyectoBuscar
	@ActProyId INT = NULL,
	@ProyectoId INT = NULL
AS
SET NOCOUNT ON;
BEGIN
	BEGIN TRY
		IF @ActProyId IS NOT NULL --Por Id
			BEGIN
					SELECT ActProyId, TipoAct, ProyectoId, ParametroId, 
							Descripcion, PlanAct, RealAct,
							FechaAct, Desviacion, Estado, Fecha
								FROM [app].[ActProyectos] WITH (NOLOCK)
									WHERE ActProyId = @ActProyId
				END
			ELSE IF @ProyectoId IS NULL AND @ActProyId IS NULL --Todos
				BEGIN
					SELECT ActProyId, TipoAct, ProyectoId, ParametroId, 
							Descripcion, PlanAct, RealAct,
							FechaAct, Desviacion, Estado, Fecha
								FROM [app].[ActProyectos] WITH (NOLOCK)
				END		
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END