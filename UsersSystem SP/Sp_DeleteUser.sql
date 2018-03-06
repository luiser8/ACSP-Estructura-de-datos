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
	
		IF EXISTS(SELECT IdUserSystem 
						FROM dbo.UsersSystem
						WHERE IdUserSystem = @IdUserSystem)
		BEGIN
			DELETE FROM dbo.UsersSystem WHERE IdUserSystem = @IdUserSystem
		END

	END TRY

	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END
GO