USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.SelectParameter') IS NOT NULL ) 
   DROP PROCEDURE dbo.SelectParameter
GO
CREATE PROCEDURE dbo.SelectParameter
	@IdProject INT = NULL,
	@StatusParameter INT = NULL
AS
SET NOCOUNT ON;
BEGIN
	BEGIN TRY
		IF @IdProject IS NOT NULL --Por Id
			BEGIN
					SELECT * FROM dbo.Parameter WITH (NOLOCK)
						WHERE IdProject = @IdProject
				END
			ELSE IF @IdProject IS NULL AND @StatusParameter IS NULL --Todos
				BEGIN
					SELECT * FROM dbo.Parameter WITH (NOLOCK)
				END	
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END