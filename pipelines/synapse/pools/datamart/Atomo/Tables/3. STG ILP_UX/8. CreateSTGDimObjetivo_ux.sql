
-- =============================================
-- Author:      Harold Lopez
-- Create Date: 2022-08-12
-- Description: Se crea la STG.DIM_OBJETIVO_UX la cual es un insumo para las cargas DWH
-- =============================================

CREATE TABLE [ATOMO].[STG.DIM_OBJETIVO_UX]
(
	[GK_OBJETIVO] [bigint] NOT NULL,
	[ID_OBJETIVO] [varchar](50) NOT NULL,
	[DESC_OBJETIVO] [varchar](500) NULL,
	[DTM_FECHA_INI_VIGENCIA_OBJETIVO] [datetime] NULL,
	[DTM_FECHA_FIN_VIGENCIA_OBJETIVO] [datetime] NULL,
	[DTM_FECHACARGA] [datetime] NULL,
	[DESC_ORIGEN] [varchar](80) NULL,
	[FK_TIPOSINCONSISTENCIA] [varchar](250) NULL,
	[NUM_ORDEN] [bigint] NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO