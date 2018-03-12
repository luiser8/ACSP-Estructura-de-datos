USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.SelectStatsProject') IS NOT NULL ) 
   DROP PROCEDURE dbo.SelectStatsProject
GO
CREATE PROCEDURE dbo.SelectStatsProject
	@IdProject INT = NULL,
	@StatusStatProject INT = NULL
AS
SET NOCOUNT ON;
BEGIN
	BEGIN TRY
	IF @IdProject IS NOT NULL --Por Id
				BEGIN
					SELECT * FROM dbo.StatsProjects WITH (NOLOCK)
						WHERE IdProject = @IdProject
				END
			ELSE IF @IdProject IS NULL AND @StatusStatProject IS NULL --Todos
				BEGIN
					SELECT * FROM dbo.StatsProjects WITH (NOLOCK)
				END	
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END