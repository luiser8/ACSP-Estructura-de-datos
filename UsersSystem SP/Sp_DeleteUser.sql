USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.DeleteUserSystem') IS NOT NULL ) 
   DROP PROCEDURE dbo.DeleteUserSystem
GO
CREATE PROCEDURE dbo.DeleteUserSystem(
	@IdUserSystem INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF NOT EXISTS(SELECT IdUserSystem 
						FROM dbo.UsersSystem
						WHERE IdUserSystem = @IdUserSystem)
			BEGIN
				RAISERROR ('Error! does not exist User', 16, 1);
				RETURN 1;					
			END
		BEGIN
			UPDATE dbo.UsersSystem SET StatusUserSystem = 0 
					WHERE IdUserSystem = @IdUserSystem
		END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO