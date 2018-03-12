USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.SelectSerieReport') IS NOT NULL ) 
   DROP PROCEDURE dbo.SelectSerieReport
GO
CREATE PROCEDURE dbo.SelectSerieReport
	@IdReport INT = NULL,
	@StatusSerieReport INT = NULL
AS
BEGIN
	BEGIN TRY
		IF @IdReport IS NOT NULL --Por Id
			BEGIN
				SELECT * FROM dbo.SeriesReports WITH (NOLOCK)
					WHERE IdReport = @IdReport
			END
		ELSE IF @IdReport IS NULL AND @StatusSerieReport IS NULL --Todos
			BEGIN
				SELECT * FROM dbo.SeriesReports WITH (NOLOCK)
			END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO