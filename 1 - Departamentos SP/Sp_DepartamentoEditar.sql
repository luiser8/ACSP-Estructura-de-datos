-- =============================================
-- Author: Luis E. Rond�n
-- Create date: 12-03-2018
-- Description: Edita los Departamentos
-- =============================================
IF ( OBJECT_ID('app.DepartamentoEditar') IS NOT NULL ) 
   DROP PROCEDURE app.DepartamentoEditar
GO
USE AviorCSP
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO
CREATE PROCEDURE app.DepartamentoEditar(
	@DptoId INT,
	@Nombre VARCHAR(50),
	@Descripcion VARCHAR(125))
AS
BEGIN
SET NOCOUNT ON;
	BEGIN TRY
		IF ISNUMERIC(@DptoId) = 1
			IF @DptoId IS NOT NULL AND @DptoId <> ''
				AND ISNULL(LTRIM(RTRIM(@Nombre)),'') <> ''
				IF NOT EXISTS(SELECT DptoId 
						FROM [app].[Departamentos]
						WHERE DptoId = @DptoId)
					BEGIN
						RAISERROR ('Error! No existe este Departamento', 16, 1);
						RETURN 1;					
					END
				BEGIN
					UPDATE [app].[Departamentos] SET Nombre = @Nombre,
										Descripcion = @Descripcion
					WHERE DptoId = @DptoId
				END
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE() AS ERROR,
				ERROR_NUMBER() AS ERROR_NRO
	END CATCH;
END
GO