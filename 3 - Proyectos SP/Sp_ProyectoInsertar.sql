-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Agrega Proyectos
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ProyectoInsertar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ProyectoInsertar
GO
CREATE PROCEDURE dbo.ProyectoInsertar(
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
		IF @Codigo IS NOT NULL AND
			@DptoId IS NOT NULL
				AND ISNULL(LTRIM(RTRIM(@Codigo)),'') <> ''
					IF EXISTS(SELECT Codigo, Nombre 
								FROM dbo.Proyectos
								WHERE Codigo = @Codigo)
						BEGIN
							RAISERROR ('Error! Existe este proyecto', 16, 1);
							RETURN 1;					
						END
					BEGIN
						INSERT INTO dbo.Proyectos(Codigo, DptoId, UsuarioId, 
												Nombre, Descripcion, Grafico,
												Anio, FechaInicio, FechaFin)
						VALUES(@Codigo, @DptoId, @UsuarioId, 
							@Nombre, @Descripcion, @Grafico, 
							@Anio, @FechaInicio, @FechaFin)
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO