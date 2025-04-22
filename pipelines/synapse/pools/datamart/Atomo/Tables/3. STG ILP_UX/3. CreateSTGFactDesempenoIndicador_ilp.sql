-- =============================================
-- Author:      Harold Lopez
-- Create Date: 2022-08-12
-- Description: Se crea la STG.FACT_DESEMPENO_INDICADOR_ILP la cual es un insumo para las cargas DWH

-- Author:      Oscar Angel
-- Update Date: 2022-12-15
-- Description: Se realiza ajuste en query por optimizacion de columnas.

-- Author:      Oscar Fabian Angel 
-- Update Date: 2023-03-15
-- Description: Se realiza ajuste para la adicion del campo Plan Acum Periodos

-- Author:      Alejandra Delgado 
-- Update Date: 2023-05-16
-- Description: Se realiza ajuste para la adicion del campo DTM_FECHAMODIFICACION

-- =============================================

CREATE TABLE [ATOMO].[STG.FACT_DESEMPENO_INDICADOR_ILP]
(
	[GK_DESEMP_INDICADOR_ILP] [bigint] NOT NULL,
	[VLR_META_ANNIO_1] [float] NULL,
	[VLR_META_ANNIO_2] [float] NULL,
	[VLR_META_ANNIO_3] [float] NULL,
	[VLR_META_ANNIO_12] [float] NULL,
	[VLR_META_ANNIO_123] [float] NULL,
	[VLR_PLAN_ACUMULADO] [decimal](25, 10) NULL,
	[VLR_RETO] [float] NULL,
	[VLR_META_NORM_ANNIO_1] [float] NULL,
	[VLR_META_NORM_ANNIO_2] [float] NULL,
	[VLR_META_NORM_ANNIO_3] [float] NULL,
	[VLR_META_NORM_ANNIO_12] [float] NULL,
	[VLR_META_NORM_ANNIO_123] [float] NULL,
	[VLR_PLAN_ACUM_NORM] [float] NULL,
	[VLR_REAL_ANNIO_1] [decimal](25, 10) NULL,
	[VLR_REAL_ANNIO_2] [decimal](25, 10) NULL,
	[VLR_REAL_ANNIO_3] [decimal](25, 10) NULL,
	[VLR_REAL_ANNIO_12] [decimal](25, 10) NULL,
	[VLR_REAL_ANNIO_123] [decimal](25, 10) NULL,
	[VLR_REAL_ACUMULADO] [decimal](25, 10) NULL,
	[VLR_REAL_ACUMULADO_MES] [float] NULL,
	[VLR_PROYECCION_ANNIO_1] [float] NULL,
	[VLR_PROYECCION_ANNIO_2] [float] NULL,
	[VLR_PROYECCION_ANNIO_3] [float] NULL,
	[VLR_PROYECCION_ANNIO_12] [float] NULL,
	[VLR_PROYECCION_ANNIO_123] [float] NULL,
	[DESC_PREMISAS] [varchar](4000) NULL,
	[DESC_MENSAJE_CLAVE_INDICADOR] [varchar](4000) NULL,
	[FK_PERIODO] [bigint] NULL,
	[DESC_PERIODO] [varchar](500) NULL,
	[FK_INDICADOR] [bigint] NULL,
	[DTM_FECHACARGA] [datetime] NULL,
	[DTM_FECHAMODIFICACION] [datetime] NULL,
	[DESC_ORIGEN] [varchar](80) NULL,
	[FK_PARAM_INDICADOR] [bigint] NOT NULL,
	[FK_TABLERO] [bigint] NOT NULL,
	[DESC_CORREOUSUARIOCARGO] [varchar](200) NULL,
	[PERIODO AÑO] [varchar](30) NULL,
	[PLAN ACUM PERIODOS] [varchar](15) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)