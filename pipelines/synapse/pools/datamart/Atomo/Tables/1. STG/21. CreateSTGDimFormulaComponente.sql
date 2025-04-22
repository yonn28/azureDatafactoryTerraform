-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-08-11
-- Description: Se crea la Dimension STG.DIM_FORMULA_COMPONENTE la cual es un insumo para las cargas DWH
-- =============================================

CREATE TABLE [ATOMO].[STG.DIM_FORMULA_COMPONENTE]
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
