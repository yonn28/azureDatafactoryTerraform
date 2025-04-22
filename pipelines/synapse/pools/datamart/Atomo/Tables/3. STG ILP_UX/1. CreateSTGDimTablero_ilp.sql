
-- =============================================
-- Author:      Harold Lopez
-- Create Date: 2022-08-12
-- Description: Se crea la STG.DIM_TABLERO_ILP la cual es un insumo para las cargas DWH
-- =============================================

CREATE TABLE [ATOMO].[STG.DIM_TABLERO_ILP]
(
	[GK_TABLERO] [bigint] NOT NULL,
	[ID_TABLERO] [varchar](50) NULL,
	[DESC_SIGLA_AREA] [varchar](500) NOT NULL,
	[DESC_TABLERO] [varchar](500) NULL,
	[DESC_CONTACTO_RED_DESEMPENO] [varchar](500) NULL,
	[DESC_CARGO_CONTACTO_RED_DESEMPENO] [varchar](500) NULL,
	[DTM_FECHA_VIGENCIA_DESDE] [datetime] NULL,
	[DTM_FECHA_VIGENCIA_HASTA] [datetime] NULL,
	[DTM_FECHACARGA] [datetime] NULL,
	[DESC_ORIGEN] [varchar](80) NULL,
	[FK_TIPOSINCONSISTENCIA] [varchar](250) NULL,
	[DESC_DESCRIP_TABLERO] [varchar](500) NULL,
	[DESC_RESP_CONFIG_ATOMO] [varchar](500) NULL,
	[DESC_BACK_RESP_CONFIG_ATOMO] [varchar](500) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO

