-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Edita Actividades al proyecto
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ActProyectoEditar') IS NOT NULL ) 
   DROP PROCEDURE app.ActProyectoEditar
GO
CREATE PROCEDURE app.ActProyectoEditar(
	@ActProyId INT,
	@TipoAct BIT, -- 1 OR 2
	@ProyectoId INT,
	@ParametroId INT,
	@Descripcion VARCHAR(255),
	@PlanAct TINYINT,
	@RealAct TINYINT,
	@FechaAct DATE,
	@Desviacion TINYINT)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF @ActProyId IS NOT NULL
			IF EXISTS(SELECT ActProyId, ProyectoId
							FROM [app].[ActProyectos]
							WHERE ActProyId = @ActProyId AND
									ProyectoId = @ProyectoId)
				BEGIN
					UPDATE [app].[ActProyectos]
						SET TipoAct = @TipoAct, 
							ProyectoId = @ProyectoId,
							ParametroId = @ParametroId,
							Descripcion = @Descripcion,
							PlanAct = @PlanAct,
							RealAct = @RealAct,
							FechaAct = CONVERT(DATE, @FechaAct, 105),
							Desviacion = @Desviacion
								WHERE ActProyId = @ActProyId
				END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END