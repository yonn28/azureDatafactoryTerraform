-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-08-11
-- Description: Se crea la Dimension STG.DIM_COMPONENTE_VISTA la cual es un insumo para las cargas DWH
-- =============================================

CREATE TABLE [ATOMO].[STG.DIM_COMPONENTE_VISTA]
(
	[FK_INDICADOR] [bigint] NULL,
	[DESC_DETALLE_INDICADOR] [nvarchar](500) NULL,
	[ID_COMPONENTE] [nvarchar](500) NULL,
	[DESC_FORMULA] [nvarchar](500) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)