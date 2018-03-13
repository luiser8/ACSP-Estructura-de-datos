-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Agrega Estadistica del proyecto
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.EstProyectoInsertar') IS NOT NULL ) 
   DROP PROCEDURE dbo.EstProyectoInsertar
GO
CREATE PROCEDURE dbo.EstProyectoInsertar(
	@ProyectoId INT, 
	@PlanEst VARCHAR(11),
	@RealEst VARCHAR(11),
	@FechacEst VARCHAR(11))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @ProyectoId IS NOT NULL 
			AND ISNULL(LTRIM(RTRIM(@ProyectoId)),'') <> ''
			IF EXISTS(SELECT ProyectoId 
							FROM dbo.ActProyectos
							WHERE ProyectoId = @ProyectoId)
			BEGIN
				INSERT INTO dbo.EstProyectos(ProyectoId, PlanEst,
											RealEst, FechacEst)
				VALUES(@ProyectoId, @PlanEst, @RealEst, @FechacEst)
			END				
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO