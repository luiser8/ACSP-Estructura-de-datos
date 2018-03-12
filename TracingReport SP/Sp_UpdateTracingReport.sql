USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.UpdateTracReport') IS NOT NULL ) 
   DROP PROCEDURE dbo.UpdateTracReport
GO
CREATE PROCEDURE dbo.UpdateTracReport(
	@IdTracReport INT,
	@IdReport INT,
	@DescTracReport VARCHAR(125),
	@FirstValue VARCHAR(125),
	@SecondValue VARCHAR(125),
	@ThirdValue VARCHAR(125),
	@FourthValue VARCHAR(125),
	@WeekTracReport VARCHAR(11),
	@DataColumView VARCHAR(125))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @IdTracReport IS NOT NULL			
			IF EXISTS(SELECT IdTracReport, IdReport 
							FROM dbo.TracingReports
							WHERE IdTracReport = @IdTracReport AND
									IdReport = @IdReport)
				BEGIN
					UPDATE dbo.TracingReports
						SET IdReport = @IdReport,
							DescTracReport = @DescTracReport,
							FirstValue = @FirstValue,
							SecondValue = @SecondValue,
							ThirdValue = @ThirdValue,
							FourthValue = @FourthValue,
							WeekTracReport = @WeekTracReport,
							DataColumView = @DataColumView 
								WHERE IdTracReport = @IdTracReport
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END