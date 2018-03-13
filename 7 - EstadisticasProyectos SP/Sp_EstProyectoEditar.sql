-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Editar Estadistica del proyecto
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.EstProyectoEditar') IS NOT NULL ) 
   DROP PROCEDURE dbo.EstProyectoEditar
GO
CREATE PROCEDURE dbo.EstProyectoEditar(
	@EstProyId INT,
	@ProyectoId INT, 
	@PlanEst VARCHAR(11),
	@RealEst VARCHAR(11),
	@FechacEst VARCHAR(11))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @EstProyId IS NOT NULL
			
			IF EXISTS(SELECT EstProyId, ProyectoId 
							FROM dbo.EstProyectos
							WHERE EstProyId = @EstProyId AND
								ProyectoId = @ProyectoId)
				BEGIN
					UPDATE dbo.EstProyectos
						SET PlanEst = @PlanEst, 
							RealEst = @RealEst, 
							FechacEst = @FechacEst
								WHERE EstProyId = @EstProyId
				END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END