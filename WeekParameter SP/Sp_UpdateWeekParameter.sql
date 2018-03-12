USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.UpdateParameter') IS NOT NULL ) 
   DROP PROCEDURE dbo.UpdateParameter
GO
CREATE PROCEDURE dbo.UpdateParameter(
	@IdParameter INT,
	@IdProject INT,
	@WeekAdvance INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @IdParameter IS NOT NULL		
			IF EXISTS(SELECT IdParameter, IdProject 
							FROM dbo.Parameter
							WHERE IdParameter = @IdParameter AND
									IdProject = @IdProject)
				BEGIN
					UPDATE dbo.Parameter
						SET WeekAdvance = @WeekAdvance, 
							WeekStatus = 0, 
							WeekSee = 1
								WHERE IdParameter = @IdParameter
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END