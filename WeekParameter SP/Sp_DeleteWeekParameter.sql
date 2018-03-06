USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

IF ( OBJECT_ID('dbo.DeleteParameter') IS NOT NULL ) 
   DROP PROCEDURE dbo.DeleteParameter
GO

CREATE PROCEDURE dbo.DeleteParameter(
	@IdParameter INT)
AS

BEGIN

SET NOCOUNT ON;

	BEGIN TRY
		IF @IdParameter IS NOT NULL 
			
			IF EXISTS(SELECT IdParameter 
							FROM dbo.Parameter
							WHERE IdParameter = @IdParameter)

				BEGIN
					DELETE FROM dbo.Parameter 
						WHERE IdParameter = @IdParameter
				END

	END TRY

	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO

	END CATCH;
END