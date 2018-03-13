-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Borrado lógico Usuarios del sistema
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.UsuarioSistemaEliminar') IS NOT NULL ) 
   DROP PROCEDURE dbo.UsuarioSistemaEliminar
GO
CREATE PROCEDURE dbo.UsuarioSistemaEliminar(
	@UsuarioId INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF NOT EXISTS(SELECT UsuarioId 
						FROM dbo.UsuarioSistema
						WHERE UsuarioId = @UsuarioId)
			BEGIN
				RAISERROR ('Error! No existe este usuario', 16, 1);
				RETURN 1;					
			END
		BEGIN
			UPDATE dbo.UsuarioSistema SET Estado = 0 
					WHERE UsuarioId = @UsuarioId
		END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO