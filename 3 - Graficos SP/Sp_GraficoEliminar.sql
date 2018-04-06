-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Borrado lógico Graficos
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.GraficoEliminar') IS NOT NULL ) 
   DROP PROCEDURE app.GraficoEliminar
GO
CREATE PROCEDURE app.GraficoEliminar(
	@GraficoId INT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF NOT EXISTS(SELECT GraficoId 
						FROM [app].[Graficos]
						WHERE GraficoId = @GraficoId)
			BEGIN
				RAISERROR ('Error! No existe este Grafico', 16, 1);
				RETURN 1;					
			END
		BEGIN
			UPDATE [app].[Graficos] SET Estado = 0
				WHERE GraficoId = @GraficoId
		END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO