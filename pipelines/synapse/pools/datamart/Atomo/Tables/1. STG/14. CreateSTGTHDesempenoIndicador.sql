
-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-04-07
-- Description: Se crea la Dimension STG.TH_DESEMPENO_INDICADOR la cual es un insumo para las cargas DWH
-- =============================================

CREATE TABLE [ATOMO].[STG.TH_DESEMPENO_INDICADOR]
(
	[FK_PARAM_INDICADOR] [bigint] NOT NULL,
	[FK_PERIODO] [bigint] NOT NULL,
	[DESC_PERIODO] [varchar](500) NULL,
	[VLR_PLAN_PERIODO] [decimal](25, 10) NULL,
	[VLR_PLAN_SENSIB_NORM] [decimal](25, 10) NULL,
	[VLR_REAL_PERIODO] [decimal](25, 10) NULL,
	[DESC_CAUSAS_DESEMPENO_PERIODO] [varchar](4000) NULL,
	[VLR_PLAN_ACUM] [decimal](25, 10) NULL,
	[VLR_PLAN_SENSIB_NORM_ACUM] [decimal](25, 10) NULL,
	[VLR_REAL_ACUM] [decimal](25, 10) NULL,
	[DESC_CAUSAS_DESEMPENO_ACUM] [varchar](4000) NULL,
	[VLR_PROYECCION_PERIODO_1] [decimal](25, 10) NULL,
	[VLR_PROYECCION_PERIODO_2] [decimal](25, 10) NULL,
	[VLR_PROYECCION_PERIODO_3] [decimal](25, 10) NULL,
	[VLR_META_ANNIO] [decimal](25, 10) NULL,
	[VLR_PLAN_SENSIB_NORM_ANNIO] [decimal](25, 10) NULL,
	[VLR_META_ANNIO_1] [decimal](25, 10) NULL,
	[VLR_META_ANNIO_2] [decimal](25, 10) NULL,
	[VLR_PROYECCION_ANNIO_ESC_BAJO] [decimal](25, 10) NULL,
	[VLR_PROYECCION_ANNIO_ESC_MEDIO] [decimal](25, 10) NULL,
	[VLR_PROYECCION_ANNIO_ESC_ALTO] [decimal](25, 10) NULL,
	[DESC_PREMISAS_ESC_ALTO] [varchar](4000) NULL,
	[DESC_PREMISAS_ESC_MEDIO] [varchar](4000) NULL,
	[DESC_PREMISAS_ESC_BAJO] [varchar](4000) NULL,
	[DESC_ACCIONES_DE_ASEGURAMIENTO] [varchar](4000) NULL,
	[DTM_FECHACARGA] [datetime] NULL,
	[DESC_ORIGEN] [varchar](80) NULL,
	[FK_TIPOSINCONSISTENCIA] [varchar](250) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)


