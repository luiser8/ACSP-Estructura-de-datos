USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.UpdateUserSystem') IS NOT NULL ) 
   DROP PROCEDURE dbo.UpdateUserSystem
GO
CREATE PROCEDURE dbo.UpdateUserSystem(
	@IdUserSystem INT,
	@IdDepartment VARCHAR(50),
	@FirstNameUser VARCHAR(125),
	@LastNameUser VARCHAR(125),
	@EmailUser VARCHAR(125),
	@PasswordUser VARCHAR(125))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF ISNUMERIC(@IdUserSystem) = 1
			IF @IdDepartment IS NOT NULL AND @IdUserSystem <> ''
				AND ISNULL(LTRIM(RTRIM(@EmailUser)),'') <> ''
					IF NOT EXISTS(SELECT IdUserSystem, EmailUser
						FROM dbo.UsersSystem
						WHERE IdUserSystem = @IdUserSystem)
					BEGIN
						RAISERROR ('Error! does not exist User', 16, 1);
						RETURN 1;					
					END
				BEGIN
					UPDATE dbo.UsersSystem SET IdDepartment = @IdDepartment,
										FirstNameUser = @FirstNameUser,
										LastNameUser = @LastNameUser,
										EmailUser = @EmailUser,
										PasswordUser = @PasswordUser
					WHERE IdUserSystem = @IdUserSystem
				END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO