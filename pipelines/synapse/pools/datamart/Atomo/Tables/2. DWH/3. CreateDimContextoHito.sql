-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-05-31
-- Description: Se crea la Dimension DWH.DIM_CONTEXTO_HITO la cual es un insumo para las vistas de los tableros de Atomo
-- =============================================

CREATE TABLE [ATOMO].[DWH.DIM_CONTEXTO_HITO]
(
	[GK_CONTEXTO_HITO] [bigint] NOT NULL,
	[FK_INDICADOR] [bigint] NULL,
	[DTM_FECHA_REGISTRO_CONTEXTO] [Datetime] NULL,
	[DTM_FECHA_USAR] [Datetime] NULL,
	[DESC_SPONSOR] [varchar](2000) NULL,
	[DESC_CORREO_SPONSOR] [varchar](2000) NULL,
	[VLR_PLAN_HITO] [decimal](25, 10) NULL,
	[DESC_CONTEXTO_MOTIVACION] [varchar](4000) NULL,
	[DESC_OBJETIVO] [varchar](2000) NULL,
	[DESC_IMPACTO] [varchar](2000) NULL,
	[DESC_INTERDEPENDENCIAS] [varchar](2000) NULL,
	[DESC_RIESGOS_PRINCIPALES] [varchar](2000) NULL,
	[DESC_MITIGANTES_RIESGO] [varchar](2000) NULL,
	[DTM_FECHACARGA] [Datetime] NULL,
	[DESC_ORIGEN] [varchar](80) NULL,
	[FK_TIPOSINCONSISTENCIA] [varchar](250) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)


