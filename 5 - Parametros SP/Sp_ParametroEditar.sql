-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Edita parametros de Proyectos
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ParametroEditar') IS NOT NULL ) 
   DROP PROCEDURE app.ParametroEditar
GO
CREATE PROCEDURE app.ParametroEditar(
	@ParametroId INT,
	@ProyectoId INT,
	@Avance TINYINT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @ParametroId IS NOT NULL		
			IF EXISTS(SELECT ParametroId, ProyectoId 
							FROM [app].[Parametros]
							WHERE ParametroId = @ParametroId AND
									ProyectoId = @ProyectoId)
				BEGIN
					UPDATE [app].[Parametros]
						SET Avance = @Avance, 
							EstadoSemana = 0, 
							Establecido = 1
								WHERE ParametroId = @ParametroId
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END