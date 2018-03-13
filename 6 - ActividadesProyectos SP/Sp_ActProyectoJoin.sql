-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Join Actividades al proyecto
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ActProyectoJoin') IS NOT NULL ) 
   DROP PROCEDURE dbo.ActProyectoJoin
GO
CREATE PROCEDURE dbo.ActProyectoJoin
	@ProyectoId INT = NULL
AS
SET NOCOUNT ON;
BEGIN
	BEGIN TRY
		IF @ProyectoId IS NOT NULL --Por Id
			IF EXISTS(SELECT @ProyectoId
							FROM dbo.Proyectos
							WHERE ProyectoId = @ProyectoId)
				BEGIN
					SELECT ActProyectos.ActProyId, 
							ActProyectos.TipoAct, ActProyectos.ProyectoId, 
							ActProyectos.ParametroId, ActProyectos.DescripcionAct,
							ActProyectos.PlanAct, ActProyectos.RealAct,
							ActProyectos.FechaAct, ActProyectos.DesviacionAct,
							ActProyectos.Estado, ActProyectos.Fecha,
								Proyectos.Codigo, Proyectos.FechaInicio, 
								Proyectos.FechaFin, Proyectos.Nombre,
								Proyectos.Estado, Proyectos.Grafico
								 FROM dbo.ActProyectos WITH (NOLOCK)
								 INNER JOIN Proyectos AS Proyectos ON Proyectos.ProyectoId = ActProyectos.ProyectoId
									WHERE ActProyectos.ProyectoId = @ProyectoId
										ORDER BY ActProyectos.FechaAct
					END	
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END