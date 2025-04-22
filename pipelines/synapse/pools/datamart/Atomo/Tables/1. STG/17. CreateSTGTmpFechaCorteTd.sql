
-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-06-15
-- Description: Se crea la Dimension STG.TMP_FECHA_CORTE_TD la cual es un insumo para las cargas DWH
-- =============================================


CREATE TABLE [ATOMO].[STG.TMP_FECHA_CORTE_TD]
(
	[FECHA_CORTE] [varchar](10) NULL,
	[DTM_FECHACARGA] [datetime] NULL,
	[DESC_ORIGEN] [varchar](80) NULL,
	[FK_TIPOSINCONSISTENCIA] [varchar](250) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO
