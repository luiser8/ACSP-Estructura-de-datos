USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

IF ( OBJECT_ID('dbo.CreateSerieReport') IS NOT NULL ) 
   DROP PROCEDURE dbo.CreateSerieReport
GO

CREATE PROCEDURE dbo.CreateSerieReport(
	@IdReport VARCHAR(50),
	@FirstSerie VARCHAR(125),
	@FirstLeyend VARCHAR(125),
	@SecondSerie VARCHAR(125),
	@SecondLeyend VARCHAR(125),
	@ThirdSerie VARCHAR(125),
	@ThirdLeyend VARCHAR(125),
	@FourthSerie VARCHAR(125),
	@FourthLeyend VARCHAR(125))
AS
BEGIN

SET NOCOUNT ON;

	BEGIN TRY
		IF @IdReport IS NOT NULL
				AND ISNULL(LTRIM(RTRIM(@IdReport)),'') <> ''

				IF NOT EXISTS(SELECT IdReport 
								FROM dbo.Reports
								WHERE IdReport = @IdReport)
				BEGIN
					INSERT INTO dbo.SeriesReports(IdReport, FirstSerie, FirstLeyend, 
												SecondSerie, SecondLeyend, ThirdSerie,
												ThirdLeyend, FourthSerie, FourthLeyend)
					VALUES(@IdReport, @FirstSerie, @FirstLeyend, 
							@SecondSerie, @SecondLeyend, @ThirdSerie, @ThirdLeyend,
							@FourthSerie, @FourthLeyend)

				END

	END TRY

	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END
GO