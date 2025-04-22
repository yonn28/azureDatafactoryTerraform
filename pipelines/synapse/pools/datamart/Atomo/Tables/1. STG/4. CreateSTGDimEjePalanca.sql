 
-- =============================================
-- Author:      Alejandra Delgado
-- Create Date: 2022-04-07
-- Description: Se crea la Dimension STG.DIM_EJE_PALANCA la cual es un insumo para las cargas DWH

-- Author:      Oscar Angel
-- Modify Date: 2023-06-28
-- Description: Se adiciona el campo NumOrden

-- =============================================

CREATE TABLE [ATOMO].[STG.DIM_EJE_PALANCA] 
(
	[GK_EJE_PALANCA] [bigint] NOT NULL,
	[ID_EJE_PALANCA] [varchar](50) NOT NULL,
	[DESC_EJE_PALANCA] [varchar](500) NULL,
	[DTM_FECHA_INI_VIGENCIA_PALANCA] [datetime] NULL,
	[DTM_FECHA_FIN_VIGENCIA_PALANCA] [datetime] NULL,
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