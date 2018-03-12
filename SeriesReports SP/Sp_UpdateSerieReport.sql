USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.UpdateSerieReport') IS NOT NULL ) 
   DROP PROCEDURE dbo.UpdateSerieReport
GO
CREATE PROCEDURE dbo.UpdateSerieReport(
	@IdReport VARCHAR(50),
	@FirstSerie VARCHAR(125),
	@SecondSerie VARCHAR(125),
	@ThirdSerie VARCHAR(125),
	@FourthSerie VARCHAR(125))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY	
		IF ISNUMERIC(@IdReport) = 1

				IF EXISTS(SELECT IdReport, @IdReport
						FROM dbo.SeriesReports
						WHERE IdReport = @IdReport)
				BEGIN
					UPDATE dbo.SeriesReports SET IdReport = @IdReport, FirstSerie = @FirstSerie,
												SecondSerie = @SecondSerie,	ThirdSerie = @ThirdSerie,
												FourthSerie = @FourthSerie
				END
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO