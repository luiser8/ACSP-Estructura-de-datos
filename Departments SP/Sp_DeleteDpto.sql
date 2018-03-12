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
		IF NOT EXISTS(SELECT IdDepartment 
						FROM dbo.Departments
						WHERE IdDepartment = @IdDepartment)
			BEGIN
				RAISERROR ('Error! does not exist Departament', 16, 1);
				RETURN 1;					
			END
		BEGIN
			UPDATE dbo.Departments SET StatusDepartment = 0
				WHERE IdDepartment = @IdDepartment
		END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO