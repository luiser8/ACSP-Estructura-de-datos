-- =============================================
-- Author: Luis E. Rond�n
-- Create date: 12-03-2018
-- Description: Agrega los Graficos
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.GraficoInsertar') IS NOT NULL ) 
   DROP PROCEDURE app.GraficoInsertar
GO
CREATE PROCEDURE app.GraficoInsertar(
	@Nombre VARCHAR(50),
	@Descripcion VARCHAR(125))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @Nombre IS NOT NULL 
			AND ISNULL(LTRIM(RTRIM(@Nombre)),'') <> ''
			IF EXISTS(SELECT Nombre
							FROM [app].[Graficos]
							WHERE Nombre = @Nombre)
				BEGIN
					RAISERROR ('Error! Existe este Grafico!', 16, 1);
					RETURN 1;					
				END
			BEGIN
				INSERT INTO [app].[Graficos](Nombre, Descripcion)
				VALUES(@Nombre, @Descripcion)
			END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO