-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Edita parametros de Proyectos
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ParametroEditar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ParametroEditar
GO
CREATE PROCEDURE dbo.ParametroEditar(
	@ParametroId INT,
	@ProyectoId INT,
	@Avance INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @ParametroId IS NOT NULL		
			IF EXISTS(SELECT ParametroId, ProyectoId 
							FROM dbo.Parametros
							WHERE ParametroId = @ParametroId AND
									ProyectoId = @ProyectoId)
				BEGIN
					UPDATE dbo.Parametros
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