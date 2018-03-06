USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

CREATE PROCEDURE dbo.CreateReplanning(
	@IdProject VARCHAR(50),
	@DescReplanning VARCHAR(125),
	@DateAfReplanning VARCHAR(11),
	@DateBeReplanning VARCHAR(11))
AS
BEGIN

SET NOCOUNT ON;

	BEGIN TRY
		IF @IdProject IS NOT NULL 
			AND ISNULL(LTRIM(RTRIM(@IdProject)),'') <> ''

			IF EXISTS(SELECT IdProject 
							FROM dbo.Projects
							WHERE IdProject = @IdProject AND
									StateProject != 3)
			BEGIN
				INSERT INTO dbo.Replanning(IdProject, DescReplanning,
											DateAfReplanning, DateBeReplanning)
				VALUES(@IdProject, @DescReplanning, @DateAfReplanning, @DateBeReplanning)
			END
			
			IF EXISTS(SELECT IdProject, StateProject
							FROM dbo.Projects
							WHERE IdProject = @IdProject AND
									StateProject != 3)
				BEGIN
					UPDATE dbo.Projects SET StateProject = 3
					WHERE IdProject = @IdProject
				END
				
	END TRY

	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END
GO