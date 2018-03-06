USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

IF ( OBJECT_ID('dbo.CreateTracProject') IS NOT NULL ) 
   DROP PROCEDURE dbo.CreateTracProject
GO

CREATE PROCEDURE dbo.CreateTracProject(
	@TypeTracProject TINYINT, -- 1 OR 2
	@IdProject INT,
	@IdParameter INT,
	@DescTracProject VARCHAR(255),
	@PlanTracProject VARCHAR(11),
	@RealTracProject VARCHAR(11),
	@DateTracProject VARCHAR(11),
	@DevTracProject VARCHAR(11))
AS

BEGIN

SET NOCOUNT ON;

	BEGIN TRY
		IF @IdProject IS NOT NULL 
			IF EXISTS(SELECT IdProject
							FROM dbo.Projects
							WHERE IdProject = @IdProject)

				BEGIN
					INSERT INTO dbo.TracingProjects(TypeTracProject, IdProject, IdParameter,
													DescTracProject, PlanTracProject, RealTracProject,
													DateTracProject, DevTracProject)
					VALUES(@TypeTracProject ,@IdProject, @IdParameter, @DescTracProject,
							@PlanTracProject, @RealTracProject, @DateTracProject, @DevTracProject)
					
				END

	END TRY

	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END