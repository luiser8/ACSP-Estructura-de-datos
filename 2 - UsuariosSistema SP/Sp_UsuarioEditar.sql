-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Edita Usuarios del sistema
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.UsuarioSistemaEditar') IS NOT NULL ) 
   DROP PROCEDURE dbo.UsuarioSistemaEditar
GO
CREATE PROCEDURE dbo.UsuarioSistemaEditar(
	@UsuarioId INT,
	@DptoId VARCHAR(50),
	@Nombres VARCHAR(125),
	@Apellidos VARCHAR(125),
	@Correo VARCHAR(125),
	@Clave VARCHAR(125),
	@NivelAcceso TINYINT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF ISNUMERIC(@UsuarioId) = 1
			IF @DptoId IS NOT NULL AND @UsuarioId <> ''
				AND ISNULL(LTRIM(RTRIM(@Correo)),'') <> ''
					IF NOT EXISTS(SELECT UsuarioId, Correo
						FROM dbo.UsuarioSistema
						WHERE UsuarioId = @UsuarioId)
					BEGIN
						RAISERROR ('Error! does not exist User', 16, 1);
						RETURN 1;					
					END
				BEGIN
					UPDATE dbo.UsuarioSistema SET DptoId = @DptoId,
										Nombres = @Nombres,
										Apellidos = @Apellidos,
										Correo = @Correo,
										Clave = @Clave
					WHERE UsuarioId = @UsuarioId
				END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO