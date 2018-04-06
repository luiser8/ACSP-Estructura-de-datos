-- =============================================
-- Author: Luis E. Rondón
-- Create date: 12-03-2018
-- Description: Busca Departamentos
-- =============================================
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
IF ( OBJECT_ID('app.DepartamentoBuscar') IS NOT NULL ) 
   DROP PROCEDURE app.DepartamentoBuscar
GO
CREATE PROCEDURE app.DepartamentoBuscar
	@DptoId INT = NULL,
	@Estado BIT = NULL
AS
BEGIN
	BEGIN TRY
			IF @DptoId IS NOT NULL --Por Id
				BEGIN
					SELECT DptoId, Nombre, Descripcion,
							Estado, Fecha 
								FROM [app].[Departamentos] WITH (NOLOCK)
									WHERE DptoId = @DptoId
				END
			ELSE IF @DptoId IS NULL AND @Estado IS NULL --Todos
				BEGIN
					SELECT DptoId, Nombre, Descripcion,
							Estado, Fecha 
								FROM [app].[Departamentos] WITH (NOLOCK)
				END
	END TRY
	BEGIN CATCH
	SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO