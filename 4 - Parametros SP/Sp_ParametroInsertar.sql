-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Agrega parametros de Proyectos
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ParametroInsertar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ParametroInsertar
GO
CREATE PROCEDURE dbo.ParametroInsertar(
	@ProyectoId INT,
	@Semana VARCHAR(11),
	@CantidadDias INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @ProyectoId IS NOT NULL
			BEGIN
				INSERT INTO dbo.Parametros(ProyectoId, Semana, CantidadDias)
				VALUES(@ProyectoId, @Semana, @CantidadDias)
			END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END