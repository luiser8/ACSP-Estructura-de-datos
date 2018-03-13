-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Borrado lógico parametros de Proyectos
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ParametroEliminar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ParametroEliminar
GO
CREATE PROCEDURE dbo.ParametroEliminar(
	@ParametroId INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @ParametroId IS NOT NULL 		
			IF EXISTS(SELECT ParametroId 
							FROM dbo.Parametros
							WHERE ParametroId = @ParametroId)
				BEGIN
					UPDATE dbo.Parametros SET EstadoSemana = 0 
						WHERE ParametroId = @ParametroId
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END