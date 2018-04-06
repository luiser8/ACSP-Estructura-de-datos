-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Agrega Actividades al proyecto
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ActProyectoInsertar') IS NOT NULL ) 
   DROP PROCEDURE app.ActProyectoInsertar
GO
CREATE PROCEDURE app.ActProyectoInsertar(
	@TipoAct BIT, -- 1 OR 2
	@ProyectoId INT,
	@ParametroId INT,
	@Descripcion VARCHAR(255),
	@PlanAct TINYINT,
	@RealAct TINYINT,
	@FechaAct VARCHAR(11),
	@Desviacion TINYINT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @ProyectoId IS NOT NULL 
			IF EXISTS(SELECT ProyectoId
							FROM [app].[Proyectos]
							WHERE ProyectoId = @ProyectoId)
				BEGIN 
					INSERT INTO [app].[ActProyectos](TipoAct, ProyectoId, ParametroId,
													Descripcion, PlanAct, RealAct,
													FechaAct, Desviacion)
					VALUES(@TipoAct ,@ProyectoId, @ParametroId, @Descripcion,
							@PlanAct, @RealAct, CONVERT(DATE, @FechaAct, 105), @Desviacion)					
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END