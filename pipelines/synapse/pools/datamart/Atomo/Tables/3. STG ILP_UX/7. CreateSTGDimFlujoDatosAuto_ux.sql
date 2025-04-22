
-- =============================================
-- Author:      Harold Lopez
-- Create Date: 2022-08-12
-- Description: Se crea la STG.DIM_FLUJODATOSAUTO_UX la cual es un insumo para las cargas DWH
-- =============================================

CREATE TABLE [ATOMO].[STG.DIM_FLUJODATOSAUTO_UX]
(
	[GK_FLUJO_DATOS_AUTO] [bigint] NOT NULL,
	[DESC_DATAMART] [varchar](500) NULL,
	[DESC_NOMBREPAQUETE] [varchar](500) NULL,
	[DESC_VISTACALCULADA] [varchar](500) NULL,
	[DESC_RESPVISTACALC] [varchar](500) NULL,
	[DESC_ESTADOCONS] [varchar](500) NULL,
	[DESC_RESPPARAM] [varchar](500) NULL,
	[DESC_SISFUENTE] [varchar](500) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO