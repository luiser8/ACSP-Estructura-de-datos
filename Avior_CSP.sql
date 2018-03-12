--TABLE DEPARTMENTS
CREATE TABLE Departments
     ( 
        IdDepartment				INT	IDENTITY(1,1)			NOT NULL  , 
		NameDepartment				VARCHAR(125)				NOT NULL  ,
		DescDepartment				VARCHAR(255)				NOT NULL  ,
		StatusDepartment			TINYINT						NOT NULL	DEFAULT 1, -- 1 On 0, Off 
		CreateDepartment			DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_Department PRIMARY KEY CLUSTERED (IdDepartment ASC) ON [PRIMARY]
     )		
GO

--TABLE USERS SYSTEM
CREATE TABLE UsersSystem
     ( 
        IdUserSystem				INT	IDENTITY(1,1)			NOT NULL  , 
		IdDepartment				INT							NOT NULL  ,
		FirstNameUser				VARCHAR(95)					NOT NULL  ,
		LastNameUser				VARCHAR(95)					NOT NULL  ,
		EmailUser					VARCHAR(95)					NOT NULL  ,
		PasswordUser				VARCHAR(125)				NOT NULL  ,
		TypeUserSystem				TINYINT						NOT NULL	DEFAULT 3, -- 3 Simple user, 2 Administrador, 1 Super Administrador
		StatusUserSystem			TINYINT						NOT NULL	DEFAULT 1, -- 1	On, 0 Off	
		CreateUserSystem			DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_UsersSystem PRIMARY KEY CLUSTERED (IdUserSystem ASC) ON [PRIMARY],
			FOREIGN KEY (IdDepartment) REFERENCES Departments(IdDepartment)
				ON DELETE CASCADE ON UPDATE CASCADE
     )			
GO

--TABLE PROJECTS
CREATE TABLE Projects
     ( 
        IdProject					INT	IDENTITY(1,1)			NOT NULL  , 
		CodProject					VARCHAR(25)					NOT NULL  , 
		IdDepartment				INT							NOT NULL  ,
		IdUserSystem				INT	REFERENCES UsersSystem	NOT NULL  ,
        NameProject					VARCHAR(125)				NOT NULL  , 
        DescProject					VARCHAR(255)				NOT NULL  ,         
        GraphicProject				VARCHAR(25)					NOT NULL  , 
		YearProject					VARCHAR(11)					NOT NULL  ,
		DateStartProject			VARCHAR(11)					NOT NULL  ,
		DateEndProject				VARCHAR(11)					NOT NULL  ,
		StatusProject				TINYINT						NOT NULL	DEFAULT 1, --0 Off, 1 On active, 2 Culminated, 3 Replanning
		CreateProject				DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_Projects PRIMARY KEY CLUSTERED (IdProject ASC) ON [PRIMARY],
			FOREIGN KEY (IdDepartment) REFERENCES Departments(IdDepartment)
				ON DELETE CASCADE ON UPDATE CASCADE
     )		
GO

--TABLE REPLANNING PROJECTS
CREATE TABLE Replanning
     ( 
        IdReplanning				INT	IDENTITY(1,1)			NOT NULL  , 
		IdProject					INT							NOT NULL  , 
		DescReplanning				VARCHAR(255)				NOT NULL  ,
		DateAfReplanning			VARCHAR(11)					NOT NULL  ,
		DateBeReplanning			VARCHAR(11)					NOT NULL  ,
		StatusReplanning			TINYINT						NOT NULL	DEFAULT 1, --0 Off, 1 On active
		CreateReplanning			DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_Replanning PRIMARY KEY CLUSTERED (IdReplanning ASC) ON [PRIMARY],
			FOREIGN KEY (IdProject) REFERENCES Projects(IdProject)
				ON DELETE CASCADE ON UPDATE CASCADE
     )		
GO

--TABLE WEEK PARAMETERS
CREATE TABLE Parameter
     ( 
        IdParameter					INT	IDENTITY(1,1)			NOT NULL  ,
		IdProject					INT							NOT NULL  , 
		WeekParameter				VARCHAR(11)					NOT NULL  , --Semana
		WeekCount					TINYINT						NOT NULL  ,
		WeekAdvance					TINYINT						NOT NULL	DEFAULT 0 , --Avance planificado 0 Cuando se crea nuevo, 1 cuando se vaya creando las lineas
		WeekStatus					TINYINT						NOT NULL	DEFAULT 1 , -- 1 Activo para colocarle los datos de los avances planificados, 0 cuando ya los establecemos
		WeekSee						TINYINT						NOT NULL	DEFAULT 0 , -- 1 Establecido para que se muestre, 0 para que se oculte
		StatusParameter				TINYINT						NOT NULL	DEFAULT 1, --0 Off, 1 On active
		CreateDepartment			DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_Parameter PRIMARY KEY CLUSTERED (IdParameter ASC) ON [PRIMARY],
			FOREIGN KEY (IdProject) REFERENCES Projects(IdProject)
				ON DELETE CASCADE ON UPDATE CASCADE
     )		
GO

--TABLE TRACING PROJECT
CREATE TABLE TracingProjects
     ( 
        IdTracProject				INT	IDENTITY(1,1)			NOT NULL  , 
		TypeTracProject				TINYINT						NOT NULL  , -- 1 Proyecto estado normal, 2 Proyecto replanificado
		IdProject					INT							NOT NULL  , 
		IdParameter					INT							NOT NULL  ,
		DescTracProject				VARCHAR(255)				NOT NULL  ,
		PlanTracProject				VARCHAR(11)					NOT NULL  ,
		RealTracProject				VARCHAR(11)					NOT NULL  ,
		DateTracProject				VARCHAR(11)					NOT NULL  ,
		DevTracProject				VARCHAR(11)					NOT NULL  , --Desviacion
		StatusTracProject			TINYINT						NOT NULL	DEFAULT 1, --0 Off, 1 On active
		CreateTracProject			DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_TracingProjects PRIMARY KEY CLUSTERED (IdTracProject ASC) ON [PRIMARY],
			FOREIGN KEY (IdProject) REFERENCES Projects(IdProject)
				ON DELETE CASCADE ON UPDATE CASCADE
     )		
GO

--TABLE STATS PROYECTS
CREATE TABLE StatsProjects
     ( 
        IdStatProject				INT	IDENTITY(1,1)			NOT NULL  , 
		IdProject					INT							NOT NULL  , 
		PlanTracProject				VARCHAR(11)					NOT NULL  ,
		RealTracProject				VARCHAR(11)					NOT NULL  ,
		DateStatProject				VARCHAR(11)					NOT NULL  ,
		StatusStatProject			TINYINT						NOT NULL	DEFAULT 1, --0 Off, 1 On active
		CreateStatProject			DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_StatsProjects PRIMARY KEY CLUSTERED (IdStatProject ASC) ON [PRIMARY],
			FOREIGN KEY (IdProject) REFERENCES Projects(IdProject)
				ON DELETE CASCADE ON UPDATE CASCADE
     )		
GO

--	TABLE REPORTS
CREATE TABLE Reports
     ( 
        IdReport					INT	IDENTITY(1,1)			NOT NULL  , 
		CodReport					VARCHAR(25)					NOT NULL  , 
		IdUserSystem				INT	REFERENCES UsersSystem	NOT NULL  ,
		IdDepartment				INT							NOT NULL  ,
		NameReport					VARCHAR(125)				NOT NULL  , 
		DescReport					VARCHAR(255)				NOT NULL  ,
		GraphicReport				VARCHAR(25)					NOT NULL  , 
		SymbolReport				VARCHAR(11)					NOT NULL  ,
		DateStartReport				VARCHAR(11)					NOT NULL  ,
		YearReport					VARCHAR(11)					NOT NULL  ,
		StatusReport				TINYINT						NOT NULL	DEFAULT 1, --0 Off, 1 On active
		CreateReport				DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_Report PRIMARY KEY CLUSTERED (IdReport ASC) ON [PRIMARY],
			FOREIGN KEY (IdDepartment) REFERENCES Departments(IdDepartment)
				ON DELETE CASCADE ON UPDATE CASCADE
     )		
GO

--SERIES FOR AND LEYEND REPORTS
CREATE TABLE SeriesReports
     ( 
        IdSerieReport				INT	IDENTITY(1,1)			NOT NULL  , 
		IdReport					INT							NOT NULL  , 
		FirstSerie					VARCHAR(125)				NOT NULL  ,
		SecondSerie					VARCHAR(125)				NOT NULL  ,
		ThirdSerie					VARCHAR(125)				NOT NULL  ,
		FourthSerie					VARCHAR(125)				NOT NULL  ,
		StatusSerieReport			TINYINT						NOT NULL	DEFAULT 1, --0 Off, 1 On active
		CreateSLReport				DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_SeriesReport PRIMARY KEY CLUSTERED (IdSerieReport ASC) ON [PRIMARY],
			FOREIGN KEY (IdReport) REFERENCES Reports(IdReport)
				ON DELETE CASCADE ON UPDATE CASCADE
     )			
GO

--TABLE TRACING REPORT
CREATE TABLE TracingReports
     ( 
        IdTracReport				INT	IDENTITY(1,1)			NOT NULL  , 
		IdReport					INT							NOT NULL  , 
		DescTracReport				VARCHAR(125)				NOT NULL  ,
		FirstValue					VARCHAR(125)				NOT NULL  ,
		SecondValue					VARCHAR(125)				NOT NULL  ,
		ThirdValue					VARCHAR(125)				NOT NULL  ,
		FourthValue					VARCHAR(125)				NOT NULL  ,
		WeekTracReport				VARCHAR(11)					NOT NULL  ,
		DataColumView				VARCHAR(155)				NOT NULL  , --data_report
		StatusTracReport			TINYINT						NOT NULL	DEFAULT 1, --0 Off, 1 On active
		CreateTracReport			DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_TracingReport PRIMARY KEY CLUSTERED (IdTracReport ASC) ON [PRIMARY],
			FOREIGN KEY (IdReport) REFERENCES Reports(IdReport)
				ON DELETE CASCADE ON UPDATE CASCADE
     )				
GO

--TABLE STATS REPORTS
CREATE TABLE StatsReports
     ( 
        IdStatReport				INT	IDENTITY(1,1)			NOT NULL  , 
		IdReport					INT							NOT NULL  , 
		DescStatReport				VARCHAR(125)				NOT NULL  , --Tarea o semana 5
		DateStatReport				VARCHAR(11)					NOT NULL  ,
		StatusStatReport			TINYINT						NOT NULL	DEFAULT 1, --0 Off, 1 On active
		CreateStatReport			DATETIME					NOT NULL	DEFAULT (GETDATE()) ,
			CONSTRAINT PK_StatsReports PRIMARY KEY CLUSTERED (IdStatReport ASC) ON [PRIMARY],
			FOREIGN KEY (IdReport) REFERENCES Reports(IdReport)
				ON DELETE CASCADE ON UPDATE CASCADE
     )		
GO