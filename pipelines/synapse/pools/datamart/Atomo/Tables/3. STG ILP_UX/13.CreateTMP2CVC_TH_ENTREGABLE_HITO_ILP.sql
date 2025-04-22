
-- =============================================

-- Author:      Alejandra Delgado 
-- Update Date: 2023-05-16
-- Description: Se realiza ajuste para la creacion de la tabla temporal TMP2CVC_TH_ENTREGABLE_HITO_ILP

-- =============================================

CREATE TABLE [ATOMO].[TMP2CVC_TH_ENTREGABLE_HITO_ILP]
(
	[Valor cumplimiento escenario medio entregable] [decimal](25, 10) NULL,
	[Periodo] [varchar](10) NULL,
	[Año Hito] [varchar](20) NULL,
	[Acciones] [varchar](4000) NULL,
	[Causas] [varchar](4000) NULL,
	[Periodo_Vigencia] [char](6) NULL,
	[Fecha de ejecución real] [datetime] NULL,
	[Llave foránea entregable] [bigint] NOT NULL,
	[Nombre del tablero] [varchar](500) NULL,
	[LLave foranea del tablero] [bigint] NULL,
	[Llave foránea parámetro indicador] [bigint] NULL,
	[Premisa escenario alto entregable] [varchar](4000) NULL,
	[Premisa escenario bajo entregable] [varchar](4000) NULL,
	[Premisa escenario medio entregable] [varchar](4000) NULL,
	[Porcentaje cumplimiento entregable] [decimal](25, 10) NULL,
	[Valor cumplimiento escenario alto entregable] [decimal](25, 10) NULL,
	[Valor cumplimiento escenario bajo entregable] [decimal](25, 10) NULL,
	[Valor proyección escenario alto entregable] [decimal](25, 10) NULL,
	[Valor proyección escenario bajo entregable] [decimal](25, 10) NULL,
	[Valor proyección escenario medio entregable] [decimal](25, 10) NULL,
	[Valor real entregable] [decimal](25, 10) NULL,
	[Valor real final entregable] [decimal](25, 10) NULL,
	[Fecha] [date] NULL,
	[CVC_ENTREGABLES_HITO..Peso Entregable] [decimal](38, 6) NULL,
	[CVC_ENTREGABLES_HITO.Descripción Entregable] [varchar](4000) NULL,
	[CVC_ENTREGABLES_HITO.Fecha del Entregable] [datetime] NULL,
	[Llave foránea Parametrización Indicador] [bigint] NULL,
	[CVC_ENTREGABLES_HITO.Nombre Hito] [varchar](4000) NULL,
	[CVC_ENTREGABLES_HITO.Unidad de Medida] [varchar](50) NULL,
	[CVC_ENTREGABLES_HITO.Peso del Entregable] [decimal](38, 10) NULL,
	[CVC_ENTREGABLES_HITO.Plan Entregable] [decimal](38, 10) NULL,
	[CVD_ACTIVIDADES_ENTREGABLES_HITO.Descripción Actividad] [varchar](500) NULL,
	[CVD_ACTIVIDADES_ENTREGABLES_HITO.Fecha de Actividad] [datetime] NULL,
	[CVD_ACTIVIDADES_ENTREGABLES_HITO.GK_ACTIVIDAD_ENTREGABLE_HITO] [bigint] NULL,
	[CVD_CONFIGURACION_TABLERO.DESC_TABLERO_CVR] [varchar](20) NULL,
	[CVD_CONFIGURACION_TABLERO.Detalle Indicador] [varchar](500) NULL,
	[CVD_CONFIGURACION_TABLERO.Sigla Área] [varchar](500) NULL,
	[CVD_CONFIGURACION_TABLERO.Tablero] [varchar](500) NULL,
	[CVD_CONFIGURACION_TABLERO.TBG] [varchar](500) NULL,
	[CVD_CONFIGURACION_TABLERO.Valor Peso Indicador] [decimal](25, 10) NULL,
	[.Llave Actividad Entregable] [varchar](72) NULL,
	[.CC Nombre Indicador - Detalle] [varchar](4503) NULL,
	[_CC Cumplimiento Acumulado] [decimal](38, 6) NULL,
	[_CC Proy Año Hito Alto] [float] NULL,
	[_CC Proy Año Hito Bajo] [float] NULL,
	[_CC Proy Año Hito Medio] [float] NULL,
	[CM_RESUMEN] [varchar](500) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO