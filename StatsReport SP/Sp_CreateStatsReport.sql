USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

IF ( OBJECT_ID('dbo.CreateStatsReport') IS NOT NULL ) 
   DROP PROCEDURE dbo.CreateStatsReport
GO

CREATE PROCEDURE dbo.CreateStatsReport(
	@IdReport INT, 
	@DescStatReport VARCHAR(125),
	@DateStatReport VARCHAR(11))
AS

BEGIN

SET NOCOUNT ON;

	BEGIN TRY
		IF @IdReport IS NOT NULL 
			AND ISNULL(LTRIM(RTRIM(@IdReport)),'') <> ''

			IF EXISTS(SELECT IdReport 
							FROM dbo.TracingReports
							WHERE IdReport = @IdReport)
			BEGIN
				INSERT INTO dbo.StatsReports(IdReport, DescStatReport, DateStatReport)
				VALUES(@IdReport, @DescStatReport, @DateStatReport)
			END
				
	END TRY

	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END
GO