USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.DeleteSerieReport') IS NOT NULL ) 
   DROP PROCEDURE dbo.DeleteSerieReport
GO
CREATE PROCEDURE dbo.DeleteSerieReport(
	@IdReport INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF EXISTS(SELECT IdReport 
						FROM dbo.SeriesReports
						WHERE IdReport = @IdReport)
		BEGIN
			UPDATE dbo.SeriesReports SET StatusSerieReport = 0 WHERE IdReport = @IdReport
		END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO