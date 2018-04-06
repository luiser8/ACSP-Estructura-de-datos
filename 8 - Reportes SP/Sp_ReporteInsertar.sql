-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Agrega Reportes
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ReporteInsertar') IS NOT NULL ) 
   DROP PROCEDURE app.ReporteInsertar
GO
CREATE PROCEDURE app.ReporteInsertar(
	@Codigo VARCHAR(50),
	@UsuarioId INT,
	@DptoId INT,
	@Nombre VARCHAR(125),
	@Descripcion VARCHAR(125),
	@GraficoId INT,
	@Simbolo VARCHAR(11),
	@FechaInicio VARCHAR(11),
	@Anio SMALLINT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @Codigo IS NOT NULL AND
			@DptoId IS NOT NULL
				AND ISNULL(LTRIM(RTRIM(@Codigo)),'') <> ''
				IF NOT EXISTS(SELECT Codigo, Nombre 
								FROM [app].[Reportes]
								WHERE Codigo = @Codigo)
				BEGIN 
					INSERT INTO [app].[Reportes](Codigo, UsuarioId, DptoId, 
												Nombre, Descripcion, GraficoId,
												Simbolo, FechaInicio, Anio)
					VALUES(@Codigo, @UsuarioId, @DptoId, @Nombre, 
								@Descripcion, @GraficoId, @Simbolo,
								CONVERT(DATE, @FechaInicio, 105), @Anio)
				END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO