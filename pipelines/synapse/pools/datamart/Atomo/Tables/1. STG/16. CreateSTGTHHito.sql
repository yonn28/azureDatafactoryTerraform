 
-- =============================================
-- Author:      Alejandra Delgado
-- Create Date: 2022-04-07
-- Description: Se crea la Dimension STG.TH_HITO la cual es un insumo para las cargas DWH
-- =============================================

CREATE TABLE [ATOMO].[STG.TH_HITO]
(
	[FK_HITO] [bigint] NOT NULL,
	[FK_PARAM_INDICADOR] [bigint] NOT NULL,
	[FK_PERIODO] [bigint] NOT NULL,
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
	[FK_TIPOSINCONSISTENCIA] [varchar](250) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)



