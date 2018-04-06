-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Borrado lógico parametros de Proyectos
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ParametroEliminar') IS NOT NULL ) 
   DROP PROCEDURE app.ParametroEliminar
GO
CREATE PROCEDURE app.ParametroEliminar(
	@ParametroId INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @ParametroId IS NOT NULL 		
			IF EXISTS(SELECT ParametroId 
							FROM [app].[Parametros]
							WHERE ParametroId = @ParametroId)
				BEGIN
					UPDATE [app].[Parametros] SET EstadoSemana = 0 
						WHERE ParametroId = @ParametroId
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END