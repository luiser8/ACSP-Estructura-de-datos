-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Busca Grafico
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.GraficoBuscar') IS NOT NULL ) 
   DROP PROCEDURE app.GraficoBuscar
GO
CREATE PROCEDURE app.GraficoBuscar
	@GraficoId INT = NULL,
	@Estado BIT = NULL
AS
BEGIN
	BEGIN TRY
			IF @GraficoId IS NOT NULL --Por Id
				BEGIN
					SELECT GraficoId, Nombre, Descripcion,
							Estado, Fecha 
								FROM [app].[Graficos] WITH (NOLOCK)
									WHERE GraficoId = @GraficoId
				END
			ELSE IF @GraficoId IS NULL AND @Estado IS NULL --Todos
				BEGIN
					SELECT GraficoId, Nombre, Descripcion,
							Estado, Fecha 
								FROM [app].[Graficos] WITH (NOLOCK)
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO