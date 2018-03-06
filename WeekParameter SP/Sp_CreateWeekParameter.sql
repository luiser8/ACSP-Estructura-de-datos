USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

IF ( OBJECT_ID('dbo.CreateParameter') IS NOT NULL ) 
   DROP PROCEDURE dbo.CreateParameter
GO

CREATE PROCEDURE dbo.CreateParameter(
	@TypeParameter INT, -- 1 OR 2
	@IdProject INT,
	@WeekParameter VARCHAR(11),
	@WeekCount INT)
AS

BEGIN

SET NOCOUNT ON;

	BEGIN TRY
		IF @IdProject IS NOT NULL AND 
			@TypeParameter IS NOT NULL

			BEGIN
				INSERT INTO dbo.Parameter(TypeParameter, IdProject, WeekParameter, WeekCount)
				VALUES(@TypeParameter ,@IdProject, @WeekParameter, @WeekCount)
			END

	END TRY

	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END