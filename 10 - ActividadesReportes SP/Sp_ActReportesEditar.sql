-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Editar Actividades al Reportes
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ActReporteEditar') IS NOT NULL ) 
   DROP PROCEDURE app.ActReporteEditar
GO
CREATE PROCEDURE app.ActReporteEditar(
	@ActRepId INT,
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
		IF @ActRepId IS NOT NULL			
			IF EXISTS(SELECT ActRepId, ReporteId 
							FROM [app].[ActReportes]
							WHERE ActRepId = @ActRepId AND
									ReporteId = @ReporteId)
				BEGIN
					UPDATE [app].[ActReportes]
						SET ReporteId = @ReporteId,
							Descripcion = @Descripcion,
							PrimeraAct = @PrimeraAct,
							SegundaAct = @SegundaAct,
							TerceraAct = @TerceraAct,
							CuartaAct = @CuartaAct,
							Contenido = @Contenido,
							SemanaAct = CONVERT(DATE, @SemanaAct, 105)
								WHERE ActRepId = @ActRepId
				END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END