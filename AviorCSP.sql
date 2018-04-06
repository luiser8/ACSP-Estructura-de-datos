USE AviorCSP
GO
--TABLA DEPARTAMENTOS
CREATE TABLE [app].[Departamentos]
     ( 
        DptoId						INT	IDENTITY(1,1)			NOT NULL  , -- Identificador del Departamento
		Nombre						VARCHAR(125)				NOT NULL  , -- Nombre del Departamento
		Descripcion					VARCHAR(255)				NOT NULL  , -- Descripcion del Departamento
		Estado						BIT							NOT NULL	DEFAULT 1, -- 1 Activado 0, Desactivado 
		Fecha						DATETIME					NOT NULL	DEFAULT (GETDATE()), -- Fecha completa tiempo de creacion de un Departamento
			CONSTRAINT PK_Departamento PRIMARY KEY CLUSTERED (DptoId ASC) ON [PRIMARY]
     )		
GO

--TABLA GRAFICOS
CREATE TABLE [app].[Graficos]
     ( 
        GraficoId					INT	IDENTITY(1,1)			NOT NULL  ,  -- Identificador del grafico
		Nombre						VARCHAR(125)				NOT NULL  , -- Nombre del grafico (line, column, area)
		Descripcion					VARCHAR(255)				NOT NULL  , -- Descripcion del grafico
		Estado						BIT							NOT NULL	DEFAULT 1, -- 1 Activado 0, Desactivado
		Fecha						DATETIME					NOT NULL	DEFAULT (GETDATE()), -- Fecha completa creacion del grafico
			CONSTRAINT PK_Grafico PRIMARY KEY CLUSTERED (GraficoId ASC) ON [PRIMARY]
     )		
GO

--TABLA PROYECTOS
CREATE TABLE [app].[Proyectos]
     ( 
        ProyectoId					INT	IDENTITY(1,1)			NOT NULL  ,  -- Identificador del proyecto
		Codigo						VARCHAR(25)					NOT NULL  ,  -- Codigo especial del proyecto
 		DptoId						INT							NOT NULL  , -- Identificador del departamento a cual pertence
		UsuarioId					INT	REFERENCES [seg].[Usuarios]	NOT NULL  , --Identificador del usuario del sistema a cual pertence
        Nombre						VARCHAR(125)				NOT NULL  , -- Nombre del proyecto
        Descripcion					VARCHAR(255)				NOT NULL  , -- Descripcion del proyecto        
        GraficoId					INT	REFERENCES [app].[Graficos]		NOT NULL  , -- Identificador del tipo de grafico del proyecto
		Anio						SMALLINT					NOT NULL  , -- Año del proyecto
		FechaInicio					DATE						NOT NULL  , -- Fecha de inicio del proyecto
		FechaFin					DATE						NOT NULL  , -- Fecha de finalizacion del proyecto
		Estado						BIT							NOT NULL	DEFAULT 1, --0 Off, 1 Activo, 2 Culminado, 3 Replanificado
		Fecha						DATETIME					NOT NULL	DEFAULT (GETDATE()), -- Fecha completa de la creacion del proyecto
			CONSTRAINT PK_Proyectos PRIMARY KEY CLUSTERED (ProyectoId ASC) ON [PRIMARY],
			FOREIGN KEY (DptoId) REFERENCES [app].[Departamentos](DptoId)
				ON DELETE CASCADE ON UPDATE CASCADE
     )		
GO

--TABLA PARAMETROS E INTERVALOS
CREATE TABLE [app].[Parametros]
     ( 
        ParametroId					INT	IDENTITY(1,1)			NOT NULL  , -- Identificador del parametro
		ProyectoId					INT							NOT NULL  , -- Identificador del proyecto a cual le pertenezca este parametro
		Semana						DATE						NOT NULL  , -- Semana a cual se establezca el parametro
		CantidadDias				TINYINT						NOT NULL  , -- Intervalo de dias para la actualizacion del proyecto
		Avance						TINYINT						NOT NULL	DEFAULT 0 , --Avance planificado 0 Cuando se crea nuevo, 1 cuando se vaya creando las lineas
		EstadoSemana				BIT							NOT NULL	DEFAULT 1 , -- 1 Activo para colocarle los datos de los avances planificados, 0 cuando ya los establecemos
		Establecido					BIT							NOT NULL	DEFAULT 0 , -- 1 Establecido para que se muestre, 0 para que se oculte
		Estado						BIT							NOT NULL	DEFAULT 1, --1 Activado, 0 Desactivado
		Fecha						DATETIME					NOT NULL	DEFAULT (GETDATE()), -- Fecha completa de creacion del parametro
			CONSTRAINT PK_Parametros PRIMARY KEY CLUSTERED (ParametroId ASC) ON [PRIMARY],
			FOREIGN KEY (ProyectoId) REFERENCES [app].[Proyectos](ProyectoId)
				ON DELETE CASCADE ON UPDATE CASCADE
     )		
GO

--TABLA REPLANIFICACION DE PROYECTOS
CREATE TABLE [app].[Replanificacion]
     ( 
        ReplanId					INT	IDENTITY(1,1)			NOT NULL  ,  -- Identificador de la replanificacion de un proyecto
		ProyectoId					INT							NOT NULL  ,  -- Identificador del proyecto a replanificar
		Descripcion					VARCHAR(255)				NOT NULL  , -- Descripcion de dicha replanificacion
		FechaAnterior				DATE						NOT NULL  , -- Fecha anterior de inicio del proyecto
		FechaPosterior				DATE						NOT NULL  , -- Nueva fecha de finalizacion del proyecto
		Estado						BIT							NOT NULL	DEFAULT 1, --1 Activado, 0 Desactivado
		Fecha						DATETIME					NOT NULL	DEFAULT (GETDATE()), -- Fecha completa de creacion de una replanificacion
			CONSTRAINT PK_Replanificacion PRIMARY KEY CLUSTERED (ReplanId ASC) ON [PRIMARY],
			FOREIGN KEY (ProyectoId) REFERENCES [app].[Proyectos](ProyectoId)
				ON DELETE CASCADE ON UPDATE CASCADE
     )		
GO

--TABLA SEGUIMIENTO DE ACTIVIDADES
CREATE TABLE [app].[ActProyectos]
     ( 
        ActProyId					INT	IDENTITY(1,1)			NOT NULL  , -- Identificador de la actividad de un proyecto
		TipoAct						BIT							NOT NULL  , -- 1 Proyecto estado normal, 2 Proyecto replanificado
		ProyectoId					INT							NOT NULL  , -- Identificador del proyecto a cual pertence la actividad
		ParametroId					INT	REFERENCES [app].[Parametros]	NOT NULL  , -- Identificador del parametro de seguimiento
		Descripcion					VARCHAR(255)				NOT NULL  , -- Descripcion de la actividad
		PlanAct						TINYINT						NOT NULL  , -- Avance Planificado
		RealAct						TINYINT						NOT NULL  , -- Avance Real
		FechaAct					DATE						NOT NULL  , -- Fecha simple de la actividad
		Desviacion					TINYINT						NOT NULL  , -- Desviacion = Avance planificado - Avance Real
		Estado						BIT							NOT NULL	DEFAULT 1, -- 1 Activado , 0 Desactivado
		Fecha						DATETIME					NOT NULL	DEFAULT (GETDATE()), -- Fecha completa de creacion de una actividad
			CONSTRAINT PK_ActProyectos PRIMARY KEY CLUSTERED (ActProyId ASC) ON [PRIMARY],
			FOREIGN KEY (ProyectoId) REFERENCES [app].[Proyectos](ProyectoId)
				ON DELETE CASCADE ON UPDATE CASCADE
     )		
GO

--	TABLA REPORTES
CREATE TABLE [app].[Reportes]
     ( 
        ReporteId					INT	IDENTITY(1,1)			NOT NULL  ,  -- Identificador del reporte
		Codigo						VARCHAR(25)					NOT NULL  ,  -- Codigo especial del reporte
		UsuarioId					INT	REFERENCES [seg].[Usuarios]	NOT NULL  , -- Identificador del usuario del sistema
		DptoId						INT							NOT NULL  , -- Identificador del departamento
		Nombre						VARCHAR(125)				NOT NULL  , -- Nombre del reporte
		Descripcion					VARCHAR(255)				NOT NULL  , -- Descripcion del reporte
		GraficoId					INT	REFERENCES [app].[Graficos]		NOT NULL  , -- Identificador de tipo de grafico del reporte
		Simbolo						VARCHAR(11)					NOT NULL  , -- Simbolos del reporte (#, %)
		FechaInicio					DATE						NOT NULL  , -- Fecha simple del inicio del reporte
		Anio						SMALLINT					NOT NULL  , -- Año del reporte
		Estado						BIT							NOT NULL	DEFAULT 1, -- 1 Activado, 0 Desactivado
		Fecha						DATETIME					NOT NULL	DEFAULT (GETDATE()), -- Fecha completa de creacion de un reporte
			CONSTRAINT PK_Reporte PRIMARY KEY CLUSTERED (ReporteId ASC) ON [PRIMARY],
			FOREIGN KEY (DptoId) REFERENCES [app].[Departamentos](DptoId)
				ON DELETE CASCADE ON UPDATE CASCADE
     )		
GO

--TABLE SERIES PARA LOS REPORTES
CREATE TABLE [app].[SeriesReportes]
     ( 
        SerieRepId					INT	IDENTITY(1,1)			NOT NULL  , -- Identificador de la serie
		ReporteId					INT							NOT NULL  ,  -- Identificador del reporte a cual pertenece una serie
		PrimeraSerie				VARCHAR(125)				NOT NULL  , -- Nombre de la primera serie
		SegundaSerie				VARCHAR(125)				NOT NULL  , -- Nombre de la segunda serie
		TerceraSerie				VARCHAR(125)				NOT NULL  , -- Nombre de la tercera serie
		CuartaSerie					VARCHAR(125)				NOT NULL  , -- Nombre de la cuarta serie
		Estado						BIT							NOT NULL	DEFAULT 1, -- 1 Activado, 0 Desactivado
		Fecha						DATETIME					NOT NULL	DEFAULT (GETDATE()), -- Fecha completa de creacion de una serie
			CONSTRAINT PK_SeriesReportes PRIMARY KEY CLUSTERED (SerieRepId ASC) ON [PRIMARY],
			FOREIGN KEY (ReporteId) REFERENCES [app].[Reportes](ReporteId)
				ON DELETE CASCADE ON UPDATE CASCADE
     )			
GO

--TABLA ACTIVIDADES DE REPORTES
CREATE TABLE [app].[ActReportes]
     ( 
        ActRepId					INT	IDENTITY(1,1)			NOT NULL  , -- Identificador de la actividade de reportes
		ReporteId					INT							NOT NULL  , -- Identificador del reporte
		Descripcion					VARCHAR(125)				NOT NULL  , -- Descripcion de la actividad
		PrimeraAct					VARCHAR(125)				NOT NULL  , -- Primer dato de la actividad
		SegundaAct					VARCHAR(125)				NOT NULL  , -- Segundo dato de la actividad
		TerceraAct					VARCHAR(125)				NOT NULL  , -- Tercer dato de la actividad
		CuartaAct					VARCHAR(125)				NOT NULL  , -- Cuarto dato de la actividad
		Contenido					VARCHAR(125)				NOT NULL  , -- Dependiendo del reporte va variar
		SemanaAct					DATE						NOT NULL  , -- Semana 13-03-2018
		Estado						BIT							NOT NULL	DEFAULT 1, --1 Activado, 0 Desactivado
		Fecha						DATETIME					NOT NULL	DEFAULT (GETDATE()), -- Fecha completa de creacion de una actividad de reportes
			CONSTRAINT PK_TracingReport PRIMARY KEY CLUSTERED (ActRepId ASC) ON [PRIMARY],
			FOREIGN KEY (ReporteId) REFERENCES [app].[Reportes](ReporteId)
				ON DELETE CASCADE ON UPDATE CASCADE
     )				
GO