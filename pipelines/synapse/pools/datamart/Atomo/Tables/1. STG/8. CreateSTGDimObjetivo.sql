
-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-04-07
-- Description: Se crea la Dimension STG.DIM_OBJETIVO la cual es un insumo para las cargas DWH

-- Author:      Oscar Angel
-- Modify Date: 2023-06-28
-- Description: Se adiciona el campo NumOrden

-- =============================================

CREATE TABLE [ATOMO].[STG.DIM_OBJETIVO]
(
	[GK_OBJETIVO] [bigint] NOT NULL,
	[ID_OBJETIVO] [varchar](50) NOT NULL,
	[DESC_OBJETIVO] [varchar](500) NULL,
	[DTM_FECHA_INI_VIGENCIA_OBJETIVO] [datetime] NULL,
	[DTM_FECHA_FIN_VIGENCIA_OBJETIVO] [datetime] NULL,
	[DTM_FECHACARGA] [datetime] NULL,
	[DESC_ORIGEN] [varchar](80) NULL,
	[FK_TIPOSINCONSISTENCIA] [varchar](250) NULL,
	[NUMORDEN] [BIGINT] NULL

)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
) 