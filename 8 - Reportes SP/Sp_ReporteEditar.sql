-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Editar Reportes
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ReporteEditar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ReporteEditar
GO
CREATE PROCEDURE dbo.ReporteEditar(
	@ReporteId INT,
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
		IF ISNUMERIC(@ReporteId) = 1
			IF @DptoId IS NOT NULL AND @ReporteId <> ''
				AND ISNULL(LTRIM(RTRIM(@Codigo)),'') <> ''
				IF EXISTS(SELECT ReporteId, Codigo
						FROM dbo.Reportes
						WHERE ReporteId = @ReporteId)
				BEGIN
					UPDATE dbo.Reportes SET Codigo = @Codigo, DptoId = @DptoId,
										UsuarioId = @UsuarioId, Nombre = @Nombre,
										Descripcion = @Descripcion, Grafico = @Grafico,
										Simbolo = @Simbolo, FechaInicio = @FechaInicio,
										Anio = @Anio
					WHERE ReporteId = @ReporteId
				END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO