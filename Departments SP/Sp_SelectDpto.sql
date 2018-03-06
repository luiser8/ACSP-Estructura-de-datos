USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

IF ( OBJECT_ID('dbo.SelectDepartment') IS NOT NULL ) 
   DROP PROCEDURE dbo.SelectDepartment
GO

CREATE PROCEDURE dbo.SelectDepartment
	@IdDepartment INT = NULL
AS
BEGIN
	BEGIN TRY

			IF @IdDepartment IS NULL
				BEGIN
					SELECT * FROM dbo.Departments WITH (NOLOCK)
				END
			ELSE
				BEGIN
					SELECT * FROM dbo.Departments WITH (NOLOCK)
						WHERE @IdDepartment = @IdDepartment	
				END	

	END TRY

	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END
GO