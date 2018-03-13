-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Busca Actividades al proyecto
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ActProyectoBuscar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ActProyectoBuscar
GO
CREATE PROCEDURE dbo.ActProyectoBuscar
	@ActProyId INT = NULL,
	@ProyectoId INT = NULL
AS
SET NOCOUNT ON;
BEGIN
	BEGIN TRY
		IF @ActProyId IS NOT NULL --Por Id
			BEGIN
					SELECT ActProyId, TipoAct, ProyectoId, ParametroId, 
							DescripcionAct, PlanAct, RealAct,
							FechaAct, DesviacionAct, Estado, Fecha
								FROM dbo.ActProyectos WITH (NOLOCK)
									WHERE ActProyId = @ActProyId
				END
			ELSE IF @ProyectoId IS NULL AND @ActProyId IS NULL --Todos
				BEGIN
					SELECT ActProyId, TipoAct, ProyectoId, ParametroId, 
							DescripcionAct, PlanAct, RealAct,
							FechaAct, DesviacionAct, Estado, Fecha
								FROM dbo.ActProyectos WITH (NOLOCK)
				END		
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END