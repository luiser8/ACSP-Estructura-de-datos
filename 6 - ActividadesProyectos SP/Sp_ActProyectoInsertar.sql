-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Agrega Actividades al proyecto
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ActProyectoInsertar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ActProyectoInsertar
GO
CREATE PROCEDURE dbo.ActProyectoInsertar(
	@TipoAct TINYINT, -- 1 OR 2
	@ProyectoId INT,
	@ParametroId INT,
	@Descripcion VARCHAR(255),
	@PlanAct VARCHAR(11),
	@RealAct VARCHAR(11),
	@FechaAct VARCHAR(11),
	@DesviacionAct VARCHAR(11))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @ProyectoId IS NOT NULL 
			IF EXISTS(SELECT ProyectoId
							FROM dbo.Proyectos
							WHERE ProyectoId = @ProyectoId)
				BEGIN
					INSERT INTO dbo.ActProyectos(TipoAct, ProyectoId, ParametroId,
													DescripcionAct, PlanAct, RealAct,
													FechaAct, DesviacionAct)
					VALUES(@TipoAct ,@ProyectoId, @ParametroId, @Descripcion,
							@PlanAct, @RealAct, @FechaAct, @DesviacionAct)					
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END