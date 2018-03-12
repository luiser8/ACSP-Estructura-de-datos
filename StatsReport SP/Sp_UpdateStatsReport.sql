USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.UpdateStatsReport') IS NOT NULL ) 
   DROP PROCEDURE dbo.UpdateStatsReport
GO
CREATE PROCEDURE dbo.UpdateStatsReport(
	@IdStatReport INT,
	@IdReport INT, 
	@DescStatReport VARCHAR(125),
	@DateStatReport VARCHAR(11))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @IdStatReport IS NOT NULL			
			IF EXISTS(SELECT IdStatReport, IdReport 
							FROM dbo.StatsReports
							WHERE IdStatReport = @IdStatReport AND
									IdStatReport = @IdStatReport)
				BEGIN
					UPDATE dbo.StatsReports
						SET IdReport = @IdReport, 
							DescStatReport = @DescStatReport, 
							DateStatReport = @DateStatReport
								WHERE IdStatReport = @IdStatReport
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END