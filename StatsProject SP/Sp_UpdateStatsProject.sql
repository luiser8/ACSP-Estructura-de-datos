USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.UpdateStatsProject') IS NOT NULL ) 
   DROP PROCEDURE dbo.UpdateStatsProject
GO
CREATE PROCEDURE dbo.UpdateStatsProject(
	@IdStatProject INT,
	@IdProject INT, 
	@PlanTracProject VARCHAR(11),
	@RealTracProject VARCHAR(11),
	@DateStatProject VARCHAR(11))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @IdStatProject IS NOT NULL
			
			IF EXISTS(SELECT IdStatProject, IdProject 
							FROM dbo.StatsProjects
							WHERE IdStatProject = @IdStatProject AND
									IdStatProject = @IdStatProject)
				BEGIN
					UPDATE dbo.StatsProjects
						SET PlanTracProject = @PlanTracProject, 
							RealTracProject = @RealTracProject, 
							DateStatProject = @DateStatProject
								WHERE IdStatProject = @IdStatProject
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END