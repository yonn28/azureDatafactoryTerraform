-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-06-02
-- Description: Se crea la Fact DWH.FACT_RESUMEN_TENDENCIA_DETALLE_KRI_TD la cual es un insumo para las vistas de los tableros de Atomo
-- =============================================
 
CREATE TABLE [ATOMO].[DWH.FACT_RESUMEN_TENDENCIA_DETALLE]
(
	[FK_FECHA_CORTE] [int] NULL,
	[FECHA] [date] NULL,
	[PERIODO] [varchar](7) NULL,
	[ANIO] [varchar](4) NULL,
	[MES] [varchar](2) NULL,
	[ID_OBJETIVO] [varchar](4000) NULL,
	[DESC_OBJETIVO] [varchar](4000) NULL,
	[FK_RIESGO] [int] NULL,
	[DESC_NOMBRE_CORTO_CONSEC_RIESGO] [varchar](200) NULL,
	[FK_KRI] [int] NULL,
	[ULT_MEDICION_KRI] [varchar](5000) NULL,
	[VLR_KRI] [decimal](16, 2) NULL,
	[VLR_LIMITE_KRI] [decimal](16, 2) NULL,
	[DESC_NOMBRE_CORTO_KRI] [varchar](200) NULL,
	[LLAVE] [varchar](4000) NULL,
	[DESC_UNIDAD_MEDIDA] [varchar](5000) NULL,
	[DESC_FRECUENCIA] [varchar](2000) NULL,
	[DESC_TENDENCIA_ABREVIADO] [varchar](20) NULL,
	[MEDICION_FUERA_LIMITE_12_MESES] [varchar](64) NULL,
	[ESTADO_DEL_KRI] [int] NULL,
	[MEDIA_ULT_12_MESES] [varchar](5000) NULL,
	[DESC_COMENTARIO_KRI] [varchar](5000) NULL,
	[DESC_COMENTARIO_RIESGO] [varchar](5000) NULL,
	[FECHA_CARGA_SYNAPSE]  [datetime] NULL,
	[FECHA_PROXIMA_ACTUALIZA_SYNAPSE]  [datetime] NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)


