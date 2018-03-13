-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Agrega Reportes
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ReporteInsertar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ReporteInsertar
GO
CREATE PROCEDURE dbo.ReporteInsertar(
	@Codigo VARCHAR(50),
	@UsuarioId INT,
	@DptoId INT,
	@Nombre VARCHAR(125),
	@Descripcion VARCHAR(125),
	@Grafico VARCHAR(125),
	@Simbolo VARCHAR(11),
	@FechaInicio VARCHAR(11),
	@Anio VARCHAR(11))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @Codigo IS NOT NULL AND
			@DptoId IS NOT NULL
				AND ISNULL(LTRIM(RTRIM(@Codigo)),'') <> ''
				IF NOT EXISTS(SELECT Codigo, Nombre 
								FROM dbo.Reportes
								WHERE Codigo = @Codigo)
				BEGIN
					INSERT INTO dbo.Reportes(Codigo, UsuarioId, DptoId, 
												Nombre, Descripcion, Grafico,
												Simbolo, FechaInicio, Anio)
					VALUES(@Codigo, @UsuarioId, @DptoId, @Nombre, 
								@Descripcion, @Grafico, @Simbolo,
								@FechaInicio, @Anio)
				END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO