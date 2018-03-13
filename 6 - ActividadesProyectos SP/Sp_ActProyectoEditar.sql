-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Edita Actividades al proyecto
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ActProyectoEditar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ActProyectoEditar
GO
CREATE PROCEDURE dbo.ActProyectoEditar(
	@ActProyId INT,
	@TipoAct TINYINT, -- 1 OR 2
	@ProyectoId INT,
	@ParametroId INT,
	@DescripcionAct VARCHAR(255),
	@PlanAct VARCHAR(11),
	@RealAct VARCHAR(11),
	@FechaAct VARCHAR(11),
	@DesviacionAct VARCHAR(11))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @ActProyId IS NOT NULL
			IF EXISTS(SELECT ActProyId, ProyectoId
							FROM dbo.ActProyectos
							WHERE ActProyId = @ActProyId AND
									ProyectoId = @ProyectoId)
				BEGIN
					UPDATE dbo.ActProyectos
						SET TipoAct = @TipoAct, 
							ProyectoId = @ProyectoId,
							ParametroId = @ParametroId,
							DescripcionAct = @DescripcionAct,
							PlanAct = @PlanAct,
							RealAct = @RealAct,
							FechaAct = @FechaAct,
							DesviacionAct = @DesviacionAct
								WHERE ActProyId = @ActProyId
				END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END