USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.CreateStatsProject') IS NOT NULL ) 
   DROP PROCEDURE dbo.CreateStatsProject
GO
CREATE PROCEDURE dbo.CreateStatsProject(
	@IdProject INT, 
	@PlanTracProject VARCHAR(11),
	@RealTracProject VARCHAR(11),
	@DateStatProject VARCHAR(11))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @IdProject IS NOT NULL 
			AND ISNULL(LTRIM(RTRIM(@IdProject)),'') <> ''
			IF EXISTS(SELECT IdProject 
							FROM dbo.TracingProjects
							WHERE IdProject = @IdProject)
			BEGIN
				INSERT INTO dbo.StatsProjects(IdProject, PlanTracProject,
											RealTracProject, DateStatProject)
				VALUES(@IdProject, @PlanTracProject, @RealTracProject, @DateStatProject)
			END				
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO