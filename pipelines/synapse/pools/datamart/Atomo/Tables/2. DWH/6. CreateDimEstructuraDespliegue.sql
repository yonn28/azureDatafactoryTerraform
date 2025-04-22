-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-05-31
-- Description: Se crea la Dimension DWH.DIM_ESTRUCTURA_DESPLIEGUE la cual es un insumo para las vistas de los tableros de Atomo
-- =============================================

CREATE TABLE [ATOMO].[DWH.DIM_ESTRUCTURA_DESPLIEGUE]
(
	[GK_ESTRUCTURA_DESPLIEGUE] [bigint] NULL,
	[ID_ESTRUCTURA] [varchar](50) NULL,
	[DESC_GRUPO] [varchar](500) NULL,
	[DESC_EMPRESA] [varchar](500) NULL,
	[DESC_VP_EJECUTIVA] [varchar](500) NULL,
	[DESC_GRUPO_SEGMENTO] [varchar](500) NULL,
	[DESC_SEGMENTO] [varchar](500) NULL,
	[DESC_UNIDAD_NEGOCIO_NVL_2] [varchar](500) NULL,
	[DESC_UNIDAD_NEGOCIO_NVL_3] [varchar](500) NULL,
	[DESC_GERENCIA] [varchar](500) NULL,
	[DESC_RUTINA] [varchar](500) NULL,
	[DTM_FECHA_VIGENCIA_DESDE] [datetime] NULL,
	[DTM_FECHA_VIGENCIA_HASTA] [datetime] NULL,
	[DESC_SIGLA] [varchar](500) NOT NULL,
	[DESC_NIVEL] [varchar](500) NULL,
	[DESC_ESTADO_REG] [varchar](250) NULL,
	[DTM_FECHACARGA] [datetime] NULL,
	[DESC_ORIGEN] [varchar](80) NULL,
	[FK_TIPOSINCONSISTENCIA] [varchar](250) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)


