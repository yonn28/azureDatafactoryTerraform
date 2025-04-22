
-- =============================================
-- Author:      Harold Lopez
-- Create Date: 2022-08-12
-- Description: Se crea la STG.DIM_EJE_PALANCA_UX la cual es un insumo para las cargas DWH
-- =============================================

CREATE TABLE [ATOMO].[STG.DIM_EJE_PALANCA_UX]
(
	[GK_EJE_PALANCA] [bigint] NOT NULL,
	[ID_EJE_PALANCA] [varchar](50) NOT NULL,
	[DESC_EJE_PALANCA] [varchar](500) NULL,
	[DTM_FECHA_INI_VIGENCIA_PALANCA] [datetime] NULL,
	[DTM_FECHA_FIN_VIGENCIA_PALANCA] [datetime] NULL,
	[DTM_FECHACARGA] [datetime] NULL,
	[DESC_ORIGEN] [varchar](80) NULL,
	[FK_TIPOSINCONSISTENCIA] [varchar](250) NULL,
	[NUM_ORDEN] [int] NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO