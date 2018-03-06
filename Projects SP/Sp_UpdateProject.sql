USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

IF ( OBJECT_ID('dbo.UpdateProject') IS NOT NULL ) 
   DROP PROCEDURE dbo.UpdateProject
GO

CREATE PROCEDURE dbo.UpdateProject(
	@IdProject INT,
	@CodProject VARCHAR(50),
	@IdDepartment INT,
	@IdUserSystem INT,
	@NameProject VARCHAR(125),
	@DescProject VARCHAR(125),
	@GraphicProject VARCHAR(125),
	@StateProject TINYINT,
	@YearProject VARCHAR(11),
	@DateStartProject VARCHAR(11),
	@DateEndProject VARCHAR(11))
AS
BEGIN

SET NOCOUNT ON;

	BEGIN TRY
	
		IF ISNUMERIC(@IdProject) = 1
			IF @IdDepartment IS NOT NULL AND @IdProject <> ''
				AND ISNULL(LTRIM(RTRIM(@CodProject)),'') <> ''

				IF EXISTS(SELECT IdProject, CodProject
						FROM dbo.Projects
						WHERE IdProject = @IdProject)
				BEGIN
					UPDATE dbo.Projects SET CodProject = @CodProject, IdDepartment = @IdDepartment,
										IdUserSystem = @IdUserSystem, NameProject = @NameProject,
										DescProject = @DescProject, GraphicProject = @GraphicProject,
										StateProject = @StateProject, YearProject = @YearProject,
										DateStartProject = @DateStartProject, DateEndProject = @DateEndProject 
					WHERE IdProject = @IdProject
				END

	END TRY

	BEGIN CATCH

		SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END
GO