 
-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-04-07
-- Description: Se crea la Dimension STG.DIM_ENTREGABLES_HITO la cual es un insumo para las cargas DWH
-- =============================================

CREATE TABLE [ATOMO].[STG.DIM_ENTREGABLES_HITO]
(
	[GK_ENTREGABLE_HITO] [bigint] NOT NULL,
	[ID_ENTREGABLE] [varchar](50) NOT NULL,
	[FK_INDICADOR] [bigint] NULL,
	[FK_PARAM_INDICADOR] [bigint] NULL,
	[DTM_FECHA_USAR] [datetime] NULL,
	[DESC_ENTREGABLE] [varchar](4000) NULL,
	[DESC_RESPONSABLE_ENTREGABLE] [varchar](500) NULL,
	[DESC_CORREO_RESPONSABLE_ENTREGABLE] [varchar](500) NULL,
	[DTM_FECHA_ENTREGABLE] [datetime] NULL,
	[VLR_PESO_ENTREGABLE] [decimal](25, 10) NULL,
	[DESC_UNIDAD_MEDIDA] [varchar](50) NULL,
	[VLR_PLAN_ENTREGABLE] [decimal](25, 10) NULL,
	[DTM_FECHA_EJECUCION_ENTREGABLE] [datetime] NULL,
	[PRC_CUMPLIMIENTO_ENTREGABLE] [decimal](25, 10) NULL,
	[DESC_COMENTARIOS_ENTREGABLE] [varchar](1000) NULL,
	[DTM_FECHACARGA] [datetime] NULL,
	[DESC_ORIGEN] [varchar](80) NULL,
	[FK_TIPOSINCONSISTENCIA] [varchar](250) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)


