
-- =============================================

-- Author:      Alejandra Delgado
-- Update Date: 2023-05-16
-- Description: Se realiza ajuste para la creacion de la tabla temporal TEMPCVC_TH_ENTREGABLE_HITO_ILP_replica

-- =============================================

CREATE TABLE [ATOMO].[TEMPCVC_TH_ENTREGABLE_HITO_ILP_replica]
(
	[Valor cumplimiento escenario medio entregable] [decimal](25, 10) NULL,
	[Valor proyección escenario medio entregable] [decimal](25, 10) NULL,
	[Fecha de ejecución real] [datetime] NULL,
	[Valor real entregable] [decimal](25, 10) NULL,
	[Porcentaje cumplimiento entregable] [decimal](25, 10) NULL,
	[Valor real final entregable] [decimal](25, 10) NULL,
	[_CC Proy Año Hito Medio] [float] NULL,
	[_CC Cumplimiento Acumulado] [decimal](38, 6) NULL,
	[CM_RESUMEN] [varchar](500) NULL,
	[Periodo_Vigencia] [char](6) NULL,
	[Periodo] [varchar](10) NULL,
	[Año Hito] [varchar](20) NULL,
	[Llave foránea parámetro indicador] [bigint] NULL,
	[LLave foranea del tablero] [bigint] NULL,
	[Llave foránea entregable] [bigint] NOT NULL,
	[Duplicados] [int] NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO