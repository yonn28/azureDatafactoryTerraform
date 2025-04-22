-- =============================================
-- Author:      Harold Lopez
-- Create Date: 2022-08-12
-- Description: Se crea la STG.DIM_CONFIGURACION_CVR_UX la cual es un insumo para las cargas DWH

-- Author:      Oscar Angel 
-- Update Date: 2022-11-09
-- Description: Se realiza ajuste en la creación de la tabla destino por ajuste de la tablas DimConfiguracion_CVR en TD
-- =============================================

CREATE TABLE [ATOMO].[STG.DIM_CONFIGURACION_CVR_UX]
(
	[GK_CVR] [bigint] NOT NULL,
	[DESC_VERSION] [varchar](50) NULL,
	[PRC_LIMITE_INFERIOR_CVR] [decimal](25, 10) NULL,
	[PRC_LIMITE_SUPERIOR_CVR] [decimal](25, 10) NULL,
	[PRC_META_CVR] [decimal](25, 10) NULL,
	[DTM_VIGENCIA_DESDE] [int] NULL,
	[DTM_FECHACARGA] [datetime] NULL,
	[DESC_ORIGEN] [varchar](80) NULL,
	[DEC_ESTANDAR] [bit] NULL,
    [EMAIL_ASOCIADO_CVR] [varchar](100) NULL,
    [DESC_USUARIO_CREACION] [varchar](500) NULL,
    [DTM_FECHA_MODIFICACION] [datetime] NULL,
    [DESC_USUARIO_MODIFICACION] [varchar](500) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)
