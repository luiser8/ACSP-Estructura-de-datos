USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.JoinTracReport') IS NOT NULL ) 
   DROP PROCEDURE dbo.JoinTracReport
GO
CREATE PROCEDURE dbo.JoinTracReport
	@IdReport INT = NULL
AS
SET NOCOUNT ON;
BEGIN
	BEGIN TRY
		IF @IdReport IS NOT NULL --Por Id
			IF EXISTS(SELECT IdReport
							FROM dbo.Reports
							WHERE IdReport = @IdReport)
				BEGIN
					SELECT TracingReports.*, SeriesReports.*,
									Reports.CodReport,
									Reports.DateStartReport, 
									Reports.NameReport,
									Reports.StatusReport,
									Reports.GraphicReport,
									Reports.SymbolReport,
									Reports.YearReport
					 FROM dbo.TracingReports WITH (NOLOCK)
					 INNER JOIN Reports AS Reports ON Reports.IdReport = TracingReports.IdReport
					 LEFT OUTER JOIN SeriesReports AS SeriesReports ON Reports.IdReport = SeriesReports.IdReport
						WHERE TracingReports.IdReport = @IdReport AND
							TracingReports.WeekTracReport IN
							(SELECT MAX(TracingReports.WeekTracReport)
								FROM dbo.TracingReports 
									WHERE TracingReports.IdReport = @IdReport)
				END
			ELSE IF @IdReport IS NULL --Todos
				BEGIN		
					SELECT * FROM dbo.TracingReports WITH (NOLOCK)	
				END		
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END