-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-06-02
-- Description: Se crea la Fact DWH.FACT_ACTIVIDAD_ENTREGABLE_HITO la cual es un insumo para las vistas de los tableros de Atomo
-- =============================================

CREATE TABLE [ATOMO].[DWH.FACT_ACTIVIDAD_ENTREGABLE_HITO]
(
	[FK_HITO] [bigint] NOT NULL,
	[FK_PARAM_INDICADOR] [bigint] NOT NULL, 
	[FK_ENTREGABLE] [bigint] NOT NULL,
	[FK_ACTIVIDAD] [bigint] NOT NULL,
	[FK_PERIODO] [bigint] NOT NULL,
	[FK_TIEMPO] [INT] NOT NULL,
	[IND_CUMPLIMIENTO] [int] NULL,
	[DESC_CORREO_USUARIO] [varchar](250) NULL, 
	[DTM_FECHA_EVENTO_REGISTRO] [datetime] NULL,
	[DTM_FECHACARGA] [datetime] NULL,
	[DESC_ORIGEN] [varchar](80) NULL,
	[FK_TIPOSINCONSISTENCIA_ACTIVIDADENTREGABLE] [varchar](250) NULL,
	[FECHA_CARGA_SYNAPSE]  [datetime] NULL,
	[FECHA_PROXIMA_ACTUALIZA_SYNAPSE]  [datetime] NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)


