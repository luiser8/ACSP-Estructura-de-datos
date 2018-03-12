USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.DeleteStatsReport') IS NOT NULL ) 
   DROP PROCEDURE dbo.DeleteStatsReport
GO
CREATE PROCEDURE dbo.DeleteStatsReport(
	@IdStatReport INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @IdStatReport IS NOT NULL 		
			IF EXISTS(SELECT IdStatReport
							FROM dbo.StatsReports
							WHERE IdStatReport = @IdStatReport)
				BEGIN
					UPDATE dbo.StatsReports SET StatusStatReport = 0 
						WHERE IdStatReport = @IdStatReport
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END