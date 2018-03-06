USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

IF ( OBJECT_ID('dbo.SelectTracReport') IS NOT NULL ) 
   DROP PROCEDURE dbo.SelectTracReport
GO

CREATE PROCEDURE dbo.SelectTracReport
	@IdTracReport INT = NULL,
	@IdReport INT = NULL

AS

SET NOCOUNT ON;

BEGIN

	BEGIN TRY
			IF @IdTracReport IS NULL 
					BEGIN
						SELECT * FROM dbo.TracingReports WITH (NOLOCK)
					END
			ELSE
					BEGIN
						SELECT * FROM dbo.TracingReports WITH (NOLOCK)
							WHERE IdTracReport = @IdTracReport	
					END		

	END TRY

	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END