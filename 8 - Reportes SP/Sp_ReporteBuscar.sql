-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Buscar Reportes
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ReporteBuscar') IS NOT NULL ) 
   DROP PROCEDURE app.ReporteBuscar
GO
CREATE PROCEDURE app.ReporteBuscar
	@ReporteId INT = NULL,
	@Estado BIT = NULL
AS
BEGIN
	BEGIN TRY
		IF @ReporteId IS NOT NULL --Por Id
			BEGIN
				SELECT ReporteId, Codigo, UsuarioId, DptoId, 
						Nombre, Descripcion, GraficoId,
						 Simbolo, FechaInicio, Anio,
							Estado, Fecha
							FROM [app].[Reportes] WITH (NOLOCK)
								WHERE ReporteId = @ReporteId
			END
		ELSE IF @ReporteId IS NULL AND @Estado IS NULL --Todos
			BEGIN
					SELECT ReporteId, Codigo, UsuarioId, DptoId, 
						Nombre, Descripcion, GraficoId,
						 Simbolo, FechaInicio, Anio,
							Estado, Fecha
							FROM [app].[Reportes] WITH (NOLOCK)
			END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO