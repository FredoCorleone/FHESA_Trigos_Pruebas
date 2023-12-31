USE [TNLTRG]
GO
/****** Object:  Table [dbo].[cAliast]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cAliast](
	[Nombret] [varchar](10) NULL,
	[Alias] [varchar](3) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cEstados]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cEstados](
	[EstadoId] [char](1) NOT NULL,
	[Nombre] [varchar](30) NULL,
 CONSTRAINT [PK_cEstados] PRIMARY KEY CLUSTERED 
(
	[EstadoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cMoneda]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cMoneda](
	[MonedaId] [varchar](10) NOT NULL,
	[Descripcion] [varchar](100) NULL,
	[Activo] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MonedaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cOpcsist]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cOpcsist](
	[OpcionId] [smallint] NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Nmbmost] [varchar](100) NULL,
	[Prmsosap] [smallint] NOT NULL,
	[Opcnidp] [smallint] NOT NULL,
	[VisId] [smallint] NULL,
 CONSTRAINT [PK_cOpcsist] PRIMARY KEY CLUSTERED 
(
	[OpcionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cPuestos]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cPuestos](
	[PuestoId] [varchar](10) NOT NULL,
	[Nombre] [varchar](100) NULL,
 CONSTRAINT [PK_cPuestos] PRIMARY KEY CLUSTERED 
(
	[PuestoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cTipodat]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cTipodat](
	[TpodatId] [tinyint] NOT NULL,
	[Nombre] [varchar](20) NULL,
 CONSTRAINT [PK_cTipodat] PRIMARY KEY CLUSTERED 
(
	[TpodatId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cTipodoc]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cTipodoc](
	[TpodocId] [smallint] NOT NULL,
	[Nombre] [varchar](50) NULL,
 CONSTRAINT [PK_ctipodoc] PRIMARY KEY CLUSTERED 
(
	[TpodocId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[cTpoprov]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cTpoprov](
	[TpoprvId] [varchar](10) NOT NULL,
	[Nombre] [varchar](50) NULL,
 CONSTRAINT [PK_cTpoprov] PRIMARY KEY CLUSTERED 
(
	[TpoprvId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[h_Ajustes]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[h_Ajustes](
	[NoAjuste] [nvarchar](8) NULL,
	[Numorde] [nvarchar](8) NULL,
	[Fecha] [datetime] NULL,
	[Toneladas Ajuste] [real] NULL,
	[Toneladas Ajuste1] [real] NULL,
	[Toneladas Ajuste2] [real] NULL,
	[Toneladas Ajuste3] [real] NULL,
	[Descripcion] [nvarchar](max) NULL,
	[Tipo de Ajuste] [nvarchar](1) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[h_Destino]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[h_Destino](
	[Codigo] [nvarchar](8) NULL,
	[Descripcion] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[h_Embarques]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[h_Embarques](
	[Numembarque] [nvarchar](8) NULL,
	[Numorden] [nvarchar](8) NULL,
	[Referencia Transporte] [nvarchar](50) NULL,
	[Destino] [nvarchar](50) NULL,
	[Flete] [nvarchar](50) NULL,
	[SEmb] [nvarchar](50) NULL,
	[SRec] [nvarchar](50) NULL,
	[IPT] [int] NULL,
	[POLor] [nvarchar](80) NULL,
	[PColor] [nvarchar](80) NULL,
	[Pdado] [nvarchar](80) NULL,
	[PPlagas] [nvarchar](80) NULL,
	[POtros] [nvarchar](80) NULL,
	[ITR] [int] NULL,
	[TLBasura] [nvarchar](80) NULL,
	[TLGranos] [nvarchar](80) NULL,
	[TOtros] [nvarchar](80) NULL,
	[TSCompletos] [nvarchar](80) NULL,
	[TSTrans] [nvarchar](80) NULL,
	[Peso Embarcado] [float] NULL,
	[Origen] [nvarchar](50) NULL,
	[Fecha Recepcion] [datetime] NULL,
	[Peso Recibido] [float] NULL,
	[Operador] [nvarchar](50) NULL,
	[Silo] [nvarchar](50) NULL,
	[Numfacturaflete] [nvarchar](12) NULL,
	[Fecha Embarque] [datetime] NULL,
	[Observaciones] [nvarchar](max) NULL,
	[Estatus] [nvarchar](50) NULL,
	[Proteina] [real] NULL,
	[Humedad] [real] NULL,
	[PesoHectolitro] [real] NULL,
	[Impureza] [real] NULL,
	[CargaProtegida] [int] NULL,
	[LimpiezaTransporte] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[h_Facturas]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[h_Facturas](
	[NumFac] [nvarchar](8) NULL,
	[NumOr] [nvarchar](50) NULL,
	[FechaF] [datetime] NULL,
	[Documento] [nvarchar](50) NULL,
	[Referencia] [nvarchar](50) NULL,
	[TMetricas] [float] NULL,
	[Importe] [float] NULL,
	[Observacion] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[h_Flete]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[h_Flete](
	[Codigo] [nvarchar](8) NULL,
	[Descripcion] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[h_Lotes]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[h_Lotes](
	[NumLotes] [nvarchar](8) NULL,
	[Ciclo] [nvarchar](50) NULL,
	[Proveedor] [nvarchar](50) NULL,
	[Embarcador] [nvarchar](50) NULL,
	[Origen] [nvarchar](50) NULL,
	[Trigo] [nvarchar](50) NULL,
	[Humedad] [float] NULL,
	[PesoHectolitro] [float] NULL,
	[Impureza] [float] NULL,
	[Incoterm] [nvarchar](50) NULL,
	[RitmoE] [nvarchar](50) NULL,
	[Moneda] [nvarchar](50) NULL,
	[Dockage] [nvarchar](50) NULL,
	[Vomitoxina] [nvarchar](50) NULL,
	[Ergot] [nvarchar](50) NULL,
	[FallingN] [nvarchar](50) NULL,
	[Otros] [nvarchar](50) NULL,
	[Observaciones] [nvarchar](max) NULL,
	[Proteina] [real] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[h_Ordenes]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[h_Ordenes](
	[Numorden] [nvarchar](8) NULL,
	[NumContrato] [nvarchar](50) NULL,
	[NumLote] [nvarchar](50) NULL,
	[Tolerancia] [nvarchar](50) NULL,
	[Responsable] [nvarchar](50) NULL,
	[Periodo Embarque] [nvarchar](50) NULL,
	[Toneladas metricas] [float] NULL,
	[Refuturo] [nvarchar](50) NULL,
	[Base Futuro] [float] NULL,
	[Base Base] [float] NULL,
	[Observaciones] [nvarchar](max) NULL,
	[PrecioN] [float] NULL,
	[F1] [nvarchar](50) NULL,
	[F2] [nvarchar](50) NULL,
	[F3] [nvarchar](50) NULL,
	[F4] [nvarchar](50) NULL,
	[F5] [nvarchar](50) NULL,
	[F6] [nvarchar](50) NULL,
	[F7] [nvarchar](50) NULL,
	[F8] [nvarchar](50) NULL,
	[F9] [nvarchar](50) NULL,
	[F10] [nvarchar](50) NULL,
	[D1] [nvarchar](50) NULL,
	[D2] [nvarchar](50) NULL,
	[D3] [nvarchar](50) NULL,
	[D4] [nvarchar](50) NULL,
	[D5] [nvarchar](50) NULL,
	[D6] [nvarchar](50) NULL,
	[D7] [nvarchar](50) NULL,
	[D8] [nvarchar](50) NULL,
	[D9] [nvarchar](50) NULL,
	[D10] [nvarchar](50) NULL,
	[R1] [nvarchar](50) NULL,
	[R2] [nvarchar](50) NULL,
	[R3] [nvarchar](50) NULL,
	[R4] [nvarchar](50) NULL,
	[R5] [nvarchar](50) NULL,
	[R6] [nvarchar](50) NULL,
	[R7] [nvarchar](50) NULL,
	[R8] [nvarchar](50) NULL,
	[R9] [nvarchar](50) NULL,
	[R10] [nvarchar](50) NULL,
	[T1] [nvarchar](50) NULL,
	[T2] [nvarchar](50) NULL,
	[T3] [nvarchar](50) NULL,
	[T4] [nvarchar](50) NULL,
	[T5] [nvarchar](50) NULL,
	[T6] [nvarchar](50) NULL,
	[T7] [nvarchar](50) NULL,
	[T8] [nvarchar](50) NULL,
	[T9] [nvarchar](50) NULL,
	[T10] [nvarchar](50) NULL,
	[I1] [nvarchar](50) NULL,
	[I2] [nvarchar](50) NULL,
	[I3] [nvarchar](50) NULL,
	[I4] [nvarchar](50) NULL,
	[I5] [nvarchar](50) NULL,
	[I6] [nvarchar](50) NULL,
	[I7] [nvarchar](50) NULL,
	[I8] [nvarchar](50) NULL,
	[I9] [nvarchar](50) NULL,
	[I10] [nvarchar](50) NULL,
	[Observaciones1] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[h_Origenes]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[h_Origenes](
	[Codigo] [nvarchar](8) NULL,
	[Descripcion] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[h_Proveedores]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[h_Proveedores](
	[Codigo] [nvarchar](8) NULL,
	[Nombre] [nvarchar](50) NULL,
	[Direccion] [nvarchar](50) NULL,
	[Contacto] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[h_Trigos]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[h_Trigos](
	[Codigo] [nvarchar](8) NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Proteina] [float] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[h_USUARIOS]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[h_USUARIOS](
	[USUARIO] [nvarchar](50) NULL,
	[NOMBRE] [nvarchar](70) NULL,
	[PASSWORD] [nvarchar](8) NULL,
	[OPERADOR] [tinyint] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[h_Ventas]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[h_Ventas](
	[NoVenta] [nvarchar](8) NULL,
	[Numord] [nvarchar](8) NULL,
	[Fecha] [datetime] NULL,
	[Toneladas Ajuste] [real] NULL,
	[Descripcion] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sAjustes]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sAjustes](
	[AjustId] [varchar](10) NOT NULL,
	[OrdenId] [varchar](10) NOT NULL,
	[Fchajus] [date] NULL CONSTRAINT [DE_sAjustes1]  DEFAULT (getdate()),
	[Compensa] [decimal](19, 3) NOT NULL,
	[Merma1] [decimal](19, 3) NOT NULL,
	[Merma2] [decimal](19, 3) NOT NULL,
	[Merma3] [decimal](19, 3) NOT NULL,
	[Obsrv] [varchar](1000) NULL,
	[Fchcrea] [datetime] NOT NULL,
	[Usrcrea] [varchar](10) NOT NULL,
	[Fchmod] [datetime] NOT NULL CONSTRAINT [DE_sAjustes3]  DEFAULT (getdate()),
	[Usrmod] [varchar](10) NOT NULL,
	[EstadoId] [char](1) NOT NULL CONSTRAINT [DE_sAjustes2]  DEFAULT ('A'),
 CONSTRAINT [PK_sAjustes] PRIMARY KEY CLUSTERED 
(
	[AjustId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sAjustesh]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sAjustesh](
	[InstId] [smallint] NOT NULL,
	[Usrefect] [varchar](10) NOT NULL,
	[AjustId] [varchar](10) NOT NULL,
	[OrdenId] [varchar](10) NOT NULL,
	[Fchajus] [date] NULL CONSTRAINT [DE_sAjustesh1]  DEFAULT (getdate()),
	[Compensa] [decimal](19, 3) NOT NULL,
	[Merma1] [decimal](19, 3) NOT NULL,
	[Merma2] [decimal](19, 3) NOT NULL,
	[Merma3] [decimal](19, 3) NOT NULL,
	[Obsrv] [varchar](1000) NULL,
	[Fchcrea] [datetime] NOT NULL,
	[Usrcrea] [varchar](10) NOT NULL,
	[Fchmod] [datetime] NOT NULL,
	[Usrmod] [varchar](10) NOT NULL,
	[EstadoId] [char](1) NOT NULL CONSTRAINT [DE_sAjustesh2]  DEFAULT ('A'),
 CONSTRAINT [PK_sAjustesh] PRIMARY KEY CLUSTERED 
(
	[AjustId] ASC,
	[InstId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sConfig]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sConfig](
	[ConfId] [varchar](10) NOT NULL,
	[Carpanx] [text] NULL,
	[Carpimg] [text] NULL,
	[CarpImp] [text] NULL,
	[Tnlmax] [decimal](19, 3) NULL,
	[Tnlmin] [decimal](19, 3) NULL,
	[Difmin] [decimal](19, 3) NULL,
	[Difmax] [decimal](19, 3) NULL,
	[Usrmod] [varchar](10) NULL,
	[Fchmod] [datetime] NULL,
	[Nombre] [varchar](500) NULL,
	[Calle] [varchar](250) NULL,
	[Noext] [varchar](40) NULL,
	[Noint] [varchar](40) NULL,
	[Colonia] [varchar](100) NULL,
	[Rferenc] [varchar](80) NULL,
	[Lcalidad] [varchar](80) NULL,
	[Mnicipio] [varchar](100) NULL,
	[Estado] [varchar](100) NULL,
	[Pais] [varchar](100) NULL,
	[Cdgstl] [varchar](30) NULL,
 CONSTRAINT [PK_sconfig] PRIMARY KEY CLUSTERED 
(
	[ConfId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sDestino]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sDestino](
	[DstinoId] [varchar](10) NOT NULL,
	[Nombre] [varchar](500) NOT NULL,
	[Activo] [bit] NOT NULL,
	[Fchcrea] [datetime] NULL,
	[Usrcrea] [varchar](10) NOT NULL,
	[Fchmod] [datetime] NULL,
	[Usrmod] [varchar](10) NOT NULL,
	[Dstnidan] [varchar](10) NULL,
 CONSTRAINT [PK_sDestino] PRIMARY KEY CLUSTERED 
(
	[DstinoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sEmb1]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sEmb1](
	[EmbId] [varchar](10) NOT NULL,
	[OrdenId] [varchar](10) NOT NULL,
	[Reftrans] [varchar](60) NULL,
	[DstinoId] [varchar](10) NOT NULL,
	[Provflet] [varchar](10) NOT NULL,
	[Pesoemb] [decimal](19, 3) NULL,
	[Fchemb] [date] NOT NULL,
	[Noselloe] [varchar](60) NULL,
	[Fchrec] [date] NULL,
	[Pesore] [decimal](19, 3) NULL,
	[Dif] [decimal](19, 3) NULL,
	[OprdorId] [varchar](10) NULL,
	[Silo] [varchar](25) NULL,
	[Sellorec] [varchar](60) NULL,
	[Factfl] [varchar](20) NULL,
	[Obgen] [varchar](1000) NULL,
	[Usrcrea] [varchar](10) NOT NULL,
	[Usrmod] [varchar](10) NOT NULL,
	[Fchcrea] [datetime] NULL CONSTRAINT [DE_sEmb12]  DEFAULT (getdate()),
	[Fchmod] [datetime] NULL CONSTRAINT [DE_sEmb11]  DEFAULT (getdate()),
	[EstadoId] [char](1) NULL CONSTRAINT [DE_sEmb13]  DEFAULT ('A'),
	[MonedaId] [varchar](10) NULL,
	[Tarifa] [decimal](16, 4) NOT NULL,
	[Refcrgmas] [varchar](40) NULL,
 CONSTRAINT [PK_sEmb1] PRIMARY KEY CLUSTERED 
(
	[EmbId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sEmb1h]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sEmb1h](
	[InstId] [smallint] NOT NULL,
	[Usrefect] [varchar](10) NOT NULL,
	[EmbId] [varchar](10) NOT NULL,
	[OrdenId] [varchar](10) NOT NULL,
	[Reftrans] [varchar](60) NULL,
	[DstinoId] [varchar](10) NOT NULL,
	[Provflet] [varchar](10) NOT NULL,
	[Pesoemb] [decimal](19, 3) NULL,
	[Fchemb] [date] NOT NULL,
	[Noselloe] [varchar](60) NULL,
	[Fchrec] [date] NULL,
	[Pesore] [decimal](19, 3) NULL,
	[Dif] [decimal](19, 3) NULL,
	[OprdorId] [varchar](10) NULL,
	[Silo] [varchar](25) NULL,
	[Sellorec] [varchar](60) NULL,
	[Factfl] [varchar](20) NULL,
	[Obgen] [varchar](1000) NULL,
	[Usrcrea] [varchar](10) NOT NULL,
	[Usrmod] [varchar](10) NOT NULL,
	[Fchcrea] [datetime] NULL,
	[Fchmod] [datetime] NULL DEFAULT (getdate()),
	[EstadoId] [char](1) NULL DEFAULT ('A'),
	[Tarifa] [decimal](16, 4) NOT NULL,
	[MonedaId] [varchar](10) NULL,
	[Refcrgmas] [varchar](40) NULL,
 CONSTRAINT [PK_sEmb1h] PRIMARY KEY CLUSTERED 
(
	[EmbId] ASC,
	[InstId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sEmb2]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sEmb2](
	[Condlimp] [bit] NULL,
	[Olor] [varchar](100) NULL,
	[Color] [varchar](100) NULL,
	[Danado] [varchar](100) NULL,
	[Plagas] [varchar](100) NULL,
	[Otros] [varchar](100) NULL,
	[EmbId] [varchar](10) NOT NULL,
	[Usrmod] [varchar](10) NOT NULL,
	[Fchmod] [datetime] NULL CONSTRAINT [DE_sEmb21]  DEFAULT (getdate()),
 CONSTRAINT [PK_sEmb2] PRIMARY KEY CLUSTERED 
(
	[EmbId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sEmb2h]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sEmb2h](
	[InstId] [smallint] NOT NULL,
	[Usrefect] [varchar](10) NOT NULL,
	[Condlimp] [bit] NULL,
	[Olor] [varchar](100) NULL,
	[Color] [varchar](100) NULL,
	[Danado] [varchar](100) NULL,
	[Plagas] [varchar](100) NULL,
	[Otros] [varchar](100) NULL,
	[EmbId] [varchar](10) NOT NULL,
	[Usrmod] [varchar](10) NOT NULL,
	[Fchmod] [datetime] NULL DEFAULT (getdate()),
 CONSTRAINT [PK_sEmb2h] PRIMARY KEY CLUSTERED 
(
	[EmbId] ASC,
	[InstId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sEmb3]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sEmb3](
	[Condtra] [bit] NULL,
	[Libreba] [varchar](100) NULL,
	[Libregr] [varchar](100) NULL,
	[Otros] [varchar](100) NULL,
	[Sellosc] [varchar](100) NULL,
	[Servtra] [varchar](100) NULL,
	[EmbId] [varchar](10) NOT NULL,
	[Usrmod] [varchar](10) NOT NULL,
	[Fchmod] [datetime] NULL CONSTRAINT [DE_sEmb31]  DEFAULT (getdate()),
 CONSTRAINT [PK_sEmb3] PRIMARY KEY CLUSTERED 
(
	[EmbId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sEmb3h]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sEmb3h](
	[InstId] [smallint] NOT NULL,
	[Usrefect] [varchar](10) NOT NULL,
	[Condtra] [bit] NULL,
	[Libreba] [varchar](100) NULL,
	[Libregr] [varchar](100) NULL,
	[Otros] [varchar](100) NULL,
	[Sellosc] [varchar](100) NULL,
	[Servtra] [varchar](100) NULL,
	[EmbId] [varchar](10) NOT NULL,
	[Usrmod] [varchar](10) NOT NULL,
	[Fchmod] [datetime] NULL DEFAULT (getdate()),
 CONSTRAINT [PK_sEmb3h] PRIMARY KEY CLUSTERED 
(
	[EmbId] ASC,
	[InstId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sEmb4]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sEmb4](
	[Eprot] [decimal](19, 3) NULL,
	[Ehum] [decimal](19, 3) NULL,
	[Ephl] [decimal](19, 3) NULL,
	[Eimp] [decimal](19, 3) NULL,
	[Rprot] [decimal](19, 3) NULL,
	[Rhum] [decimal](19, 3) NULL,
	[Rphl] [decimal](19, 3) NULL,
	[Rimp] [decimal](19, 3) NULL,
	[Oblab] [varchar](1000) NULL,
	[EmbId] [varchar](10) NOT NULL,
	[Usrmod] [varchar](10) NOT NULL,
	[Fchmod] [datetime] NULL CONSTRAINT [DE_sEmb41]  DEFAULT (getdate()),
	[Lab] [bit] NULL,
 CONSTRAINT [PK_sEmb4] PRIMARY KEY CLUSTERED 
(
	[EmbId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sEmb4h]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sEmb4h](
	[InstId] [smallint] NOT NULL,
	[Usrefect] [varchar](10) NOT NULL,
	[Eprot] [decimal](19, 3) NULL,
	[Ehum] [decimal](19, 3) NULL,
	[Ephl] [decimal](19, 3) NULL,
	[Eimp] [decimal](19, 3) NULL,
	[Rprot] [decimal](19, 3) NULL,
	[Rhum] [decimal](19, 3) NULL,
	[Rphl] [decimal](19, 3) NULL,
	[Rimp] [decimal](19, 3) NULL,
	[Oblab] [varchar](1000) NULL,
	[EmbId] [varchar](10) NOT NULL,
	[Usrmod] [varchar](10) NOT NULL,
	[Fchmod] [datetime] NULL DEFAULT (getdate()),
	[Lab] [bit] NULL,
 CONSTRAINT [PK_sEmb4h] PRIMARY KEY CLUSTERED 
(
	[EmbId] ASC,
	[InstId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sHost]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sHost](
	[HostId] [smallint] NOT NULL,
	[Nombre] [varchar](40) NULL,
	[Observaciones] [varchar](1000) NULL,
	[Usrcrea] [varchar](10) NULL,
	[Usrmod] [varchar](10) NULL,
	[Fchcrea] [datetime] NULL,
	[Fchmod] [datetime] NULL,
 CONSTRAINT [PK_sHost] PRIMARY KEY CLUSTERED 
(
	[HostId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sLogeo]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sLogeo](
	[LogId] [bigint] NOT NULL,
	[UsrId] [varchar](10) NULL,
	[Fchconex] [datetime] NULL,
	[HostId] [smallint] NOT NULL,
	[conexion] [bit] NOT NULL,
 CONSTRAINT [PK_sLogeo] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sLotes]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sLotes](
	[LoteId] [varchar](10) NOT NULL,
	[ProvId] [varchar](10) NOT NULL,
	[TrigoId] [varchar](10) NOT NULL,
	[Proteina] [decimal](19, 1) NOT NULL,
	[Grado] [int] NOT NULL,
	[Humedad] [decimal](19, 1) NOT NULL,
	[Pesohtl] [decimal](19, 1) NOT NULL,
	[Impureza] [decimal](19, 1) NOT NULL,
	[Dockage] [varchar](30) NULL,
	[Vomitoxn] [varchar](20) NOT NULL,
	[Ergot] [varchar](30) NOT NULL,
	[Fllngnum] [varchar](50) NULL,
	[Obsrv] [varchar](1000) NULL,
	[Fchcrea] [datetime] NOT NULL,
	[Usrcrea] [varchar](10) NOT NULL,
	[Fchmod] [datetime] NOT NULL,
	[Usrmod] [varchar](10) NOT NULL,
	[EstadoId] [char](1) NOT NULL CONSTRAINT [DE_sLotes2]  DEFAULT ('A'),
	[Fchlote] [date] NULL CONSTRAINT [DE_sLotes1]  DEFAULT (getdate()),
	[Otros] [varchar](50) NULL,
 CONSTRAINT [PK_sLotes] PRIMARY KEY CLUSTERED 
(
	[LoteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sLotesh]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sLotesh](
	[InstId] [smallint] NOT NULL,
	[Usrefect] [varchar](10) NOT NULL,
	[LoteId] [varchar](10) NOT NULL,
	[ProvId] [varchar](10) NOT NULL,
	[TrigoId] [varchar](10) NOT NULL,
	[Proteina] [decimal](19, 1) NOT NULL,
	[Grado] [int] NOT NULL,
	[Humedad] [decimal](19, 1) NOT NULL,
	[Pesohtl] [decimal](19, 1) NOT NULL,
	[Impureza] [decimal](19, 1) NOT NULL,
	[Dockage] [varchar](30) NULL,
	[Vomitoxn] [varchar](20) NOT NULL,
	[Ergot] [varchar](30) NOT NULL,
	[Fllngnum] [varchar](50) NULL,
	[Obsrv] [varchar](1000) NULL,
	[Fchcrea] [datetime] NOT NULL,
	[Usrcrea] [varchar](10) NOT NULL,
	[Fchmod] [datetime] NOT NULL,
	[Usrmod] [varchar](10) NOT NULL,
	[EstadoId] [char](1) NOT NULL,
	[Fchlote] [date] NULL,
	[Otros] [varchar](50) NULL,
 CONSTRAINT [PK_sLotesh] PRIMARY KEY CLUSTERED 
(
	[LoteId] ASC,
	[InstId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sOprador]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sOprador](
	[OprdorId] [varchar](10) NOT NULL,
	[Nkname] [varchar](40) NULL,
	[Nombre] [varchar](50) NULL,
	[Activo] [bit] NOT NULL,
	[Fchcrea] [datetime] NULL,
	[Usrcrea] [varchar](10) NULL,
	[Fchmod] [datetime] NULL,
	[Usrmod] [varchar](10) NULL,
	[Usridan] [varchar](10) NULL,
 CONSTRAINT [PK_sOprdor] PRIMARY KEY CLUSTERED 
(
	[OprdorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sOrdenes]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sOrdenes](
	[OrdenId] [varchar](10) NOT NULL,
	[CtrtoId] [varchar](30) NULL,
	[LoteId] [varchar](10) NOT NULL,
	[OrigenId] [varchar](10) NOT NULL,
	[Tnladas] [decimal](19, 3) NULL CONSTRAINT [DE_SOrdenes4]  DEFAULT ((0)),
	[Tlrancia] [varchar](30) NULL,
	[Peremb] [varchar](30) NULL,
	[Incoterm] [varchar](50) NULL,
	[Ritmo] [varchar](50) NULL,
	[Moneda] [varchar](10) NULL,
	[Refftro] [varchar](30) NULL,
	[Base] [decimal](19, 4) NULL,
	[Mesfutu] [decimal](19, 4) NULL,
	[Prcionto] [decimal](19, 4) NULL CONSTRAINT [DE_SOrdenes3]  DEFAULT ((0)),
	[Obsrv] [varchar](2000) NULL,
	[Laycan] [varchar](30) NULL,
	[Ptocarga] [varchar](50) NULL,
	[Ptodscg] [varchar](50) NULL,
	[Norcg] [varchar](20) NULL,
	[Nordscg] [varchar](20) NULL,
	[Laytime] [varchar](30) NULL,
	[Condpgo] [varchar](200) NULL,
	[Tasadmra] [varchar](20) NULL,
	[Usrmod] [varchar](10) NOT NULL,
	[Usrcrea] [varchar](10) NOT NULL,
	[Fchcrea] [datetime] NOT NULL CONSTRAINT [DE_SOrdenes1]  DEFAULT (getdate()),
	[Fchmod] [datetime] NOT NULL CONSTRAINT [DE_SOrdenes2]  DEFAULT (getdate()),
	[EstadoId] [char](1) NOT NULL DEFAULT ('A'),
	[ProvId] [varchar](10) NULL,
	[Fchord] [date] NOT NULL,
	[Rspnsble] [varchar](50) NULL,
	[Ritmod] [varchar](50) NULL,
 CONSTRAINT [PK_sOrdenes] PRIMARY KEY CLUSTERED 
(
	[OrdenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sOrdenes2]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sOrdenes2](
	[OrdenId] [varchar](10) NOT NULL,
	[Ruta] [text] NULL,
	[Coments] [text] NULL,
	[extnsion] [varchar](10) NULL,
	[instId] [smallint] NOT NULL,
 CONSTRAINT [PK_sOrdenes2] PRIMARY KEY CLUSTERED 
(
	[OrdenId] ASC,
	[instId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sOrdenesh]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sOrdenesh](
	[InstId] [smallint] NOT NULL,
	[Usrefect] [varchar](10) NOT NULL,
	[Ordenid] [varchar](10) NOT NULL,
	[Ctrtoid] [varchar](30) NOT NULL,
	[Loteid] [varchar](10) NOT NULL,
	[Origenid] [varchar](10) NOT NULL,
	[Tnladas] [decimal](19, 3) NOT NULL DEFAULT ((0)),
	[Tlrancia] [varchar](30) NULL,
	[Peremb] [varchar](30) NULL,
	[Incoterm] [varchar](50) NULL,
	[Ritmo] [varchar](50) NULL,
	[Moneda] [varchar](10) NULL,
	[Refftro] [varchar](30) NULL,
	[Base] [decimal](19, 4) NULL,
	[Mesfutu] [decimal](19, 4) NULL,
	[Prcionto] [decimal](19, 4) NULL,
	[Obsrv] [varchar](2000) NULL,
	[Laycan] [varchar](30) NULL,
	[Ptocarga] [varchar](50) NULL,
	[Ptodscg] [varchar](50) NULL,
	[Norcg] [varchar](20) NULL,
	[Nordscg] [varchar](20) NULL,
	[Laytime] [varchar](30) NULL,
	[Condpgo] [varchar](200) NULL,
	[Tasadmra] [varchar](20) NULL,
	[Usrmod] [varchar](10) NOT NULL,
	[Usrcrea] [varchar](10) NOT NULL,
	[Fchcrea] [datetime] NULL DEFAULT (getdate()),
	[Fchmod] [datetime] NULL DEFAULT (getdate()),
	[Estadoid] [char](1) NULL DEFAULT ('A'),
	[Provid] [varchar](10) NULL,
	[Fchord] [date] NULL DEFAULT (getdate()),
	[Rspnsble] [varchar](50) NULL,
	[Ritmod] [varchar](50) NULL,
 CONSTRAINT [PK_sOrdenesh] PRIMARY KEY CLUSTERED 
(
	[Ordenid] ASC,
	[InstId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sOrigen]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sOrigen](
	[OrigenId] [varchar](10) NOT NULL,
	[Nombre] [varchar](500) NOT NULL,
	[Activo] [bit] NOT NULL,
	[Fchcrea] [datetime] NULL,
	[Usrcrea] [varchar](10) NOT NULL,
	[Fchmod] [datetime] NULL,
	[Usrmod] [varchar](10) NOT NULL,
	[Orgnidan] [varchar](10) NULL,
 CONSTRAINT [PK_sOrigen] PRIMARY KEY CLUSTERED 
(
	[OrigenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sPrfls1]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sPrfls1](
	[PerfilId] [varchar](10) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Activo] [bit] NOT NULL,
	[Fchcrea] [datetime] NULL,
	[Usrcrea] [varchar](10) NULL,
	[Fchmod] [datetime] NULL,
	[Usrmod] [varchar](10) NULL,
 CONSTRAINT [PK_sPrfls1] PRIMARY KEY CLUSTERED 
(
	[PerfilId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sPrfls2]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sPrfls2](
	[PerfilId] [varchar](10) NOT NULL,
	[OpcionId] [smallint] NOT NULL,
	[Activo] [bit] NOT NULL,
	[Consulta] [bit] NOT NULL,
	[Mdfccion] [bit] NOT NULL,
	[Creacion] [bit] NOT NULL,
	[Cnlacion] [bit] NOT NULL,
	[Cierre] [bit] NOT NULL,
 CONSTRAINT [PK_sPrfls2] PRIMARY KEY CLUSTERED 
(
	[PerfilId] ASC,
	[OpcionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sProveed]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sProveed](
	[ProvId] [varchar](10) NOT NULL,
	[Nombre] [varchar](500) NULL,
	[Calle] [varchar](250) NULL,
	[Noext] [varchar](40) NULL,
	[Noint] [varchar](40) NULL,
	[Colonia] [varchar](100) NULL,
	[Rferenc] [varchar](100) NULL,
	[Lcalidad] [varchar](80) NULL,
	[Mnicipio] [varchar](100) NULL,
	[Estado] [varchar](100) NULL,
	[Pais] [varchar](100) NULL,
	[Cdgpstl] [varchar](30) NULL,
	[Cntcto] [varchar](500) NULL,
	[TpoprvId] [varchar](10) NOT NULL,
	[Providan] [varchar](20) NULL,
	[Activo] [bit] NOT NULL,
	[Fchcrea] [datetime] NULL,
	[Usrcrea] [varchar](10) NOT NULL,
	[Fchmod] [datetime] NULL,
	[Usrmod] [varchar](10) NOT NULL,
	[CardCode] [nvarchar](30) NULL,
 CONSTRAINT [PK_sProveed] PRIMARY KEY CLUSTERED 
(
	[ProvId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sRprte1]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sRprte1](
	[RprteId] [smallint] NOT NULL,
	[Titulo] [varchar](100) NULL,
	[Activo] [bit] NULL,
	[Fchint] [datetime] NULL,
	[Fchmod] [datetime] NULL,
	[Nmbrpt] [varchar](50) NULL,
	[OpcionId] [smallint] NOT NULL,
 CONSTRAINT [PK_sRprte1] PRIMARY KEY CLUSTERED 
(
	[RprteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sRprte2]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sRprte2](
	[RprteId] [smallint] NOT NULL,
	[ParamId] [smallint] NOT NULL,
	[Nmbparam] [varchar](50) NOT NULL,
	[Dscrpcion] [varchar](100) NULL,
	[TpodatId] [tinyint] NOT NULL,
	[TpodocId] [smallint] NOT NULL,
	[Activo] [bit] NULL,
	[Leyenda] [varchar](500) NULL,
	[Valordef] [varchar](50) NULL,
	[Rqrido] [bit] NOT NULL,
 CONSTRAINT [PK_sRprte2] PRIMARY KEY CLUSTERED 
(
	[RprteId] ASC,
	[ParamId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sSilos]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sSilos](
	[DstinoId] [varchar](10) NOT NULL,
	[SiloId] [varchar](10) NOT NULL,
	[Activo] [bit] NULL CONSTRAINT [DEF_sSilos1]  DEFAULT ((1)),
	[Fchcrea] [datetime] NULL CONSTRAINT [DEF_sSilos2]  DEFAULT (getdate()),
 CONSTRAINT [PK_sSilos] PRIMARY KEY CLUSTERED 
(
	[DstinoId] ASC,
	[SiloId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sSmtp]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sSmtp](
	[SmtpId] [varchar](10) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Smtsrv] [varchar](50) NOT NULL,
	[Smtpprto] [varchar](10) NOT NULL,
	[Ssltls] [bit] NOT NULL,
	[Vldcert] [bit] NOT NULL,
	[Fchcrea] [datetime] NULL,
	[Usrcrea] [varchar](10) NULL,
	[Fchmod] [datetime] NULL,
	[Usrmod] [varchar](10) NULL,
 CONSTRAINT [PK_sSmtp] PRIMARY KEY CLUSTERED 
(
	[SmtpId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sTrigos]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sTrigos](
	[TrigoId] [varchar](10) NOT NULL,
	[Nombre] [varchar](100) NULL,
	[Activo] [bit] NOT NULL,
	[Fchcrea] [datetime] NULL,
	[Usrcrea] [varchar](10) NOT NULL,
	[Fchmod] [datetime] NULL,
	[Usrmod] [varchar](10) NOT NULL,
	[ItemCode] [nvarchar](30) NULL,
	[Trgoidan] [varchar](10) NULL,
 CONSTRAINT [PK_sTrigos] PRIMARY KEY CLUSTERED 
(
	[TrigoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sUsuarios]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sUsuarios](
	[UsrId] [varchar](10) NOT NULL,
	[Nkname] [varchar](40) NULL,
	[Nombre] [varchar](50) NULL,
	[Apllidop] [varchar](50) NULL,
	[Apllidom] [varchar](50) NULL,
	[Cntrsnia] [varchar](30) NOT NULL,
	[PerfilId] [varchar](10) NULL,
	[PuestoId] [varchar](10) NOT NULL,
	[Ltimoacc] [datetime] NULL,
	[Correoe] [varchar](60) NULL,
	[Cntrscoe] [varchar](50) NULL,
	[SmtpId] [varchar](10) NULL,
	[Activo] [bit] NOT NULL,
	[Fchcrea] [datetime] NULL,
	[Usrcrea] [varchar](10) NULL,
	[Fchmod] [datetime] NULL,
	[Usrmod] [varchar](10) NULL,
	[Usridan] [varchar](10) NULL,
	[OprdorId] [varchar](10) NULL,
 CONSTRAINT [PK_sUsuarios] PRIMARY KEY CLUSTERED 
(
	[UsrId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sVentas]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sVentas](
	[VentaId] [varchar](10) NOT NULL,
	[Tonventa] [decimal](19, 3) NOT NULL,
	[OrdenId] [varchar](10) NOT NULL,
	[Fchventa] [date] NULL,
	[EstadoId] [char](1) NULL DEFAULT ('A'),
	[Obsrv] [varchar](2000) NULL,
	[Fchcrea] [datetime] NULL DEFAULT (getdate()),
	[Fchmod] [datetime] NULL DEFAULT (getdate()),
	[Usrcrea] [varchar](10) NOT NULL,
	[Usrmod] [varchar](10) NOT NULL,
 CONSTRAINT [PK_sVentas] PRIMARY KEY CLUSTERED 
(
	[VentaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[sVentash]    Script Date: 05/10/2017 12:26:11 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[sVentash](
	[InstId] [smallint] NOT NULL,
	[Usrefect] [varchar](10) NOT NULL,
	[VentaId] [varchar](10) NOT NULL,
	[Tonventa] [decimal](19, 3) NOT NULL,
	[OrdenId] [varchar](10) NOT NULL,
	[Fchventa] [date] NULL,
	[EstadoId] [char](1) NULL,
	[Obsrv] [varchar](1000) NULL,
	[Fchcrea] [datetime] NULL,
	[Fchmod] [datetime] NULL,
	[Usrcrea] [varchar](10) NOT NULL,
	[Usrmod] [varchar](10) NOT NULL,
 CONSTRAINT [PK_sVentash] PRIMARY KEY CLUSTERED 
(
	[VentaId] ASC,
	[InstId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Index [IX_sAjustes1]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sAjustes1] ON [dbo].[sAjustes]
(
	[Fchajus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sAjustes2]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sAjustes2] ON [dbo].[sAjustes]
(
	[OrdenId] ASC,
	[AjustId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sAjustes3]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sAjustes3] ON [dbo].[sAjustes]
(
	[Fchajus] ASC,
	[EstadoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sEmb1]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sEmb1] ON [dbo].[sEmb1]
(
	[Provflet] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sEmb11]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sEmb11] ON [dbo].[sEmb1]
(
	[OrdenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sEmb110]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sEmb110] ON [dbo].[sEmb1]
(
	[Fchrec] ASC,
	[Silo] ASC,
	[EstadoId] ASC
)
INCLUDE ( 	[OrdenId],
	[Reftrans],
	[Pesoemb],
	[Pesore],
	[OprdorId]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sEmb111]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sEmb111] ON [dbo].[sEmb1]
(
	[Provflet] ASC,
	[OrdenId] ASC,
	[Fchemb] ASC,
	[EstadoId] ASC
)
INCLUDE ( 	[EmbId],
	[Reftrans],
	[Fchrec]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sEmb12]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sEmb12] ON [dbo].[sEmb1]
(
	[OrdenId] ASC,
	[EmbId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_sEmb13]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sEmb13] ON [dbo].[sEmb1]
(
	[Fchemb] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_sEmb14]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sEmb14] ON [dbo].[sEmb1]
(
	[Fchrec] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sEmb15]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sEmb15] ON [dbo].[sEmb1]
(
	[OrdenId] ASC,
	[Fchemb] ASC,
	[EstadoId] ASC
)
INCLUDE ( 	[EmbId],
	[Reftrans],
	[Fchrec],
	[DstinoId],
	[Provflet],
	[Pesore],
	[Factfl],
	[Pesoemb]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sEmb16]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sEmb16] ON [dbo].[sEmb1]
(
	[Factfl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sEmb17]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sEmb17] ON [dbo].[sEmb1]
(
	[OrdenId] ASC,
	[DstinoId] ASC,
	[Fchemb] ASC,
	[EstadoId] ASC
)
INCLUDE ( 	[EmbId],
	[Reftrans],
	[Pesoemb],
	[Fchrec],
	[Pesore]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sEmb18]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sEmb18] ON [dbo].[sEmb1]
(
	[DstinoId] ASC,
	[Silo] ASC,
	[EstadoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sEmb19]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sEmb19] ON [dbo].[sEmb1]
(
	[OrdenId] ASC,
	[EmbId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_sEmb41]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sEmb41] ON [dbo].[sEmb4]
(
	[Lab] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_sLotes1]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sLotes1] ON [dbo].[sLotes]
(
	[Fchlote] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sLotes2]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sLotes2] ON [dbo].[sLotes]
(
	[ProvId] ASC,
	[LoteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sLotes3]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sLotes3] ON [dbo].[sLotes]
(
	[Fchlote] ASC,
	[EstadoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sLotes4]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sLotes4] ON [dbo].[sLotes]
(
	[TrigoId] ASC,
	[LoteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sLotes5]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sLotes5] ON [dbo].[sLotes]
(
	[LoteId] ASC,
	[EstadoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sLotes6]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sLotes6] ON [dbo].[sLotes]
(
	[LoteId] ASC,
	[EstadoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Ordenes2]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_Ordenes2] ON [dbo].[sOrdenes]
(
	[Fchcrea] ASC,
	[EstadoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Ordenes3]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_Ordenes3] ON [dbo].[sOrdenes]
(
	[CtrtoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_Ordenes4]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_Ordenes4] ON [dbo].[sOrdenes]
(
	[OrigenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sOrdenes1]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sOrdenes1] ON [dbo].[sOrdenes]
(
	[LoteId] ASC,
	[OrdenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sOrdenes5]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sOrdenes5] ON [dbo].[sOrdenes]
(
	[Fchcrea] ASC,
	[OrdenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sProveed]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sProveed] ON [dbo].[sProveed]
(
	[ProvId] ASC,
	[TpoprvId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sVentas1]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sVentas1] ON [dbo].[sVentas]
(
	[OrdenId] ASC,
	[VentaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_sVentas2]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sVentas2] ON [dbo].[sVentas]
(
	[Fchventa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sVentas3]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sVentas3] ON [dbo].[sVentas]
(
	[Fchventa] ASC,
	[EstadoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_sVentas4]    Script Date: 05/10/2017 12:26:11 p. m. ******/
CREATE NONCLUSTERED INDEX [IX_sVentas4] ON [dbo].[sVentas]
(
	[Fchventa] ASC,
	[VentaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[sLotesh] ADD  CONSTRAINT [DE_sLotesh2]  DEFAULT ('A') FOR [EstadoId]
GO
ALTER TABLE [dbo].[sLotesh] ADD  CONSTRAINT [DE_sLotesh1]  DEFAULT (getdate()) FOR [Fchlote]
GO
ALTER TABLE [dbo].[cOpcsist]  WITH CHECK ADD  CONSTRAINT [FK_cOpcsist_cOpcsist] FOREIGN KEY([Opcnidp])
REFERENCES [dbo].[cOpcsist] ([OpcionId])
GO
ALTER TABLE [dbo].[cOpcsist] CHECK CONSTRAINT [FK_cOpcsist_cOpcsist]
GO
ALTER TABLE [dbo].[sAjustes]  WITH CHECK ADD  CONSTRAINT [FK_sAjustes_cEstados] FOREIGN KEY([EstadoId])
REFERENCES [dbo].[cEstados] ([EstadoId])
GO
ALTER TABLE [dbo].[sAjustes] CHECK CONSTRAINT [FK_sAjustes_cEstados]
GO
ALTER TABLE [dbo].[sAjustes]  WITH CHECK ADD  CONSTRAINT [FK_sAjustes_sOrdenes] FOREIGN KEY([OrdenId])
REFERENCES [dbo].[sOrdenes] ([OrdenId])
GO
ALTER TABLE [dbo].[sAjustes] CHECK CONSTRAINT [FK_sAjustes_sOrdenes]
GO
ALTER TABLE [dbo].[sAjustes]  WITH CHECK ADD  CONSTRAINT [FK_sAjustes_sUsuarios1] FOREIGN KEY([Usrcrea])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sAjustes] CHECK CONSTRAINT [FK_sAjustes_sUsuarios1]
GO
ALTER TABLE [dbo].[sAjustes]  WITH CHECK ADD  CONSTRAINT [FK_sAjustes_sUsuarios2] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sAjustes] CHECK CONSTRAINT [FK_sAjustes_sUsuarios2]
GO
ALTER TABLE [dbo].[sAjustesh]  WITH CHECK ADD  CONSTRAINT [FK_sAjustesh_cEstados] FOREIGN KEY([EstadoId])
REFERENCES [dbo].[cEstados] ([EstadoId])
GO
ALTER TABLE [dbo].[sAjustesh] CHECK CONSTRAINT [FK_sAjustesh_cEstados]
GO
ALTER TABLE [dbo].[sAjustesh]  WITH CHECK ADD  CONSTRAINT [FK_sAjustesh_sAjustes] FOREIGN KEY([AjustId])
REFERENCES [dbo].[sAjustes] ([AjustId])
GO
ALTER TABLE [dbo].[sAjustesh] CHECK CONSTRAINT [FK_sAjustesh_sAjustes]
GO
ALTER TABLE [dbo].[sAjustesh]  WITH CHECK ADD  CONSTRAINT [FK_sAjustesh_sUsuarios1] FOREIGN KEY([Usrefect])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sAjustesh] CHECK CONSTRAINT [FK_sAjustesh_sUsuarios1]
GO
ALTER TABLE [dbo].[sAjustesh]  WITH CHECK ADD  CONSTRAINT [FK_sAjustesh_sUsuarios2] FOREIGN KEY([Usrcrea])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sAjustesh] CHECK CONSTRAINT [FK_sAjustesh_sUsuarios2]
GO
ALTER TABLE [dbo].[sAjustesh]  WITH CHECK ADD  CONSTRAINT [FK_sAjustesh_sUsuarios3] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sAjustesh] CHECK CONSTRAINT [FK_sAjustesh_sUsuarios3]
GO
ALTER TABLE [dbo].[sDestino]  WITH CHECK ADD  CONSTRAINT [FK_sDestino_sUsuarios1] FOREIGN KEY([Usrcrea])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sDestino] CHECK CONSTRAINT [FK_sDestino_sUsuarios1]
GO
ALTER TABLE [dbo].[sDestino]  WITH CHECK ADD  CONSTRAINT [FK_sDestino_sUsuarios2] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sDestino] CHECK CONSTRAINT [FK_sDestino_sUsuarios2]
GO
ALTER TABLE [dbo].[sEmb1]  WITH CHECK ADD  CONSTRAINT [FK_sEmb1_cMoneda] FOREIGN KEY([MonedaId])
REFERENCES [dbo].[cMoneda] ([MonedaId])
GO
ALTER TABLE [dbo].[sEmb1] CHECK CONSTRAINT [FK_sEmb1_cMoneda]
GO
ALTER TABLE [dbo].[sEmb1]  WITH CHECK ADD  CONSTRAINT [FK_sEmb1_sDestino] FOREIGN KEY([DstinoId])
REFERENCES [dbo].[sDestino] ([DstinoId])
GO
ALTER TABLE [dbo].[sEmb1] CHECK CONSTRAINT [FK_sEmb1_sDestino]
GO
ALTER TABLE [dbo].[sEmb1]  WITH CHECK ADD  CONSTRAINT [FK_sEmb1_sOprador] FOREIGN KEY([OprdorId])
REFERENCES [dbo].[sOprador] ([OprdorId])
GO
ALTER TABLE [dbo].[sEmb1] CHECK CONSTRAINT [FK_sEmb1_sOprador]
GO
ALTER TABLE [dbo].[sEmb1]  WITH CHECK ADD  CONSTRAINT [FK_sEmb1_sOrdenes] FOREIGN KEY([OrdenId])
REFERENCES [dbo].[sOrdenes] ([OrdenId])
GO
ALTER TABLE [dbo].[sEmb1] CHECK CONSTRAINT [FK_sEmb1_sOrdenes]
GO
ALTER TABLE [dbo].[sEmb1]  WITH CHECK ADD  CONSTRAINT [FK_sEmb1_sProveed] FOREIGN KEY([Provflet])
REFERENCES [dbo].[sProveed] ([ProvId])
GO
ALTER TABLE [dbo].[sEmb1] CHECK CONSTRAINT [FK_sEmb1_sProveed]
GO
ALTER TABLE [dbo].[sEmb1]  WITH CHECK ADD  CONSTRAINT [FK_sEmb1_sUsuarios1] FOREIGN KEY([Usrcrea])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sEmb1] CHECK CONSTRAINT [FK_sEmb1_sUsuarios1]
GO
ALTER TABLE [dbo].[sEmb1]  WITH CHECK ADD  CONSTRAINT [FK_sEmb1_sUsuarios2] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sEmb1] CHECK CONSTRAINT [FK_sEmb1_sUsuarios2]
GO
ALTER TABLE [dbo].[sEmb1h]  WITH CHECK ADD  CONSTRAINT [FK_sEmb1h_cEstados] FOREIGN KEY([EstadoId])
REFERENCES [dbo].[cEstados] ([EstadoId])
GO
ALTER TABLE [dbo].[sEmb1h] CHECK CONSTRAINT [FK_sEmb1h_cEstados]
GO
ALTER TABLE [dbo].[sEmb1h]  WITH CHECK ADD  CONSTRAINT [FK_sEmb1h_sEmb1] FOREIGN KEY([EmbId])
REFERENCES [dbo].[sEmb1] ([EmbId])
GO
ALTER TABLE [dbo].[sEmb1h] CHECK CONSTRAINT [FK_sEmb1h_sEmb1]
GO
ALTER TABLE [dbo].[sEmb1h]  WITH CHECK ADD  CONSTRAINT [FK_SEmb1h_sOprador] FOREIGN KEY([OprdorId])
REFERENCES [dbo].[sOprador] ([OprdorId])
GO
ALTER TABLE [dbo].[sEmb1h] CHECK CONSTRAINT [FK_SEmb1h_sOprador]
GO
ALTER TABLE [dbo].[sEmb1h]  WITH CHECK ADD  CONSTRAINT [FK_sEmb1h_sUsuarios1] FOREIGN KEY([Usrefect])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sEmb1h] CHECK CONSTRAINT [FK_sEmb1h_sUsuarios1]
GO
ALTER TABLE [dbo].[sEmb1h]  WITH CHECK ADD  CONSTRAINT [FK_sEmb1h_sUsuarios2] FOREIGN KEY([Usrcrea])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sEmb1h] CHECK CONSTRAINT [FK_sEmb1h_sUsuarios2]
GO
ALTER TABLE [dbo].[sEmb1h]  WITH CHECK ADD  CONSTRAINT [FK_sEmb1h_sUsuarios3] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sEmb1h] CHECK CONSTRAINT [FK_sEmb1h_sUsuarios3]
GO
ALTER TABLE [dbo].[sEmb2]  WITH CHECK ADD  CONSTRAINT [FK_sEmb2_sEmb1] FOREIGN KEY([EmbId])
REFERENCES [dbo].[sEmb1] ([EmbId])
GO
ALTER TABLE [dbo].[sEmb2] CHECK CONSTRAINT [FK_sEmb2_sEmb1]
GO
ALTER TABLE [dbo].[sEmb2]  WITH CHECK ADD  CONSTRAINT [FK_sEmb2_sUsuarios2] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sEmb2] CHECK CONSTRAINT [FK_sEmb2_sUsuarios2]
GO
ALTER TABLE [dbo].[sEmb2h]  WITH CHECK ADD  CONSTRAINT [FK_sEmb2h_sEmb1h] FOREIGN KEY([EmbId], [InstId])
REFERENCES [dbo].[sEmb1h] ([EmbId], [InstId])
GO
ALTER TABLE [dbo].[sEmb2h] CHECK CONSTRAINT [FK_sEmb2h_sEmb1h]
GO
ALTER TABLE [dbo].[sEmb2h]  WITH CHECK ADD  CONSTRAINT [FK_sEmb2h_sUsuarios1] FOREIGN KEY([Usrefect])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sEmb2h] CHECK CONSTRAINT [FK_sEmb2h_sUsuarios1]
GO
ALTER TABLE [dbo].[sEmb2h]  WITH CHECK ADD  CONSTRAINT [FK_sEmb2h_sUsuarios2] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sEmb2h] CHECK CONSTRAINT [FK_sEmb2h_sUsuarios2]
GO
ALTER TABLE [dbo].[sEmb3]  WITH CHECK ADD  CONSTRAINT [FK_sEmb3_sEmb1] FOREIGN KEY([EmbId])
REFERENCES [dbo].[sEmb1] ([EmbId])
GO
ALTER TABLE [dbo].[sEmb3] CHECK CONSTRAINT [FK_sEmb3_sEmb1]
GO
ALTER TABLE [dbo].[sEmb3]  WITH CHECK ADD  CONSTRAINT [FK_sEmb3_sUsuarios2] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sEmb3] CHECK CONSTRAINT [FK_sEmb3_sUsuarios2]
GO
ALTER TABLE [dbo].[sEmb3h]  WITH CHECK ADD  CONSTRAINT [FK_sEmb3h_sEmb1h] FOREIGN KEY([EmbId], [InstId])
REFERENCES [dbo].[sEmb1h] ([EmbId], [InstId])
GO
ALTER TABLE [dbo].[sEmb3h] CHECK CONSTRAINT [FK_sEmb3h_sEmb1h]
GO
ALTER TABLE [dbo].[sEmb3h]  WITH CHECK ADD  CONSTRAINT [FK_sEmb3h_sUsuarios1] FOREIGN KEY([Usrefect])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sEmb3h] CHECK CONSTRAINT [FK_sEmb3h_sUsuarios1]
GO
ALTER TABLE [dbo].[sEmb3h]  WITH CHECK ADD  CONSTRAINT [FK_sEmb3h_sUsuarios2] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sEmb3h] CHECK CONSTRAINT [FK_sEmb3h_sUsuarios2]
GO
ALTER TABLE [dbo].[sEmb4]  WITH CHECK ADD  CONSTRAINT [FK_sEmb4_sEmb1] FOREIGN KEY([EmbId])
REFERENCES [dbo].[sEmb1] ([EmbId])
GO
ALTER TABLE [dbo].[sEmb4] CHECK CONSTRAINT [FK_sEmb4_sEmb1]
GO
ALTER TABLE [dbo].[sEmb4]  WITH CHECK ADD  CONSTRAINT [FK_sEmb4_sUsuarios2] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sEmb4] CHECK CONSTRAINT [FK_sEmb4_sUsuarios2]
GO
ALTER TABLE [dbo].[sEmb4h]  WITH CHECK ADD  CONSTRAINT [FK_sEmb4h_sEmb1h] FOREIGN KEY([EmbId], [InstId])
REFERENCES [dbo].[sEmb1h] ([EmbId], [InstId])
GO
ALTER TABLE [dbo].[sEmb4h] CHECK CONSTRAINT [FK_sEmb4h_sEmb1h]
GO
ALTER TABLE [dbo].[sEmb4h]  WITH CHECK ADD  CONSTRAINT [FK_sEmb4h_sUsuarios1] FOREIGN KEY([Usrefect])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sEmb4h] CHECK CONSTRAINT [FK_sEmb4h_sUsuarios1]
GO
ALTER TABLE [dbo].[sEmb4h]  WITH CHECK ADD  CONSTRAINT [FK_sEmb4h_sUsuarios2] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sEmb4h] CHECK CONSTRAINT [FK_sEmb4h_sUsuarios2]
GO
ALTER TABLE [dbo].[sHost]  WITH CHECK ADD  CONSTRAINT [FK_sHost_sUsuarios1] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sHost] CHECK CONSTRAINT [FK_sHost_sUsuarios1]
GO
ALTER TABLE [dbo].[sHost]  WITH CHECK ADD  CONSTRAINT [FK_sHost_sUsuarios2] FOREIGN KEY([Usrcrea])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sHost] CHECK CONSTRAINT [FK_sHost_sUsuarios2]
GO
ALTER TABLE [dbo].[sLogeo]  WITH CHECK ADD  CONSTRAINT [FK_sLogeo_sHost] FOREIGN KEY([HostId])
REFERENCES [dbo].[sHost] ([HostId])
GO
ALTER TABLE [dbo].[sLogeo] CHECK CONSTRAINT [FK_sLogeo_sHost]
GO
ALTER TABLE [dbo].[sLogeo]  WITH CHECK ADD  CONSTRAINT [FK_sLogeo_sUsuarios] FOREIGN KEY([UsrId])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sLogeo] CHECK CONSTRAINT [FK_sLogeo_sUsuarios]
GO
ALTER TABLE [dbo].[sLotes]  WITH CHECK ADD  CONSTRAINT [FK_sLotes_sEstados] FOREIGN KEY([EstadoId])
REFERENCES [dbo].[cEstados] ([EstadoId])
GO
ALTER TABLE [dbo].[sLotes] CHECK CONSTRAINT [FK_sLotes_sEstados]
GO
ALTER TABLE [dbo].[sLotes]  WITH CHECK ADD  CONSTRAINT [FK_sLotes_sProveed] FOREIGN KEY([ProvId])
REFERENCES [dbo].[sProveed] ([ProvId])
GO
ALTER TABLE [dbo].[sLotes] CHECK CONSTRAINT [FK_sLotes_sProveed]
GO
ALTER TABLE [dbo].[sLotes]  WITH CHECK ADD  CONSTRAINT [FK_sLotes_sTrigos] FOREIGN KEY([TrigoId])
REFERENCES [dbo].[sTrigos] ([TrigoId])
GO
ALTER TABLE [dbo].[sLotes] CHECK CONSTRAINT [FK_sLotes_sTrigos]
GO
ALTER TABLE [dbo].[sLotes]  WITH CHECK ADD  CONSTRAINT [FK_sLotes_sUsuarios1] FOREIGN KEY([Usrcrea])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sLotes] CHECK CONSTRAINT [FK_sLotes_sUsuarios1]
GO
ALTER TABLE [dbo].[sLotes]  WITH CHECK ADD  CONSTRAINT [FK_sLotes_sUsuarios2] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sLotes] CHECK CONSTRAINT [FK_sLotes_sUsuarios2]
GO
ALTER TABLE [dbo].[sLotesh]  WITH CHECK ADD  CONSTRAINT [FK_sLotesh_cEstados] FOREIGN KEY([EstadoId])
REFERENCES [dbo].[cEstados] ([EstadoId])
GO
ALTER TABLE [dbo].[sLotesh] CHECK CONSTRAINT [FK_sLotesh_cEstados]
GO
ALTER TABLE [dbo].[sLotesh]  WITH CHECK ADD  CONSTRAINT [FK_sLotesh_sLotes] FOREIGN KEY([LoteId])
REFERENCES [dbo].[sLotes] ([LoteId])
GO
ALTER TABLE [dbo].[sLotesh] CHECK CONSTRAINT [FK_sLotesh_sLotes]
GO
ALTER TABLE [dbo].[sLotesh]  WITH CHECK ADD  CONSTRAINT [FK_sLotesh_sProveed] FOREIGN KEY([ProvId])
REFERENCES [dbo].[sProveed] ([ProvId])
GO
ALTER TABLE [dbo].[sLotesh] CHECK CONSTRAINT [FK_sLotesh_sProveed]
GO
ALTER TABLE [dbo].[sLotesh]  WITH CHECK ADD  CONSTRAINT [FK_sLotesh_sTrigos] FOREIGN KEY([TrigoId])
REFERENCES [dbo].[sTrigos] ([TrigoId])
GO
ALTER TABLE [dbo].[sLotesh] CHECK CONSTRAINT [FK_sLotesh_sTrigos]
GO
ALTER TABLE [dbo].[sLotesh]  WITH CHECK ADD  CONSTRAINT [FK_sLotesh_sUsuarios1] FOREIGN KEY([Usrefect])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sLotesh] CHECK CONSTRAINT [FK_sLotesh_sUsuarios1]
GO
ALTER TABLE [dbo].[sLotesh]  WITH CHECK ADD  CONSTRAINT [FK_sLotesh_sUsuarios2] FOREIGN KEY([Usrcrea])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sLotesh] CHECK CONSTRAINT [FK_sLotesh_sUsuarios2]
GO
ALTER TABLE [dbo].[sLotesh]  WITH CHECK ADD  CONSTRAINT [FK_sLotesh_sUsuarios3] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sLotesh] CHECK CONSTRAINT [FK_sLotesh_sUsuarios3]
GO
ALTER TABLE [dbo].[sOprador]  WITH CHECK ADD  CONSTRAINT [FK_sOprador_sUsuarios1] FOREIGN KEY([Usrcrea])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sOprador] CHECK CONSTRAINT [FK_sOprador_sUsuarios1]
GO
ALTER TABLE [dbo].[sOprador]  WITH CHECK ADD  CONSTRAINT [FK_sOprador_sUsuarios2] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sOprador] CHECK CONSTRAINT [FK_sOprador_sUsuarios2]
GO
ALTER TABLE [dbo].[sOrdenes]  WITH CHECK ADD  CONSTRAINT [FK_sOrdenes_cEstados] FOREIGN KEY([EstadoId])
REFERENCES [dbo].[cEstados] ([EstadoId])
GO
ALTER TABLE [dbo].[sOrdenes] CHECK CONSTRAINT [FK_sOrdenes_cEstados]
GO
ALTER TABLE [dbo].[sOrdenes]  WITH CHECK ADD  CONSTRAINT [FK_sOrdenes_sLotes] FOREIGN KEY([LoteId])
REFERENCES [dbo].[sLotes] ([LoteId])
GO
ALTER TABLE [dbo].[sOrdenes] CHECK CONSTRAINT [FK_sOrdenes_sLotes]
GO
ALTER TABLE [dbo].[sOrdenes]  WITH CHECK ADD  CONSTRAINT [FK_sOrdenes_sOrigen] FOREIGN KEY([OrigenId])
REFERENCES [dbo].[sOrigen] ([OrigenId])
GO
ALTER TABLE [dbo].[sOrdenes] CHECK CONSTRAINT [FK_sOrdenes_sOrigen]
GO
ALTER TABLE [dbo].[sOrdenes]  WITH CHECK ADD  CONSTRAINT [FK_sOrdenes_sProveed] FOREIGN KEY([ProvId])
REFERENCES [dbo].[sProveed] ([ProvId])
GO
ALTER TABLE [dbo].[sOrdenes] CHECK CONSTRAINT [FK_sOrdenes_sProveed]
GO
ALTER TABLE [dbo].[sOrdenes]  WITH CHECK ADD  CONSTRAINT [FK_sOrdenes_sUsuarios_crea] FOREIGN KEY([Usrcrea])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sOrdenes] CHECK CONSTRAINT [FK_sOrdenes_sUsuarios_crea]
GO
ALTER TABLE [dbo].[sOrdenes]  WITH CHECK ADD  CONSTRAINT [FK_sOrdenes_sUsuarios_mod] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sOrdenes] CHECK CONSTRAINT [FK_sOrdenes_sUsuarios_mod]
GO
ALTER TABLE [dbo].[sOrdenes2]  WITH CHECK ADD  CONSTRAINT [FK_sOrdenes2_sOrdnes] FOREIGN KEY([OrdenId])
REFERENCES [dbo].[sOrdenes] ([OrdenId])
GO
ALTER TABLE [dbo].[sOrdenes2] CHECK CONSTRAINT [FK_sOrdenes2_sOrdnes]
GO
ALTER TABLE [dbo].[sOrdenesh]  WITH CHECK ADD  CONSTRAINT [FK_sOrdenesh_cEstados] FOREIGN KEY([Estadoid])
REFERENCES [dbo].[cEstados] ([EstadoId])
GO
ALTER TABLE [dbo].[sOrdenesh] CHECK CONSTRAINT [FK_sOrdenesh_cEstados]
GO
ALTER TABLE [dbo].[sOrdenesh]  WITH CHECK ADD  CONSTRAINT [FK_sOrdenesh_sLotes] FOREIGN KEY([Loteid])
REFERENCES [dbo].[sLotes] ([LoteId])
GO
ALTER TABLE [dbo].[sOrdenesh] CHECK CONSTRAINT [FK_sOrdenesh_sLotes]
GO
ALTER TABLE [dbo].[sOrdenesh]  WITH CHECK ADD  CONSTRAINT [FK_sOrdenesh_sOrdenes] FOREIGN KEY([Ordenid])
REFERENCES [dbo].[sOrdenes] ([OrdenId])
GO
ALTER TABLE [dbo].[sOrdenesh] CHECK CONSTRAINT [FK_sOrdenesh_sOrdenes]
GO
ALTER TABLE [dbo].[sOrdenesh]  WITH CHECK ADD  CONSTRAINT [FK_sOrdenesh_sOrigen] FOREIGN KEY([Origenid])
REFERENCES [dbo].[sOrigen] ([OrigenId])
GO
ALTER TABLE [dbo].[sOrdenesh] CHECK CONSTRAINT [FK_sOrdenesh_sOrigen]
GO
ALTER TABLE [dbo].[sOrdenesh]  WITH CHECK ADD  CONSTRAINT [FK_sOrdenesh_sProveed] FOREIGN KEY([Provid])
REFERENCES [dbo].[sProveed] ([ProvId])
GO
ALTER TABLE [dbo].[sOrdenesh] CHECK CONSTRAINT [FK_sOrdenesh_sProveed]
GO
ALTER TABLE [dbo].[sOrdenesh]  WITH CHECK ADD  CONSTRAINT [FK_sOrdenesh_sUsuarios3] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sOrdenesh] CHECK CONSTRAINT [FK_sOrdenesh_sUsuarios3]
GO
ALTER TABLE [dbo].[sOrdenesh]  WITH CHECK ADD  CONSTRAINT [FK_sOrdnesh_sUsuarios1] FOREIGN KEY([Usrefect])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sOrdenesh] CHECK CONSTRAINT [FK_sOrdnesh_sUsuarios1]
GO
ALTER TABLE [dbo].[sOrdenesh]  WITH CHECK ADD  CONSTRAINT [FK_ssOrdenesh_sUsuarios2] FOREIGN KEY([Usrcrea])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sOrdenesh] CHECK CONSTRAINT [FK_ssOrdenesh_sUsuarios2]
GO
ALTER TABLE [dbo].[sOrigen]  WITH CHECK ADD  CONSTRAINT [FK_sOrigen_sUsuarios1] FOREIGN KEY([Usrcrea])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sOrigen] CHECK CONSTRAINT [FK_sOrigen_sUsuarios1]
GO
ALTER TABLE [dbo].[sOrigen]  WITH CHECK ADD  CONSTRAINT [FK_sOrigen_sUsuarios2] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sOrigen] CHECK CONSTRAINT [FK_sOrigen_sUsuarios2]
GO
ALTER TABLE [dbo].[sPrfls1]  WITH CHECK ADD  CONSTRAINT [FK_sPrfls1_sUsuarios1] FOREIGN KEY([Usrcrea])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sPrfls1] CHECK CONSTRAINT [FK_sPrfls1_sUsuarios1]
GO
ALTER TABLE [dbo].[sPrfls1]  WITH CHECK ADD  CONSTRAINT [FK_sPrfls1_sUsuarios2] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sPrfls1] CHECK CONSTRAINT [FK_sPrfls1_sUsuarios2]
GO
ALTER TABLE [dbo].[sPrfls2]  WITH CHECK ADD  CONSTRAINT [FK_sPrfls2_cOpcsist] FOREIGN KEY([OpcionId])
REFERENCES [dbo].[cOpcsist] ([OpcionId])
GO
ALTER TABLE [dbo].[sPrfls2] CHECK CONSTRAINT [FK_sPrfls2_cOpcsist]
GO
ALTER TABLE [dbo].[sPrfls2]  WITH CHECK ADD  CONSTRAINT [FK_sPrfls2_sPrfls1] FOREIGN KEY([PerfilId])
REFERENCES [dbo].[sPrfls1] ([PerfilId])
GO
ALTER TABLE [dbo].[sPrfls2] CHECK CONSTRAINT [FK_sPrfls2_sPrfls1]
GO
ALTER TABLE [dbo].[sProveed]  WITH CHECK ADD  CONSTRAINT [FK_sProveed_sTpoprov] FOREIGN KEY([TpoprvId])
REFERENCES [dbo].[cTpoprov] ([TpoprvId])
GO
ALTER TABLE [dbo].[sProveed] CHECK CONSTRAINT [FK_sProveed_sTpoprov]
GO
ALTER TABLE [dbo].[sProveed]  WITH CHECK ADD  CONSTRAINT [FK_sProveed_sUsuarios1] FOREIGN KEY([Usrcrea])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sProveed] CHECK CONSTRAINT [FK_sProveed_sUsuarios1]
GO
ALTER TABLE [dbo].[sProveed]  WITH CHECK ADD  CONSTRAINT [FK_sProveed_sUsuarios2] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sProveed] CHECK CONSTRAINT [FK_sProveed_sUsuarios2]
GO
ALTER TABLE [dbo].[sRprte1]  WITH CHECK ADD  CONSTRAINT [FK_sRprte1_cOpcsist] FOREIGN KEY([OpcionId])
REFERENCES [dbo].[cOpcsist] ([OpcionId])
GO
ALTER TABLE [dbo].[sRprte1] CHECK CONSTRAINT [FK_sRprte1_cOpcsist]
GO
ALTER TABLE [dbo].[sRprte2]  WITH CHECK ADD  CONSTRAINT [FK_sRprte2_cTipodoc] FOREIGN KEY([TpodocId])
REFERENCES [dbo].[cTipodoc] ([TpodocId])
GO
ALTER TABLE [dbo].[sRprte2] CHECK CONSTRAINT [FK_sRprte2_cTipodoc]
GO
ALTER TABLE [dbo].[sRprte2]  WITH CHECK ADD  CONSTRAINT [FK_sRprte2_cTpodat] FOREIGN KEY([TpodatId])
REFERENCES [dbo].[cTipodat] ([TpodatId])
GO
ALTER TABLE [dbo].[sRprte2] CHECK CONSTRAINT [FK_sRprte2_cTpodat]
GO
ALTER TABLE [dbo].[sRprte2]  WITH CHECK ADD  CONSTRAINT [FK_sRprte2_Srprte1] FOREIGN KEY([RprteId])
REFERENCES [dbo].[sRprte1] ([RprteId])
GO
ALTER TABLE [dbo].[sRprte2] CHECK CONSTRAINT [FK_sRprte2_Srprte1]
GO
ALTER TABLE [dbo].[sSilos]  WITH CHECK ADD  CONSTRAINT [FK_sSilos_sDestino] FOREIGN KEY([DstinoId])
REFERENCES [dbo].[sDestino] ([DstinoId])
GO
ALTER TABLE [dbo].[sSilos] CHECK CONSTRAINT [FK_sSilos_sDestino]
GO
ALTER TABLE [dbo].[sSmtp]  WITH CHECK ADD  CONSTRAINT [FK_sSmtp_sSmtp1] FOREIGN KEY([Usrcrea])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sSmtp] CHECK CONSTRAINT [FK_sSmtp_sSmtp1]
GO
ALTER TABLE [dbo].[sSmtp]  WITH CHECK ADD  CONSTRAINT [FK_sSmtp_sSmtp2] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sSmtp] CHECK CONSTRAINT [FK_sSmtp_sSmtp2]
GO
ALTER TABLE [dbo].[sTrigos]  WITH CHECK ADD  CONSTRAINT [FK_sTrigos_sUsuarios1] FOREIGN KEY([Usrcrea])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sTrigos] CHECK CONSTRAINT [FK_sTrigos_sUsuarios1]
GO
ALTER TABLE [dbo].[sTrigos]  WITH CHECK ADD  CONSTRAINT [FK_sTrigos_sUsuarios2] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sTrigos] CHECK CONSTRAINT [FK_sTrigos_sUsuarios2]
GO
ALTER TABLE [dbo].[sUsuarios]  WITH CHECK ADD  CONSTRAINT [FK_sUsuarios_cPuestos] FOREIGN KEY([PuestoId])
REFERENCES [dbo].[cPuestos] ([PuestoId])
GO
ALTER TABLE [dbo].[sUsuarios] CHECK CONSTRAINT [FK_sUsuarios_cPuestos]
GO
ALTER TABLE [dbo].[sUsuarios]  WITH CHECK ADD  CONSTRAINT [FK_sUsuarios_sPrfls1] FOREIGN KEY([PerfilId])
REFERENCES [dbo].[sPrfls1] ([PerfilId])
GO
ALTER TABLE [dbo].[sUsuarios] CHECK CONSTRAINT [FK_sUsuarios_sPrfls1]
GO
ALTER TABLE [dbo].[sUsuarios]  WITH CHECK ADD  CONSTRAINT [FK_sUsuarios_sSmtp] FOREIGN KEY([SmtpId])
REFERENCES [dbo].[sSmtp] ([SmtpId])
GO
ALTER TABLE [dbo].[sUsuarios] CHECK CONSTRAINT [FK_sUsuarios_sSmtp]
GO
ALTER TABLE [dbo].[sUsuarios]  WITH CHECK ADD  CONSTRAINT [FK_sUsuarios_sUsuarios1] FOREIGN KEY([Usrcrea])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sUsuarios] CHECK CONSTRAINT [FK_sUsuarios_sUsuarios1]
GO
ALTER TABLE [dbo].[sUsuarios]  WITH CHECK ADD  CONSTRAINT [FK_sUsuarios_sUsuarios2] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sUsuarios] CHECK CONSTRAINT [FK_sUsuarios_sUsuarios2]
GO
ALTER TABLE [dbo].[sVentas]  WITH CHECK ADD  CONSTRAINT [FK_sVentas_sEstadoID] FOREIGN KEY([EstadoId])
REFERENCES [dbo].[cEstados] ([EstadoId])
GO
ALTER TABLE [dbo].[sVentas] CHECK CONSTRAINT [FK_sVentas_sEstadoID]
GO
ALTER TABLE [dbo].[sVentas]  WITH CHECK ADD  CONSTRAINT [FK_sVentas_sOrdenes] FOREIGN KEY([OrdenId])
REFERENCES [dbo].[sOrdenes] ([OrdenId])
GO
ALTER TABLE [dbo].[sVentas] CHECK CONSTRAINT [FK_sVentas_sOrdenes]
GO
ALTER TABLE [dbo].[sVentas]  WITH CHECK ADD  CONSTRAINT [FK_sVentas_sUsuarios_crea] FOREIGN KEY([Usrcrea])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sVentas] CHECK CONSTRAINT [FK_sVentas_sUsuarios_crea]
GO
ALTER TABLE [dbo].[sVentas]  WITH CHECK ADD  CONSTRAINT [FK_sVentas_sUsuarios_mod] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sVentas] CHECK CONSTRAINT [FK_sVentas_sUsuarios_mod]
GO
ALTER TABLE [dbo].[sVentash]  WITH CHECK ADD  CONSTRAINT [FK_sVentash_cEstados] FOREIGN KEY([EstadoId])
REFERENCES [dbo].[cEstados] ([EstadoId])
GO
ALTER TABLE [dbo].[sVentash] CHECK CONSTRAINT [FK_sVentash_cEstados]
GO
ALTER TABLE [dbo].[sVentash]  WITH CHECK ADD  CONSTRAINT [FK_sVentash_sUsuarios1] FOREIGN KEY([Usrefect])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sVentash] CHECK CONSTRAINT [FK_sVentash_sUsuarios1]
GO
ALTER TABLE [dbo].[sVentash]  WITH CHECK ADD  CONSTRAINT [FK_sVentash_sUsuarios2] FOREIGN KEY([Usrcrea])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sVentash] CHECK CONSTRAINT [FK_sVentash_sUsuarios2]
GO
ALTER TABLE [dbo].[sVentash]  WITH CHECK ADD  CONSTRAINT [FK_sVentash_sUsuarios3] FOREIGN KEY([Usrmod])
REFERENCES [dbo].[sUsuarios] ([UsrId])
GO
ALTER TABLE [dbo].[sVentash] CHECK CONSTRAINT [FK_sVentash_sUsuarios3]
GO
ALTER TABLE [dbo].[sVentash]  WITH CHECK ADD  CONSTRAINT [FK_sVentash_sVentas] FOREIGN KEY([VentaId])
REFERENCES [dbo].[sVentas] ([VentaId])
GO
ALTER TABLE [dbo].[sVentash] CHECK CONSTRAINT [FK_sVentash_sVentas]
GO
