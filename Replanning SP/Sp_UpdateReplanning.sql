USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

IF ( OBJECT_ID('dbo.UpdateReplanning') IS NOT NULL ) 
   DROP PROCEDURE dbo.UpdateReplanning
GO

CREATE PROCEDURE dbo.UpdateReplanning(
	@IdReplanning INT,
	@IdProject INT,
	@DescReplanning VARCHAR(125),
	@DateAfReplanninf VARCHAR(11),
	@DateBeReplanning VARCHAR(11))
AS
BEGIN

SET NOCOUNT ON;

	BEGIN TRY
	
		IF ISNUMERIC(@IdReplanning) = 1
			IF @IdProject IS NOT NULL AND @IdProject <> ''

				IF EXISTS(SELECT IdProject
						FROM dbo.Projects
						WHERE IdProject = @IdProject)
				BEGIN
					UPDATE dbo.Replanning SET DescReplanning = @DescReplanning, 
										DateAfReplanning = @DateAfReplanninf, 
										DateBeReplanning = @DateBeReplanning 
					WHERE IdReplanning = @IdReplanning
				END

	END TRY

	BEGIN CATCH

		SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END
GO