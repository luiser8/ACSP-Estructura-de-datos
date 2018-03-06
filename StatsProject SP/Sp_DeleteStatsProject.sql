USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

IF ( OBJECT_ID('dbo.DeleteStatsProject') IS NOT NULL ) 
   DROP PROCEDURE dbo.DeleteStatsProject
GO

CREATE PROCEDURE dbo.DeleteStatsProject(
	@IdStatProject INT)
AS

BEGIN

SET NOCOUNT ON;

	BEGIN TRY
		IF @IdStatProject IS NOT NULL 
			
			IF EXISTS(SELECT IdStatProject 
							FROM dbo.StatsProjects
							WHERE IdStatProject = @IdStatProject)

				BEGIN
					DELETE FROM dbo.StatsProjects 
						WHERE IdStatProject = @IdStatProject
				END

	END TRY

	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END