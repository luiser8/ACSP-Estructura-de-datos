USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.DeleteReplanning') IS NOT NULL ) 
   DROP PROCEDURE dbo.DeleteReplanning
GO
CREATE PROCEDURE dbo.DeleteReplanning(
	@IdReplanning INT,
	@IdProject INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY	
		IF NOT EXISTS(SELECT IdReplanning, IdProject
						FROM dbo.Replanning
						WHERE IdReplanning = @IdReplanning AND 
								IdProject = @IdProject)
					BEGIN
						RAISERROR ('Error! does not exist Project', 16, 1);
						RETURN 1;					
					END
			BEGIN
				UPDATE dbo.Replanning SET StatusReplanning = 0 
						WHERE IdReplanning = @IdReplanning AND IdProject = @IdProject
			END
				IF EXISTS(SELECT IdProject, StatusProject
					FROM dbo.Projects
					WHERE IdProject = @IdProject AND
							StatusProject = 3)			
					BEGIN
						UPDATE dbo.Projects SET StatusProject = 1
						WHERE IdProject = @IdProject
					END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO