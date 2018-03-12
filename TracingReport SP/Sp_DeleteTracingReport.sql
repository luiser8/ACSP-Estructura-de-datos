USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.DeleteTracReport') IS NOT NULL ) 
   DROP PROCEDURE dbo.DeleteTracReport
GO
CREATE PROCEDURE dbo.DeleteTracReport(
	@IdTracReport INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @IdTracReport IS NOT NULL 			
			IF EXISTS(SELECT IdTracReport
							FROM dbo.TracingReports
							WHERE IdTracReport = @IdTracReport)
				BEGIN
					UPDATE dbo.TracingReports SET StatusTracReport = 0
						WHERE IdTracReport = @IdTracReport
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END