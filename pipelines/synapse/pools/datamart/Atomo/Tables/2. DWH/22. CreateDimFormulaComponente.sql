-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-08-13
-- Description: Se crea la Dimension DWH.DIM_FORMULA_COMPONENTE la cual es un insumo para las vistas del tablero de seguimiento a cargas de Atomo
-- =============================================

CREATE TABLE [ATOMO].[DWH.DIM_FORMULA_COMPONENTE]
(
	[GK_FORMULA_COMPONENTE] [bigint] NOT NULL,
	[ID_FORMULA_COMPONENTE] [bigint] NOT NULL,
	[FK_INDICADOR] [bigint] NOT NULL,
	[DESC_DETALLE_INDICADOR] [varchar](500) NULL,
	[DESC_RESPONSABLE_FORMULA] [varchar](500) NULL,
	[DESC_FORMULA] [varchar](500) NULL,
	[DTM_FECHACARGA] [datetime] NULL,
	[DESC_ORIGEN] [varchar](80) NULL,
	[FK_TIPOSINCONSISTENCIA] [varchar](250) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
) 