USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.CreateReport') IS NOT NULL ) 
   DROP PROCEDURE dbo.CreateReport
GO
CREATE PROCEDURE dbo.CreateReport(
	@CodReport VARCHAR(50),
	@IdDepartment INT,
	@IdUserSystem INT,
	@NameReport VARCHAR(125),
	@DescReport VARCHAR(125),
	@GraphicReport VARCHAR(125),
	@SymbolReport VARCHAR(11),
	@DateStartReport VARCHAR(11),
	@YearReport VARCHAR(11))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @CodReport IS NOT NULL AND
			@IdDepartment IS NOT NULL
				AND ISNULL(LTRIM(RTRIM(@CodReport)),'') <> ''
				IF NOT EXISTS(SELECT CodReport, NameReport 
								FROM dbo.Reports
								WHERE CodReport = @CodReport)
				BEGIN
					INSERT INTO dbo.Reports(CodReport, IdDepartment, IdUserSystem, 
												NameReport, DescReport, GraphicReport,
												SymbolReport, DateStartReport, YearReport)
					VALUES(@CodReport, @IdDepartment, @IdUserSystem, 
							@NameReport, @DescReport, @GraphicReport, @SymbolReport,
							@DateStartReport, @YearReport)
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO