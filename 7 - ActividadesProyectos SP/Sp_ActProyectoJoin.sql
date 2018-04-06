-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Join Actividades al proyecto
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ActProyectoJoin') IS NOT NULL ) 
   DROP PROCEDURE app.ActProyectoJoin
GO
CREATE PROCEDURE app.ActProyectoJoin
	@ProyectoId INT = NULL
AS
SET NOCOUNT ON;
BEGIN
	BEGIN TRY
		IF @ProyectoId IS NOT NULL --Por Id
			IF EXISTS(SELECT @ProyectoId
							FROM [app].[Proyectos]
							WHERE ProyectoId = @ProyectoId)
				BEGIN
					SELECT [app].[ActProyectos].ActProyId, [app].[ActProyectos].TipoAct, 
							[app].[ActProyectos].ProyectoId, [app].[ActProyectos].ParametroId, 
							[app].[ActProyectos].Descripcion, [app].[ActProyectos].PlanAct, 
							[app].[ActProyectos].RealAct, [app].[ActProyectos].FechaAct, 
							[app].[ActProyectos].Desviacion, [app].[ActProyectos].Estado, 
							[app].[ActProyectos].Fecha,	[app].[Proyectos].Codigo, 
								[app].[Proyectos].FechaInicio, [app].[Proyectos].FechaFin, 
								[app].[Proyectos].Nombre, [app].[Proyectos].Estado, 
									[app].[Graficos].GraficoId, [app].[Graficos].Nombre
								 FROM [app].[ActProyectos] WITH (NOLOCK)
								 INNER JOIN [app].[Proyectos]  ON [app].[Proyectos].ProyectoId = [app].[ActProyectos].ProyectoId
								 INNER JOIN [app].[Graficos]  ON [app].[Graficos].GraficoId = [app].[Proyectos].GraficoId
									WHERE [app].[ActProyectos].ProyectoId = @ProyectoId AND [app].[ActProyectos].Estado = 1
										ORDER BY [app].[ActProyectos].FechaAct
					END	
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END