 
-- =============================================
-- Author:      Alejandra Delgado
-- Create Date: 2022-04-07
-- Description: Se crea la Dimension STG.TH_ENTREGABLE_HITO la cual es un insumo para las cargas DWH
-- =============================================

CREATE TABLE [ATOMO].[STG.TH_ENTREGABLE_HITO]
(
	[FK_HITO] [bigint] NOT NULL,
	[FK_PARAM_INDICADOR] [bigint] NOT NULL,
	[FK_ENTREGABLE] [bigint] NOT NULL,
	[FK_PERIODO] [bigint] NOT NULL,
	[VLR_PLAN_ENTREGABLE] [decimal](25, 10) NULL,
	[DTM_FECHA_EJECUCION_REAL] [datetime] NULL,
	[VLR_REAL_ENTREGABLE] [decimal](25, 10) NULL,
	[PRC_CUMP_ENTREGABLE] [decimal](25, 10) NULL,
	[DESC_CAUSAS] [varchar](4000) NULL,
	[DESC_ACCIONES] [varchar](4000) NULL,
	[VLR_REAL_FINAL_ENTREGABLE] [decimal](25, 10) NULL,
	[VLR_PROY_ESC_BAJO_ENTREGABLE] [decimal](25, 10) NULL,
	[VLR_PROY_ESC_MEDIO_ENTREGABLE] [decimal](25, 10) NULL,
	[VLR_PROY_ESC_ALTO_ENTREGABLE] [decimal](25, 10) NULL,
	[DESC_PREMISA_ESC_BAJO_ENTREGABLE] [varchar](4000) NULL,
	[DESC_PREMISA_ESC_MEDIO_ENTREGABLE] [varchar](4000) NULL,
	[DESC_PREMISA_ESC_ALTO_ENTREGABLE] [varchar](4000) NULL,
	[VLR_CUMP_ESC_BAJO_ENTREGABLE] [decimal](25, 10) NULL,
	[VLR_CUMP_ESC_MEDIO_ENTREGABLE] [decimal](25, 10) NULL,
	[VLR_CUMP_ESC_ALTO_ENTREGABLE] [decimal](25, 10) NULL,
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



