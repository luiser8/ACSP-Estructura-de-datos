USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

IF ( OBJECT_ID('dbo.SelectStatsProject') IS NOT NULL ) 
   DROP PROCEDURE dbo.SelectStatsProject
GO

CREATE PROCEDURE dbo.SelectStatsProject
	@IdProject INT = NULL

AS

SET NOCOUNT ON;

BEGIN

	BEGIN TRY
			IF @IdProject IS NULL
				BEGIN
					SELECT * FROM dbo.StatsProjects WITH (NOLOCK)
				END
			ELSE
				BEGIN
					SELECT * FROM dbo.StatsProjects WITH (NOLOCK)
						WHERE IdProject = @IdProject	
				END		

	END TRY

	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END