USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

IF ( OBJECT_ID('dbo.SelectTracProject') IS NOT NULL ) 
   DROP PROCEDURE dbo.SelectTracProject
GO

CREATE PROCEDURE dbo.SelectTracProject
	@IdTracProject INT = NULL,
	@IdProject INT = NULL

AS

SET NOCOUNT ON;

BEGIN

	BEGIN TRY
			IF @IdTracProject IS NULL 
					BEGIN
						SELECT * FROM dbo.TracingProjects WITH (NOLOCK)
					END
			ELSE
					BEGIN
						SELECT * FROM dbo.TracingProjects WITH (NOLOCK)
							WHERE IdTracProject = @IdTracProject	
					END		

	END TRY

	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END