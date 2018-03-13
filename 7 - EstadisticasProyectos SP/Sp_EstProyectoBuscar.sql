-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Buscar Estadistica del proyecto
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.EstProyectoBuscar') IS NOT NULL ) 
   DROP PROCEDURE dbo.EstProyectoBuscar
GO
CREATE PROCEDURE dbo.EstProyectoBuscar
	@ProyectoId INT = NULL,
	@Estado INT = NULL
AS
SET NOCOUNT ON;
BEGIN
	BEGIN TRY
	IF @ProyectoId IS NOT NULL --Por Id
				BEGIN
					SELECT EstProyId, ProyectoId, PlanEst,
							RealEst, FechacEst, Estado, Fecha
						FROM dbo.EstProyectos WITH (NOLOCK)
							WHERE ProyectoId = @ProyectoId
				END
			ELSE IF @ProyectoId IS NULL AND @Estado IS NULL --Todos
				BEGIN
						SELECT EstProyId, ProyectoId, PlanEst,
								RealEst, FechacEst, Estado, Fecha
							FROM dbo.EstProyectos WITH (NOLOCK)
				END	
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END