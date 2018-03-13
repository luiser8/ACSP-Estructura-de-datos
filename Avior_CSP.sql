--TABLA DEPARTAMENTOS
CREATE TABLE Departamentos
     ( 
        DptoId						INT	IDENTITY(1,1)			NOT NULL  , 
		Nombre						VARCHAR(125)				NOT NULL  ,
		Descripcion					VARCHAR(255)				NOT NULL  ,
		Estado						TINYINT						NOT NULL	DEFAULT 1, -- 1 On 0, Off 
		Fecha						DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_Departamento PRIMARY KEY CLUSTERED (DptoId ASC) ON [PRIMARY]
     )		
GO

--TABLA USUARIOS SISTEMA
CREATE TABLE UsuarioSistema
     ( 
        UsuarioId					INT	IDENTITY(1,1)			NOT NULL  , 
		DptoId						INT							NOT NULL  ,
		Nombres						VARCHAR(95)					NOT NULL  ,
		Apellidos					VARCHAR(95)					NOT NULL  ,
		Correo						VARCHAR(95)					NOT NULL  ,
		Clave						VARCHAR(125)				NOT NULL  ,
		NivelAcceso					TINYINT						NOT NULL	DEFAULT 3, -- 3 Usuario simple, 2 Administrador, 1 Super Administrador
		Estado						TINYINT						NOT NULL	DEFAULT 1, -- 1	On, 0 Off	
		Fecha						DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_UsersSystem PRIMARY KEY CLUSTERED (UsuarioId ASC) ON [PRIMARY],
			FOREIGN KEY (DptoId) REFERENCES Departamentos(DptoId)
				ON DELETE CASCADE ON UPDATE CASCADE
     )			
GO

--TABLA PROYECTOS
CREATE TABLE Proyectos
     ( 
        ProyectoId					INT	IDENTITY(1,1)			NOT NULL  , 
		Codigo						VARCHAR(25)					NOT NULL  , 
		DptoId						INT							NOT NULL  ,
		UsuarioId					INT	REFERENCES UsuarioSistema	NOT NULL  ,
        Nombre						VARCHAR(125)				NOT NULL  , 
        Descripcion					VARCHAR(255)				NOT NULL  ,         
        Grafico						VARCHAR(25)					NOT NULL  , --Linea, Columna, Torta
		Anio						VARCHAR(11)					NOT NULL  ,
		FechaInicio					VARCHAR(11)					NOT NULL  ,
		FechaFin					VARCHAR(11)					NOT NULL  ,
		Estado						TINYINT						NOT NULL	DEFAULT 1, --0 Off, 1 Activo, 2 Culminado, 3 Replanificado
		Fecha						DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_Proyectos PRIMARY KEY CLUSTERED (ProyectoId ASC) ON [PRIMARY],
			FOREIGN KEY (DptoId) REFERENCES Departamentos(DptoId)
				ON DELETE CASCADE ON UPDATE CASCADE
     )		
GO

--TABLA PARAMETROS E INTERVALOS
CREATE TABLE Parametros
     ( 
        ParametroId					INT	IDENTITY(1,1)			NOT NULL  ,
		ProyectoId					INT							NOT NULL  , 
		Semana						VARCHAR(11)					NOT NULL  , --Semana
		CantidadDias				TINYINT						NOT NULL  , -- Cantidad de dias que hay entre fecha inicial del proyecto y final
		Avance						TINYINT						NOT NULL	DEFAULT 0 , --Avance planificado 0 Cuando se crea nuevo, 1 cuando se vaya creando las lineas
		EstadoSemana				TINYINT						NOT NULL	DEFAULT 1 , -- 1 Activo para colocarle los datos de los avances planificados, 0 cuando ya los establecemos
		Establecido					TINYINT						NOT NULL	DEFAULT 0 , -- 1 Establecido para que se muestre, 0 para que se oculte
		Estado						TINYINT						NOT NULL	DEFAULT 1, --0 Off, 1 On Activo
		Fecha						DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_Parametros PRIMARY KEY CLUSTERED (ParametroId ASC) ON [PRIMARY],
			FOREIGN KEY (ProyectoId) REFERENCES Proyectos(ProyectoId)
				ON DELETE CASCADE ON UPDATE CASCADE
     )		
GO

--TABLA REPLANIFICACION DE PROYECTOS
CREATE TABLE Replanificacion
     ( 
        ReplanId					INT	IDENTITY(1,1)			NOT NULL  , 
		ProyectoId					INT							NOT NULL  , 
		Descripcion					VARCHAR(255)				NOT NULL  ,
		FechaAnterior				VARCHAR(11)					NOT NULL  ,
		FechaPosterior				VARCHAR(11)					NOT NULL  ,
		Estado						TINYINT						NOT NULL	DEFAULT 1, --0 Off, 1 On active
		Fecha						DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_Replanificacion PRIMARY KEY CLUSTERED (ReplanId ASC) ON [PRIMARY],
			FOREIGN KEY (ProyectoId) REFERENCES Proyectos(ProyectoId)
				ON DELETE CASCADE ON UPDATE CASCADE
     )		
GO

--TABLA SEGUIMIENTO DE ACTIVIDADES
CREATE TABLE ActProyectos
     ( 
        ActProyId					INT	IDENTITY(1,1)			NOT NULL  , 
		TipoAct						TINYINT						NOT NULL  , -- 1 Proyecto estado normal, 2 Proyecto replanificado
		ProyectoId					INT							NOT NULL  , 
		ParametroId					INT							NOT NULL  ,
		DescripcionAct				VARCHAR(255)				NOT NULL  ,
		PlanAct						VARCHAR(11)					NOT NULL  , --Avance Planificado
		RealAct						VARCHAR(11)					NOT NULL  , -- Avance Real
		FechaAct					VARCHAR(11)					NOT NULL  ,
		DesviacionAct				VARCHAR(11)					NOT NULL  , --Desviacion = Avance planificado - Avance Real
		Estado						TINYINT						NOT NULL	DEFAULT 1, --0 Off, 1 On Activo
		Fecha						DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_ActProyectos PRIMARY KEY CLUSTERED (ActProyId ASC) ON [PRIMARY],
			FOREIGN KEY (ProyectoId) REFERENCES Proyectos(ProyectoId)
				ON DELETE CASCADE ON UPDATE CASCADE
     )		
GO

--TABLA ESTADISTICAS DE PROYECTOS
CREATE TABLE EstProyectos
     ( 
        EstProyId					INT	IDENTITY(1,1)			NOT NULL  , 
		ProyectoId					INT							NOT NULL  , 
		PlanEst						VARCHAR(11)					NOT NULL  ,
		RealEst						VARCHAR(11)					NOT NULL  ,
		FechacEst					VARCHAR(11)					NOT NULL  ,
		Estado						TINYINT						NOT NULL	DEFAULT 1, --0 Off, 1 On Activo
		Fecha						DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_EstProyectos PRIMARY KEY CLUSTERED (EstProyId ASC) ON [PRIMARY],
			FOREIGN KEY (ProyectoId) REFERENCES Proyectos(ProyectoId)
				ON DELETE CASCADE ON UPDATE CASCADE
     )		
GO

--	TABLA REPORTES
CREATE TABLE Reportes
     ( 
        ReporteId					INT	IDENTITY(1,1)			NOT NULL  , 
		Codigo						VARCHAR(25)					NOT NULL  , 
		UsuarioId					INT	REFERENCES UsuarioSistema	NOT NULL  ,
		DptoId						INT							NOT NULL  ,
		Nombre						VARCHAR(125)				NOT NULL  , 
		Descripcion					VARCHAR(255)				NOT NULL  ,
		Grafico						VARCHAR(25)					NOT NULL  , --Linea, Columna, Torta
		Simbolo						VARCHAR(11)					NOT NULL  , --#, %
		FechaInicio					VARCHAR(11)					NOT NULL  ,
		Anio						VARCHAR(11)					NOT NULL  ,
		Estado						TINYINT						NOT NULL	DEFAULT 1, --0 Off, 1 On Activo
		Fecha						DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_Reporte PRIMARY KEY CLUSTERED (ReporteId ASC) ON [PRIMARY],
			FOREIGN KEY (DptoId) REFERENCES Departamentos(DptoId)
				ON DELETE CASCADE ON UPDATE CASCADE
     )		
GO

--SERIES PARA LOS REPORTES
CREATE TABLE SeriesReportes
     ( 
        SerieRepId					INT	IDENTITY(1,1)			NOT NULL  , 
		ReporteId					INT							NOT NULL  , 
		PrimSerie					VARCHAR(125)				NOT NULL  ,
		SegSerie					VARCHAR(125)				NOT NULL  ,
		TercSerie					VARCHAR(125)				NOT NULL  ,
		CuarSerie					VARCHAR(125)				NOT NULL  ,
		Estado						TINYINT						NOT NULL	DEFAULT 1, --0 Off, 1 On Activo
		Fecha						DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_SeriesReportes PRIMARY KEY CLUSTERED (SerieRepId ASC) ON [PRIMARY],
			FOREIGN KEY (ReporteId) REFERENCES Reportes(ReporteId)
				ON DELETE CASCADE ON UPDATE CASCADE
     )			
GO

--TABLA ACTIVIDADES DE REPORTES
CREATE TABLE ActReportes
     ( 
        ActRepId					INT	IDENTITY(1,1)			NOT NULL  , 
		ReporteId					INT							NOT NULL  , 
		DescAct						VARCHAR(125)				NOT NULL  ,
		PrimAct						VARCHAR(125)				NOT NULL  ,
		SegAct						VARCHAR(125)				NOT NULL  ,
		TercAct						VARCHAR(125)				NOT NULL  ,
		CuartAct					VARCHAR(125)				NOT NULL  ,
		Contenido					VARCHAR(125)				NOT NULL  , --Dependiendo del reporte va variar
		SemAct						VARCHAR(11)					NOT NULL  , --Semana 13-03-2018
		Estado						TINYINT						NOT NULL	DEFAULT 1, --0 Off, 1 On Activo
		Fecha						DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_TracingReport PRIMARY KEY CLUSTERED (ActRepId ASC) ON [PRIMARY],
			FOREIGN KEY (ReporteId) REFERENCES Reportes(ReporteId)
				ON DELETE CASCADE ON UPDATE CASCADE
     )				
GO

--TABLA ESTADISTICAS DE REPORTES
CREATE TABLE EstReportes
     ( 
        EstRepId					INT	IDENTITY(1,1)			NOT NULL  , 
		ReporteId					INT							NOT NULL  , 
		Descripcion					VARCHAR(125)				NOT NULL  , --Tarea o semana nro 8
		FechaEst					VARCHAR(11)					NOT NULL  ,
		Estado						TINYINT						NOT NULL	DEFAULT 1, --0 Off, 1 On Activo
		Fecha						DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_EstReportes PRIMARY KEY CLUSTERED (EstRepId ASC) ON [PRIMARY],
			FOREIGN KEY (ReporteId) REFERENCES Reportes(ReporteId)
				ON DELETE CASCADE ON UPDATE CASCADE
     )		
GO