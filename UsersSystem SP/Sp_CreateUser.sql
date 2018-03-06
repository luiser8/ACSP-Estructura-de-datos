USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

IF ( OBJECT_ID('dbo.CreateUserSystem') IS NOT NULL ) 
   DROP PROCEDURE dbo.CreateUserSystem
GO

CREATE PROCEDURE dbo.CreateUserSystem(
	@IdDepartment VARCHAR(50),
	@FirstNameUser VARCHAR(125),
	@LastNameUser VARCHAR(125),
	@EmailUser VARCHAR(125),
	@PasswordUser VARCHAR(125),
	@TypeUserSystem TINYINT)
AS
BEGIN

SET NOCOUNT ON;

	BEGIN TRY
		IF @IdDepartment IS NOT NULL 
			AND ISNULL(LTRIM(RTRIM(@IdDepartment)),'') <> ''

			IF NOT EXISTS(SELECT EmailUser 
							FROM dbo.UsersSystem
							WHERE EmailUser = @EmailUser)
			BEGIN
				INSERT INTO dbo.UsersSystem(IdDepartment, FirstNameUser, 
											LastNameUser, EmailUser,
											PasswordUser, TypeUserSystem)
				VALUES(@IdDepartment, @FirstNameUser, @LastNameUser,
						@EmailUser, @PasswordUser, @TypeUserSystem)
			END

	END TRY

	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END
GO
