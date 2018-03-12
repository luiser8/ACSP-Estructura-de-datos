USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.CreateReplanning') IS NOT NULL ) 
   DROP PROCEDURE dbo.CreateReplanning
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
				IF EXISTS(SELECT IdProject, StatusProject
							FROM dbo.Projects
							WHERE IdProject = @IdProject AND StatusProject = 0)
						BEGIN
							RAISERROR('Error! does not exist or disabled Project', 16, 1);
							RETURN 1;					
						END
			BEGIN
				IF NOT EXISTS(SELECT IdProject
								FROM dbo.Replanning
								WHERE IdProject = @IdProject AND StatusReplanning = 1)
					BEGIN
						INSERT INTO dbo.Replanning(IdProject, DescReplanning,
											DateAfReplanning, DateBeReplanning)
						VALUES(@IdProject, @DescReplanning, @DateAfReplanning, @DateBeReplanning)						
					END	
			END			
				IF EXISTS(SELECT IdProject, StatusProject
							FROM dbo.Projects
							WHERE IdProject = @IdProject AND
									StatusProject != 3)
				BEGIN
					UPDATE dbo.Projects SET StatusProject = 3
					WHERE IdProject = @IdProject
				END			
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO