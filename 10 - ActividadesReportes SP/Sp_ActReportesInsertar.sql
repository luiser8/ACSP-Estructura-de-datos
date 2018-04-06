-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Agrega Actividades al Reportes
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ActReporteInsertar') IS NOT NULL ) 
   DROP PROCEDURE app.ActReporteInsertar
GO
CREATE PROCEDURE app.ActReporteInsertar(
	@ReporteId INT,
	@Descripcion VARCHAR(125),
	@PrimeraAct VARCHAR(125),
	@SegundaAct VARCHAR(125),
	@TerceraAct VARCHAR(125),
	@CuartaAct VARCHAR(125),
	@Contenido VARCHAR(125),
	@SemanaAct VARCHAR(11))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @ReporteId IS NOT NULL 
			IF EXISTS(SELECT ReporteId
							FROM [app].[Reportes]
							WHERE ReporteId = @ReporteId)
				BEGIN
					INSERT INTO [app].[ActReportes](ReporteId, Descripcion, PrimeraAct, SegundaAct,
													TerceraAct, CuartaAct, Contenido, SemanaAct)
					VALUES(@ReporteId, @Descripcion, @PrimeraAct, @SegundaAct, @TerceraAct,
							@CuartaAct, @Contenido, CONVERT(DATE, @SemanaAct, 105))
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END