USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

IF ( OBJECT_ID('dbo.DeleteTracProject') IS NOT NULL ) 
   DROP PROCEDURE dbo.DeleteTracProject
GO

CREATE PROCEDURE dbo.DeleteTracProject(
	@IdTracProject INT)
AS

BEGIN

SET NOCOUNT ON;

	BEGIN TRY
		IF @IdTracProject IS NOT NULL 
			
			IF EXISTS(SELECT IdTracProject
							FROM dbo.TracingProjects
							WHERE IdTracProject = @IdTracProject)

				BEGIN
					DELETE FROM dbo.TracingProjects 
						WHERE IdTracProject = @IdTracProject
				END

	END TRY

	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END