
-- =============================================

-- Author:      Alejandra Delgado 
-- Update Date: 2023-05-16
-- Description: Se realiza ajuste para la creacion de la tabla temporal TEMPCVC_INDICADORES_ILP_replica

-- =============================================

CREATE TABLE [ATOMO].[TEMPCVC_INDICADORES_ILP_replica]
(
	[FK Indicador] [bigint] NULL,
	[FK Parametrización Indicador] [bigint] NOT NULL,
	[FK Tablero] [bigint] NOT NULL,
	[Periodo] [varchar](500) NULL,
	[Tiempo] [int] NULL,
	[Valor Meta Normalizada Año 1] [float] NULL,
	[Valor Meta Normalizada Año 2] [float] NULL,
	[Valor Meta Normalizada Año 3] [float] NULL,
	[Valor Meta Normalizada Años 1 2] [float] NULL,
	[Valor Meta Normalizada Años 1 2 3] [float] NULL,
	[Valor Real Acumulado] [decimal](38, 10) NULL,
	[Valor Plan Acumulado] [decimal](38, 10) NULL,
	[Valor Plan Acumulado Normalizada] [float] NULL,
	[Valor Meta Año 1] [float] NULL,
	[Valor Meta Año 2] [float] NULL,
	[Valor Meta Año 3] [float] NULL,
	[Valor Meta Años 1 2] [float] NULL,
	[Valor Meta Años 1 2 3] [float] NULL,
	[% Avance Acumulado ILP] [float] NULL,
	[% Cumplimiento Acumulado] [float] NULL,
	[% Avance ILP Años 1 2] [float] NULL,
	[% Avance ILP Año 1] [float] NULL,
	[% Cumplimiento Año 1] [float] NULL,
	[% Cumplimiento Año 2] [float] NULL,
	[% Cumplimiento Año 3] [float] NULL,
	[% Cumplimiento Años 1 2] [float] NULL,
	[% Cumplimiento Años 1 2 3] [float] NULL,
	[Valor Real Proyectado Año 1] [float] NULL,
	[Valor Real Proyectado Año 2] [float] NULL,
	[Valor Real Proyectado Año 3] [float] NULL,
	[Valor Real Proyectado Años 1 2] [float] NULL,
	[Valor Real Proyectado Años 1 2 3] [float] NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
GO
