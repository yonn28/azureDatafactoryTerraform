-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-06-02
-- Description: Se crea la Dimension DWH.DIM_CONFIGURACION_CVR la cual es un insumo para las vistas de los tableros de Atomo

-- Updated by:   Cristian Pulido
-- Updated Date: 2022-08-24
-- Description: Se agregan los campos "DEC_ESTANDAR" y "FK_CONFIG_TABLERO" para combinación de las iniciativas Atomo ILP y Atomo UX

-- Author:      Oscar Angel 
-- Update Date: 2022-11-09 
-- Description: Se realiza ajuste en la creación de la tabla destino por ajuste de la tabla Stage STG.DIM_CONFIGURACION_CVR_UX en Synapse
-- =============================================

CREATE TABLE [ATOMO].[DWH.DIM_CONFIGURACION_CVR]
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
    [DESC_USUARIO_MODIFICACION] [varchar](500) NULL,
	[DESCDETALLEINDICADORHITO] [varchar](100) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)