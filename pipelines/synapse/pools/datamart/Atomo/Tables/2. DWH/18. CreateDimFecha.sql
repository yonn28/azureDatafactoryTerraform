
-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-06-02
-- Description: Se crea la Dimension DWH.DIM_FECHA la cual es un insumo para las vistas de los tableros de Atomo
-- =============================================

CREATE TABLE [ATOMO].[DWH.DIM_FECHA]
(
	[GK_TIEMPO] [int] NOT NULL,
	[FECHA] [date] NOT NULL,
	[AÑO] [int] NULL,
	[MES] [tinyint] NULL,
	[DIA] [tinyint] NULL,
	[PERIODO] [varchar](16) NOT NULL,
	[NUMERO_SEMANA] [tinyint] NULL,
	[TRIMESTRE] [tinyint] NULL,
	[SEMESTRE] [tinyint] NULL,
	[NOMBRE_MES] [varchar](20) NULL,
	[NOMBRE_MES_CORTO] [varchar](5) NULL,
	[NOMBRE_DIA] [varchar](20) NULL,
	[MARCA_FECHA_CORTE] [int] NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)