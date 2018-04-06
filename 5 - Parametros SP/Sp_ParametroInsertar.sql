-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Agrega parametros de Proyectos
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ParametroInsertar') IS NOT NULL ) 
   DROP PROCEDURE app.ParametroInsertar
GO
CREATE PROCEDURE app.ParametroInsertar(
	@ProyectoId INT,
	@Semana VARCHAR(11),
	@CantidadDias TINYINT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @ProyectoId IS NOT NULL
			BEGIN
				INSERT INTO [app].[Parametros](ProyectoId, Semana, CantidadDias)
				VALUES(@ProyectoId, CONVERT(DATE, @Semana, 105), @CantidadDias)
			END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END