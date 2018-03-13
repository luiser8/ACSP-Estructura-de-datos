-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Editar Actividades al Reportes
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ActReporteEditar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ActReporteEditar
GO
CREATE PROCEDURE dbo.ActReporteEditar(
	@ActRepId INT,
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
		IF @ActRepId IS NOT NULL			
			IF EXISTS(SELECT ActRepId, ReporteId 
							FROM dbo.ActReportes
							WHERE ActRepId = @ActRepId AND
									ReporteId = @ReporteId)
				BEGIN
					UPDATE dbo.ActReportes
						SET ReporteId = @ReporteId,
							DescAct = @DescAct,
							PrimAct = @PrimAct,
							SegAct = @SegAct,
							TercAct = @TercAct,
							CuartAct = @CuartAct,
							Contenido = @Contenido,
							SemAct = @SemAct
								WHERE ActRepId = @ActRepId
				END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END