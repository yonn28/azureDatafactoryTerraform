-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-08-13
-- Description: Se crea la Dimension DWH.DIM_COMPONENTE_VISTA la cual es un insumo para las vistas del tablero de seguimiento a cargas de Atomo
-- =============================================

CREATE TABLE [ATOMO].[DWH.DIM_COMPONENTE_VISTA]
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