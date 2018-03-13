-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Agrega Actividades al Reportes
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ActReporteInsertar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ActReporteInsertar
GO
CREATE PROCEDURE dbo.ActReporteInsertar(
	@ReporteId INT,
	@DescAct VARCHAR(125),
	@PrimAct VARCHAR(125),
	@SegAct VARCHAR(125),
	@TercAct VARCHAR(125),
	@CuartAct VARCHAR(125),
	@Contenido VARCHAR(125),
	@SemAct VARCHAR(11))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @ReporteId IS NOT NULL 
			IF EXISTS(SELECT ReporteId
							FROM dbo.Reportes
							WHERE ReporteId = @ReporteId)
				BEGIN
					INSERT INTO dbo.ActReportes(ReporteId, DescAct, PrimAct, SegAct,
													TercAct, CuartAct, Contenido, SemAct)
					VALUES(@ReporteId, @DescAct, @PrimAct, @SegAct, @TercAct,
							@CuartAct, @Contenido, @SemAct)
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END