
-- =============================================
-- Author:      Harold Lopez
-- Create Date: 2022-08-12
-- Description: Se crea la STG.DIM_ESCENARIOSANALISIS_UX la cual es un insumo para las vistas de los tableros de Atomo

-- Updated by:   Oscar Angel
-- Updated Date: 2022-10-18
-- Description: Se realiza la adición de nuevos campos DESC_CAUSA_ACUMULADO, NUM_PERIODO, DESC_CAUSA_PERIODO, DESC_ESC_BAJO, DESC_ESCEN_BAJO, DESC_ESC_MEDIO, DESC_ESCEN_MEDIO, DESC_ESC_ALTO, DESC_ESCEN_ALTO, DESCR_ACCION, FK_INDICADOR, DTM_FECHACARGA, DESC_USUARIO_CREACION, DTM_FECHA_MODIFICACION, DESC_USUARIO_MODIFICACION por ajustes en el formulario de carga para esta tabla.

-- Updated by:   Alejandro Vargas
-- Updated Date: 2022-12-01
-- Description: Se realiza la modificación de los campos DESC_CAUSA_ACUMULADO, DESC_CAUSA_PERIODO, DESC_ESC_BAJO, DESC_ESCEN_BAJO, DESC_ESC_MEDIO, DESC_ESCEN_MEDIO, DESC_ESC_ALTO, DESC_ESCEN_ALTO, DESCR_ACCION, DESCR_COMENTARIO, DESC_USUARIO_CREACION, DESC_USUARIO_MODIFICACION por la longitud del varchar para que almacene los datos fuente se agrega el campo DESC_DETALLE_INDICADOR.
-- ============================================

CREATE TABLE [ATOMO].[DWH.DIM_ESCENARIOSANALISIS_UX]
(   [GK_ESCENARIO_ANALISIS] [bigint] NOT NULL,
    [DESC_CAUSA_ACUMULADO] [varchar](4000) NULL,
    [NUM_PERIODO] [bigint] NULL,
    [DESC_CAUSA_PERIODO] [varchar](4000) NULL,
    [DESC_ESC_BAJO] [varchar](50) NULL,
    [DESC_ESCEN_BAJO] [varchar](4000) NULL,
    [DESC_ESC_MEDIO] [varchar](50) NULL,
    [DESC_ESCEN_MEDIO] [varchar](4000) NULL,
    [DESC_ESC_ALTO] [varchar](50) NULL,
    [DESC_ESCEN_ALTO] [varchar](4000) NULL,
    [DESCR_ACCION] [varchar](4000) NULL,
    [DESCR_COMENTARIO] [varchar](4000) NULL,
    [FK_INDICADOR] [bigint] NULL,
    [DTM_FECHACARGA] [datetime] NULL,
    [DESC_USUARIO_CREACION] [varchar](500) NULL,
    [DTM_FECHA_MODIFICACION] [datetime] NULL,
    [DESC_USUARIO_MODIFICACION] [varchar](4000) NULL,
    [DESC_DETALLE_INDICADOR] [varchar](50))
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)