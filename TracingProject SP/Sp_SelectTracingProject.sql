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
		IF @IdTracProject IS NOT NULL --Por Id
			BEGIN
					SELECT * FROM dbo.TracingProjects WITH (NOLOCK)
						WHERE IdTracProject = @IdTracProject
				END
			ELSE IF @IdProject IS NULL AND @IdTracProject IS NULL --Todos
				BEGIN
					SELECT * FROM dbo.TracingProjects WITH (NOLOCK)
				END		
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END