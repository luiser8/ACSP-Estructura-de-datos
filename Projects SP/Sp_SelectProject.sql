USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.SelectProject') IS NOT NULL ) 
   DROP PROCEDURE dbo.SelectProject
GO
CREATE PROCEDURE dbo.SelectProject
	@IdProject INT = NULL,
	@StatusProject INT = NULL
AS
BEGIN
	BEGIN TRY
			IF @IdProject IS NOT NULL --Por Id
				BEGIN
					SELECT * FROM dbo.Projects WITH (NOLOCK)
						WHERE IdProject = @IdProject
				END
			ELSE IF @IdProject IS NULL AND @StatusProject IS NULL --Todos
				BEGIN
					SELECT * FROM dbo.Projects WITH (NOLOCK)
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO