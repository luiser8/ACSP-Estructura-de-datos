USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

IF ( OBJECT_ID('dbo.DeleteDepartment') IS NOT NULL ) 
   DROP PROCEDURE dbo.DeleteDepartment
GO

CREATE PROCEDURE dbo.DeleteDepartment(
	@IdDepartment INT)
AS
BEGIN

SET NOCOUNT ON;

	BEGIN TRY
	
		IF EXISTS(SELECT IdDepartment 
						FROM dbo.Departments
						WHERE IdDepartment = @IdDepartment)
		BEGIN
			DELETE FROM dbo.Departments WHERE IdDepartment = @IdDepartment
		END

	END TRY

	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END
GO