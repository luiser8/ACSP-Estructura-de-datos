-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Busca Usuarios del sistema
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.UsuarioSistemaBuscar') IS NOT NULL ) 
   DROP PROCEDURE dbo.UsuarioSistemaBuscar
GO
CREATE PROCEDURE dbo.UsuarioSistemaBuscar
	@UsuarioId INT = NULL,
	@Estado BIT = NULL
AS
BEGIN
	BEGIN TRY
			IF @UsuarioId IS NOT NULL --Por Id
				BEGIN
					SELECT UsuarioId, DptoId, Nombres,
							Apellidos, Correo, Clave,
								NivelAcceso, Estado, Fecha 
									FROM dbo.UsuarioSistema WITH (NOLOCK)
										WHERE UsuarioId = @UsuarioId
				END
			ELSE IF @UsuarioId IS NULL AND @Estado IS NULL --Todos
				BEGIN
					SELECT UsuarioId, DptoId, Nombres,
							Apellidos, Correo, Clave,
								NivelAcceso, Estado, Fecha 
									FROM dbo.UsuarioSistema WITH (NOLOCK)
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO