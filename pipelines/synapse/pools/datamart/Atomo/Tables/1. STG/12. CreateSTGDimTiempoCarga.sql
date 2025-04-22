
-- =============================================
-- Author:      Alejandra Delgado
-- Create Date: 2022-04-07
-- Description: Se crea la Dimension STG.DIM_TIEMPO_CARGA la cual es un insumo para las cargas DWH
-- =============================================

CREATE TABLE [ATOMO].[STG.DIM_TIEMPO_CARGA]
(
	[DESC_PROCESO_TIPO_CARGA] [varchar](200) NOT NULL,
	[DESC_TIPO_CARGA] [varchar](200) NOT NULL,
	[DESC_PERIODO_CARGA] [int] NOT NULL,
	[DTM_FECHA_INICIO] [datetime] NOT NULL,
	[DTM_FECHA_FIN] [datetime] NOT NULL,
	[DESC_DETALLE] [varchar](4000) NULL,
	[DESC_ENTREGABLE] [varchar](4000) NULL,
	[DTM_FECHA_CARGA] [datetime] NOT NULL,
	[DESC_ORIGEN] [varchar](100) NOT NULL,
	[DESC_ESTADO] [varchar](20) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)

