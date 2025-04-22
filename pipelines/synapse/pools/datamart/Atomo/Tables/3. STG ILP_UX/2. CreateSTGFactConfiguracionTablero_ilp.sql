
-- =============================================
-- Author:      Harold Lopez
-- Create Date: 2022-08-12
-- Description: Se crea la STG.FACT_CONFIGURACION_TABLERO_ILP la cual es un insumo para las cargas DWH

-- Updated by:   Oscar Angel
-- Updated Date: 2023-10-04
-- Description: Se realiza la adición de los campos ACTIVOCUMPLIMIENTOMIN, CUMPLIMIENTOMINIMO, RECONOCIMIENTOMINIMO para la iniciativa Atomo ILP
-- =============================================

CREATE TABLE [ATOMO].[STG.FACT_CONFIGURACION_TABLERO_ILP]
(
	[GK_CONFIGURACION_TABLERO] [bigint] NOT NULL,
	[DESC_ANNIO] [varchar](20) NOT NULL,
	[DTM_FECHA_REGISTRO] [datetime] NULL,
	[DESC_SIGLA_AREA] [varchar](500) NOT NULL,
	[FK_TABLERO] [bigint] NOT NULL,
	[DESC_VERSION] [varchar](500) NOT NULL,
	[FK_EJE_PALANCA] [bigint] NOT NULL,
	[FK_OBJETIVO] [bigint] NOT NULL,
	[DESC_HITO_INDICADOR] [varchar](500) NULL,
	[FK_PARAM_INDICADOR] [bigint] NOT NULL,
	[FK_INDICADOR] [bigint] NOT NULL,
	[DESC_TIPO_TABLERO] [varchar](500) NULL,
	[DESC_TBG] [varchar](500) NULL,
	[DESC_SECUENCIA_ORDEN] [varchar](500) NULL,
	[VLR_PESO_INDICADOR] [decimal](25, 10) NULL,
	[DESC_CORTO_LARGO_PLAZO] [varchar](500) NULL,
	[VLR_LIMITE_INFERIOR] [decimal](25, 10) NULL,
	[VLR_LIMITE_SUPERIOR] [decimal](25, 10) NULL,
	[DTM_FECHACARGA] [datetime] NULL,
	[DESC_ORIGEN] [varchar](80) NULL,
	[FK_TIPOSINCONSISTENCIA] [varchar](250) NULL,
	[DESC_TABLERO_CVR] [varchar](20) NULL,
	[DESC_HITO_INDIC_HABILITADOR] [varchar](500) NULL,
	[ACTIVOCUMPLIMIENTOMIN] [bit] NULL,
	[CUMPLIMIENTOMINIMO] [numeric](30,10) NULL,
	[RECONOCIMIENTOMINIMO] [numeric](30,10) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO

