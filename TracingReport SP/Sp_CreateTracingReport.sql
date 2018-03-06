USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

IF ( OBJECT_ID('dbo.CreateTracReport') IS NOT NULL ) 
   DROP PROCEDURE dbo.CreateTracReport
GO

CREATE PROCEDURE dbo.CreateTracReport(
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
		IF @IdReport IS NOT NULL 
			IF EXISTS(SELECT IdReport
							FROM dbo.Reports
							WHERE @IdReport = @IdReport)

				BEGIN
					INSERT INTO dbo.TracingReports(IdReport, DescTracReport, FirstValue, SecondValue,
													ThirdValue, FourthValue, WeekTracReport, DataColumView)
					VALUES(@IdReport, @DescTracReport, @FirstValue, @SecondValue, @ThirdValue,
							@FourthValue, @WeekTracReport, @DataColumView)

				END

	END TRY

	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END