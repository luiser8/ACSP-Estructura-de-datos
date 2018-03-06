USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

IF ( OBJECT_ID('dbo.CreateProject') IS NOT NULL ) 
   DROP PROCEDURE dbo.CreateProject
GO

CREATE PROCEDURE dbo.CreateProject(
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
		IF @CodProject IS NOT NULL AND
			@IdDepartment IS NOT NULL
				AND ISNULL(LTRIM(RTRIM(@CodProject)),'') <> ''

				IF NOT EXISTS(SELECT CodProject, NameProject 
								FROM dbo.Projects
								WHERE CodProject = @CodProject)
				BEGIN
					INSERT INTO dbo.Projects(CodProject, IdDepartment, IdUserSystem, 
												NameProject, DescProject, GraphicProject,
												StateProject, YearProject, 
												DateStartProject, DateEndProject)
					VALUES(@CodProject, @IdDepartment, @IdUserSystem, 
							@NameProject, @DescProject, @GraphicProject, 
							@StateProject, @YearProject, @DateStartProject, @DateEndProject)

				END

	END TRY

	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END
GO