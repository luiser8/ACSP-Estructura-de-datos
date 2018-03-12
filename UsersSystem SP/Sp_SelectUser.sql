USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.SelectUsersSystem') IS NOT NULL ) 
   DROP PROCEDURE dbo.SelectUsersSystem
GO
CREATE PROCEDURE dbo.SelectUsersSystem
	@IdUserSystem INT = NULL,
	@StatusUserSystem INT = NULL
AS
BEGIN
	BEGIN TRY
			IF @IdUserSystem IS NOT NULL --Por Id
				BEGIN
					SELECT * FROM dbo.UsersSystem WITH (NOLOCK)
						WHERE IdUserSystem = @IdUserSystem
				END
			ELSE IF @IdUserSystem IS NULL AND @StatusUserSystem IS NULL --Todos
				BEGIN
					SELECT * FROM dbo.UsersSystem WITH (NOLOCK)
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO