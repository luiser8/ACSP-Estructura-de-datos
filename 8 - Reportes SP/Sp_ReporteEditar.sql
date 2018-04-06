-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Editar Reportes
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ReporteEditar') IS NOT NULL ) 
   DROP PROCEDURE app.ReporteEditar
GO
CREATE PROCEDURE app.ReporteEditar(
	@ReporteId INT,
	@Codigo VARCHAR(50),
	@UsuarioId INT,
	@DptoId INT,
	@Nombre VARCHAR(125),
	@Descripcion VARCHAR(125),
	@GraficoId INT,
	@Simbolo VARCHAR(11),
	@FechaInicio DATE,
	@Anio SMALLINT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF ISNUMERIC(@ReporteId) = 1
			IF @DptoId IS NOT NULL AND @ReporteId <> ''
				AND ISNULL(LTRIM(RTRIM(@Codigo)),'') <> ''
				IF EXISTS(SELECT ReporteId, Codigo
						FROM [app].[Reportes]
						WHERE ReporteId = @ReporteId)
				BEGIN
					UPDATE [app].[Reportes] SET Codigo = @Codigo, DptoId = @DptoId,
										UsuarioId = @UsuarioId, Nombre = @Nombre,
										Descripcion = @Descripcion, GraficoId = @GraficoId,
										Simbolo = @Simbolo, FechaInicio = CONVERT(DATE, @FechaInicio, 105),
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