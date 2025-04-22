
-- =============================================
-- Author:      Fabian Angel
-- Create Date: 2022-11-18
-- Description: Se crea la STG.DIM_CVR_INDICADOR_HITO la cual es un insumo para procesos posteriores.
-- =============================================

CREATE TABLE [ATOMO].[STG.DIM_CVR_INDICADOR_HITO]
(
    [GKDIMCVRINDICADORHITO] [bigint] IDENTITY(1,1) NOT NULL,
	[FKCONFIGCVR] [bigint] NULL,
	[FKINDICADORHITO] [bigint] NULL,
	[DESCDETALLEINDICADORHITO] [varchar](100) NULL 
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO