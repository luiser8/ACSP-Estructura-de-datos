USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.CreateDepartment') IS NOT NULL ) 
   DROP PROCEDURE dbo.CreateDepartment
GO
CREATE PROCEDURE dbo.CreateDepartment(
	@NameDepartment VARCHAR(50),
	@DescDepartment VARCHAR(125))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @NameDepartment IS NOT NULL 
			AND ISNULL(LTRIM(RTRIM(@NameDepartment)),'') <> ''
			IF EXISTS(SELECT NameDepartment 
							FROM dbo.Departments
							WHERE NameDepartment = @NameDepartment)
				BEGIN
					RAISERROR ('Error! Already Exists Departament', 16, 1);
					RETURN 1;					
				END
			BEGIN
				INSERT INTO dbo.Departments(NameDepartment, DescDepartment)
				VALUES(@NameDepartment, @DescDepartment)
			END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO