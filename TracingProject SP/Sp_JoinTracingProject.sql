USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.JoinTracProject') IS NOT NULL ) 
   DROP PROCEDURE dbo.JoinTracProject
GO
CREATE PROCEDURE dbo.JoinTracProject
	@IdProject INT = NULL
AS
SET NOCOUNT ON;
BEGIN
	BEGIN TRY
		IF @IdProject IS NOT NULL --Por Id
			IF EXISTS(SELECT @IdProject
							FROM dbo.Projects
							WHERE IdProject = @IdProject)
				BEGIN
					SELECT TracingProjects.*, 
									Projects.CodProject,
									Projects.CreateProject, 
									Projects.NameProject,
									Projects.StatusProject, 
									Projects.GraphicProject
					 FROM dbo.TracingProjects WITH (NOLOCK)
					 INNER JOIN Projects AS Projects ON Projects.IdProject = TracingProjects.IdProject
						WHERE TracingProjects.IdProject = @IdProject
							ORDER BY TracingProjects.DateTracProject
				END
			ELSE IF @IdProject IS NULL --Todos
				BEGIN		
					SELECT * FROM dbo.TracingProjects WITH (NOLOCK)	
				END		
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END