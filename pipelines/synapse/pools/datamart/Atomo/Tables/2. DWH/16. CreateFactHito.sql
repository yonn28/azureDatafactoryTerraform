-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-06-02
-- Description: Se crea la Dimension DWH.FACT_HITO la cual es un insumo para las vistas de los tableros de Atomo

-- Updated by:  Oscar Angel
-- Updated Date: 2022-08-13
-- Description:  Se agrega el campo "CM_RESUMEN" para combinación de las iniciativas Atomo ILP y Atomo UX
-- =============================================

CREATE TABLE [ATOMO].[DWH.FACT_HITO]
(
	[FK_HITO] [bigint] NOT NULL,
	[FK_PARAM_INDICADOR] [bigint] NOT NULL,
	[FK_PERIODO] [bigint] NOT NULL,
	[FK_TIEMPO] [BIGINT] NOT NULL, 
	[VLR_PLAN_HITO] [decimal](25, 10) NULL,
	[VLR_REAL_HITO] [decimal](25, 10) NULL,
	[PRC_CUMP_HITO] [decimal](25, 10) NULL,
	[VLR_PROY_ESC_BAJO] [decimal](25, 10) NULL,
	[VLR_PROY_ESC_MEDIO] [decimal](25, 10) NULL,
	[VLR_PROY_ESC_ALTO] [decimal](25, 10) NULL,
	[DESC_CORREO_USUARIO] [varchar](250) NULL,
	[DTM_FECHA_EVENTO_REGISTRO] [datetime] NULL,
	[DTM_FECHACARGA] [datetime] NULL,
	[DESC_ORIGEN] [varchar](80) NULL,
	[FK_TIPOSINCONSISTENCIA] [varchar](250) NULL,
	[FECHA_CARGA_SYNAPSE]  [datetime] NULL,
	[FECHA_PROXIMA_ACTUALIZA_SYNAPSE]  [datetime] NULL,
	[CM_RESUMEN] [varchar](500) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)


