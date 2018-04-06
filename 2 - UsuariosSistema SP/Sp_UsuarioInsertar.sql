-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Agrega Usuarios del sistema
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.UsuarioSistemaInsertar') IS NOT NULL ) 
   DROP PROCEDURE dbo.UsuarioSistemaInsertar
GO
CREATE PROCEDURE dbo.UsuarioSistemaInsertar(
	@DptoId VARCHAR(50),
	@Nombres VARCHAR(125),
	@Apellidos VARCHAR(125),
	@Correo VARCHAR(125),
	@Clave VARCHAR(125),
	@NivelAcceso BIT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @DptoId IS NOT NULL 
			AND ISNULL(LTRIM(RTRIM(@DptoId)),'') <> ''
				IF EXISTS(SELECT Correo 
							FROM dbo.UsuarioSistema
							WHERE Correo = @Correo)
					BEGIN
						RAISERROR ('Error! Ya esta creado este Usuario', 16, 1);
					RETURN 1;					
				END
				BEGIN
					INSERT INTO dbo.UsuarioSistema(DptoId, Nombres, 
											Apellidos, Correo,
											Clave, NivelAcceso)
					VALUES(@DptoId, @Nombres, @Apellidos,
						@Correo, @Clave, @NivelAcceso)
				END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO