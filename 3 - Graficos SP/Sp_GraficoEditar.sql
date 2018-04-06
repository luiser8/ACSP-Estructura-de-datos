-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Edita los Graficos
-- =============================================
IF ( OBJECT_ID('app.GraficoEditar') IS NOT NULL ) 
   DROP PROCEDURE app.GraficoEditar
GO
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
CREATE PROCEDURE app.GraficoEditar(
	@GraficoId INT,
	@Nombre VARCHAR(50),
	@Descripcion VARCHAR(125))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF ISNUMERIC(@GraficoId) = 1
			IF @GraficoId IS NOT NULL AND @GraficoId <> ''
				AND ISNULL(LTRIM(RTRIM(@Nombre)),'') <> ''
				IF NOT EXISTS(SELECT GraficoId 
						FROM [app].[Graficos]
						WHERE GraficoId = @GraficoId)
					BEGIN
						RAISERROR ('Error! No existe este Grafico', 16, 1);
						RETURN 1;					
					END
				BEGIN
					UPDATE [app].[Graficos] SET Nombre = @Nombre,
										Descripcion = @Descripcion
					WHERE GraficoId = @GraficoId
				END
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO