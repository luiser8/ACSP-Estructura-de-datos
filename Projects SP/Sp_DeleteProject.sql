USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.DeleteProject') IS NOT NULL ) 
   DROP PROCEDURE dbo.DeleteProject
GO
CREATE PROCEDURE dbo.DeleteProject(
	@IdProject INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY	
		IF NOT EXISTS(SELECT IdProject 
						FROM dbo.Projects
						WHERE IdProject = @IdProject)
				BEGIN
					RAISERROR ('Error! does not exist Project', 16, 1);
					RETURN 1;
				END	
		BEGIN
			UPDATE dbo.Projects SET StatusProject = 0 WHERE IdProject = @IdProject
		END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO