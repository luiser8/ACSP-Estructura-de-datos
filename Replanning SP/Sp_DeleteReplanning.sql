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
	
		IF EXISTS(SELECT IdReplanning, IdProject
						FROM dbo.Replanning
						WHERE IdReplanning = @IdReplanning AND 
								IdProject = @IdProject)

			BEGIN
				DELETE FROM dbo.Replanning WHERE IdReplanning = @IdReplanning
												AND IdProject = @IdProject
			END

				IF EXISTS(SELECT IdProject, StateProject
					FROM dbo.Projects
					WHERE IdProject = @IdProject AND
							StateProject = 3)
				
					BEGIN
						UPDATE dbo.Projects SET StateProject = 1
						WHERE IdProject = @IdProject
					END

	END TRY

	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END
GO