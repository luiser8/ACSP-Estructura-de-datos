-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Edita Proyectos
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ProyectoEditar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ProyectoEditar
GO
CREATE PROCEDURE dbo.ProyectoEditar(
	@ProyectoId INT,
	@Codigo VARCHAR(50),
	@DptoId INT,
	@UsuarioId INT,
	@Nombre VARCHAR(125),
	@Descripcion VARCHAR(125),
	@Grafico VARCHAR(125),
	@Anio VARCHAR(11),
	@FechaInicio VARCHAR(11),
	@FechaFin VARCHAR(11))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF ISNUMERIC(@ProyectoId) = 1
			IF @DptoId IS NOT NULL AND @ProyectoId <> ''
				AND ISNULL(LTRIM(RTRIM(@Codigo)),'') <> ''
					IF NOT EXISTS(SELECT ProyectoId, Codigo
						FROM dbo.Proyectos
							WHERE ProyectoId = @ProyectoId)
							BEGIN
								RAISERROR ('Error! No existe este proyecto', 16, 1);
								RETURN 1;
							END	
					BEGIN
						UPDATE dbo.Proyectos SET Codigo = @Codigo, DptoId = @DptoId,
										UsuarioId = @UsuarioId, Nombre = @Nombre,
										Descripcion = @Descripcion, Grafico = @Grafico,
										Anio = @Anio, FechaInicio = @FechaInicio, 
										FechaFin = @FechaFin
						WHERE ProyectoId = @ProyectoId
					END
	END TRY
		BEGIN CATCH
			SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
		END CATCH;
END
GO