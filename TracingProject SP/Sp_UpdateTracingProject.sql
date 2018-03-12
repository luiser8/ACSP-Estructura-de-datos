USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.UpdateTracProject') IS NOT NULL ) 
   DROP PROCEDURE dbo.UpdateTracProject
GO
CREATE PROCEDURE dbo.UpdateTracProject(
	@IdTracProject INT,
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
		IF @IdTracProject IS NOT NULL
			
			IF EXISTS(SELECT IdTracProject, IdProject 
							FROM dbo.TracingProjects
							WHERE IdTracProject = @IdTracProject AND
									IdProject = @IdProject)
				BEGIN
					UPDATE dbo.TracingProjects
						SET TypeTracProject = @TypeTracProject, 
							IdProject = @IdProject,
							IdParameter = @IdParameter,
							DescTracProject = @DescTracProject,
							PlanTracProject = @PlanTracProject,
							RealTracProject = @RealTracProject,
							DateTracProject = @DateTracProject,
							DevTracProject = @DevTracProject 
								WHERE IdTracProject = @IdTracProject
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END