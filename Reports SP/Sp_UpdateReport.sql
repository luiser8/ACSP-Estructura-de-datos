USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

IF ( OBJECT_ID('dbo.UpdateReport') IS NOT NULL ) 
   DROP PROCEDURE dbo.UpdateReport
GO

CREATE PROCEDURE dbo.UpdateReport(
	@IdReport INT,
	@CodReport VARCHAR(50),
	@IdDepartment INT,
	@IdUserSystem INT,
	@NameReport VARCHAR(125),
	@DescReport VARCHAR(125),
	@GraphicReport VARCHAR(125),
	@SymbolReport VARCHAR(11),
	@DateStartReport VARCHAR(11),
	@StateReport TINYINT,
	@YearReport VARCHAR(11))
AS
BEGIN

SET NOCOUNT ON;

	BEGIN TRY
	
		IF ISNUMERIC(@IdReport) = 1
			IF @IdDepartment IS NOT NULL AND @IdReport <> ''
				AND ISNULL(LTRIM(RTRIM(@CodReport)),'') <> ''

				IF EXISTS(SELECT @IdReport, @CodReport
						FROM dbo.Reports
						WHERE IdReport = @IdReport)
				BEGIN
					UPDATE dbo.Reports SET CodReport = @CodReport, IdDepartment = @IdDepartment,
										IdUserSystem = @IdUserSystem, NameReport = @NameReport,
										DescReport = @DescReport, GraphicReport = @GraphicReport,
										SymbolReport = @SymbolReport, StateReport = @StateReport, YearReport = @YearReport
					WHERE IdReport = @IdReport
				END

	END TRY

	BEGIN CATCH

		SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END
GO