USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.SelectDepartment') IS NOT NULL ) 
   DROP PROCEDURE dbo.SelectDepartment
GO
CREATE PROCEDURE dbo.SelectDepartment
	@IdDepartment INT = NULL,
	@StatusDepartment INT = NULL
AS
BEGIN
	BEGIN TRY
			IF @IdDepartment IS NOT NULL --Por Id
				BEGIN
					SELECT * FROM dbo.Departments WITH (NOLOCK)
						WHERE IdDepartment = @IdDepartment
				END
			ELSE IF @IdDepartment IS NULL AND @StatusDepartment IS NULL --Todos
				BEGIN
					SELECT * FROM dbo.Departments WITH (NOLOCK)
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO