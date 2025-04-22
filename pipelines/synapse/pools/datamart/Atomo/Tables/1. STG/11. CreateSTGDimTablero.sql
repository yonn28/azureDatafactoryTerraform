
-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-04-07
-- Description: Se crea la Dimension STG.DIM_TABLERO la cual es un insumo para las cargas DWH
-- =============================================

CREATE TABLE [ATOMO].[STG.DIM_TABLERO]
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
	[FK_TIPOSINCONSISTENCIA] [varchar](250) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)


