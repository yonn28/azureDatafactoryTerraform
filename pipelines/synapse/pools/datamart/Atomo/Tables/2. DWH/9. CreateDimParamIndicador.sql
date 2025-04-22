
-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-05-31
-- Description: Se crea la Dimension DWH.DIM_PARAM_INDICADOR la cual es un insumo para las vistas de los tableros de Atomo
-- =============================================

CREATE TABLE [ATOMO].[DWH.DIM_PARAM_INDICADOR]
(
	[GK_PARAM_INDICADOR] [bigint] NOT NULL,
	[FK_INDICADOR] [bigint] NULL,
	[DTM_FECHA_REGISTRO] [datetime] NULL,
	[DESC_RESPONSABLE_MEDICION] [varchar](500) NULL,
	[DESC_CARGO_RESPONSABLE_MEDICION] [varchar](500) NULL,
	[DESC_CORREO_RESPONSABLE_MEDICION] [varchar](500) NULL,
	[DESC_AREA_RESPONSABLE_MEDICION] [varchar](500) NULL,
	[ID_UNIDAD_ORGANIZATIVA] [varchar](50) NULL,
	[DESC_RESPONSABLE_MEDICION_2] [varchar](500) NULL,
	[DESC_CARGO_RESPONSABLE_MEDICION_2] [varchar](500) NULL,
	[DESC_CORREO_RESPONSABLE_MEDICION_2] [varchar](500) NULL,
	[DESC_AREA_RESPONSABLE_MEDICION_2] [varchar](500) NULL,
	[ID_UNIDAD_ORGANIZATIVA_2] [varchar](50) NULL,
	[DESC_SIGLA_AREA] [varchar](500) NULL,
	[DESC_DETALLE_INDICADOR] [varchar](500) NOT NULL,
	[DESC_CONTROL_CARGA] [varchar](300) NULL,
	[DTM_FECHACARGA] [datetime] NULL,
	[DESC_ORIGEN] [varchar](80) NULL,
	[FK_TIPOSINCONSISTENCIA] [varchar](250) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)


