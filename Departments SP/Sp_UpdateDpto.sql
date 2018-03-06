IF ( OBJECT_ID('dbo.UpdateDepartment') IS NOT NULL ) 
   DROP PROCEDURE dbo.UpdateDepartment
GO

USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

CREATE PROCEDURE dbo.UpdateDepartment(
	@IdDepartment INT,
	@NameDepartment VARCHAR(50),
	@DescDepartment VARCHAR(125))
AS
BEGIN

SET NOCOUNT ON;

	BEGIN TRY
	
		IF ISNUMERIC(@IdDepartment) = 1
			IF @IdDepartment IS NOT NULL AND @IdDepartment <> ''
				AND ISNULL(LTRIM(RTRIM(@NameDepartment)),'') <> ''

				IF EXISTS(SELECT IdDepartment 
						FROM dbo.Departments
						WHERE IdDepartment = @IdDepartment)
				BEGIN
					UPDATE dbo.Departments SET NameDepartment = @NameDepartment,
										DescDepartment = @DescDepartment
					WHERE IdDepartment = @IdDepartment
				END

	END TRY

	BEGIN CATCH

		SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END
GO