USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.SelectReplanning') IS NOT NULL ) 
   DROP PROCEDURE dbo.SelectReplanning
GO
CREATE PROCEDURE dbo.SelectReplanning
	@IdReplanning INT = NULL,
	@StatusReplanning INT = NULL
AS
BEGIN
	BEGIN TRY
		IF @IdReplanning IS NOT NULL --Por Id
			BEGIN
					SELECT * FROM dbo.Replanning WITH (NOLOCK)
						WHERE IdReplanning = @IdReplanning
				END
			ELSE IF @IdReplanning IS NULL AND @StatusReplanning IS NULL --Todos
				BEGIN
					SELECT * FROM dbo.Replanning WITH (NOLOCK)
				END
	END TRY
	BEGIN CATCH

	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO