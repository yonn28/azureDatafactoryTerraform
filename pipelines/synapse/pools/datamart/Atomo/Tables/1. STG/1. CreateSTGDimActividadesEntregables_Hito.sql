 
-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-04-07
-- Description: Se crea la Dimension STG.DIM_ACTIVIDADES_ENTREGABLE_HITO la cual es un insumo para las cargas DWH
-- =============================================

CREATE TABLE [ATOMO].[STG.DIM_ACTIVIDADES_ENTREGABLE_HITO]
(
	[GK_ACTIVIDAD_ENTREGABLE_HITO] [bigint] NOT NULL,
	[ID_ACTIVIDAD] [varchar](50) NOT NULL,
	[FK_ENTREGABLE_HITO] [bigint] NULL,
	[DESC_ACTIVIDAD] [varchar](500) NULL,
	[DTM_FECHA_ACTIVIDAD] [datetime] NULL,
	[DTM_FECHA_EJECUCION_ACTIVIDAD] [datetime] NULL,
	[DESC_CUMPLE_PENDIENTE] [varchar](500) NULL,
	[DESC_COMENTARIOS_ACTIVIDAD] [varchar](500) NULL,
	[DTM_FECHACARGA] [datetime] NULL,
	[DESC_ORIGEN] [varchar](80) NULL,
	[FK_TIPOSINCONSISTENCIA] [varchar](250) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
