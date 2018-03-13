-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Busca parametros de Proyectos
-- =============================================
USE Avior
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('dbo.ParametroBuscar') IS NOT NULL ) 
   DROP PROCEDURE dbo.ParametroBuscar
GO
CREATE PROCEDURE dbo.ParametroBuscar
	@ProyectoId INT = NULL,
	@Estado INT = NULL
AS
SET NOCOUNT ON;
BEGIN
	BEGIN TRY
		IF @ProyectoId IS NOT NULL --Por Id
			BEGIN
					SELECT ParametroId, ProyectoId, Semana,
							CantidadDias, Avance, EstadoSemana,
							 Establecido, Estado, Fecha 
								FROM dbo.Parametros WITH (NOLOCK)
									WHERE ProyectoId = @ProyectoId
				END
			ELSE IF @ProyectoId IS NULL AND @Estado IS NULL --Todos
				BEGIN
						SELECT ParametroId, ProyectoId, Semana,
							CantidadDias, Avance, EstadoSemana,
							 Establecido, Estado, Fecha 
								FROM dbo.Parametros WITH (NOLOCK)
				END	
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END