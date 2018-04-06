-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Edita Proyectos
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.ProyectoEditar') IS NOT NULL ) 
   DROP PROCEDURE app.ProyectoEditar
GO
CREATE PROCEDURE app.ProyectoEditar(
	@ProyectoId INT,
	@Codigo VARCHAR(50),
	@DptoId INT,
	@UsuarioId INT,
	@Nombre VARCHAR(125),
	@Descripcion VARCHAR(125),
	@GraficoId INT,
	@Anio SMALLINT,
	@FechaInicio DATE,
	@FechaFin DATE)
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF ISNUMERIC(@ProyectoId) = 1
			IF @DptoId IS NOT NULL AND @ProyectoId <> ''
				AND ISNULL(LTRIM(RTRIM(@Codigo)),'') <> ''
					IF NOT EXISTS(SELECT ProyectoId, Codigo
						FROM [app].[Proyectos]
							WHERE ProyectoId = @ProyectoId)
							BEGIN
								RAISERROR ('Error! No existe este proyecto', 16, 1);
								RETURN 1;
							END
					BEGIN
						UPDATE [app].[Proyectos] SET Codigo = @Codigo, DptoId = @DptoId,
										UsuarioId = @UsuarioId, Nombre = @Nombre,
										Descripcion = @Descripcion, GraficoId = @GraficoId,
										Anio = @Anio, FechaInicio = CONVERT(DATE, @FechaInicio, 105), 
										FechaFin = CONVERT(DATE, @FechaFin, 105)
						WHERE ProyectoId = @ProyectoId
					END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO