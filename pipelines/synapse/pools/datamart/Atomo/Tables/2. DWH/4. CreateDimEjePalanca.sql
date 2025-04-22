-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-05-31
-- Description: Se crea la Dimension DWH.DIM_EJE_PALANCA la cual es un insumo para las vistas de los tableros de Atomo

-- Updated by:   Cristian Pulido 
-- Updated Date: 2022-08-24
-- Description: Se agregan el campo "NUM_ORDEN" para combinación de las iniciativas Atomo ILP y Atomo UX
-- =============================================

CREATE TABLE [ATOMO].[DWH.DIM_EJE_PALANCA]
(
	[GK_EJE_PALANCA] [bigint] NOT NULL,
	[ID_EJE_PALANCA] [varchar](50) NOT NULL,
	[DESC_EJE_PALANCA] [varchar](500) NULL,
	[DTM_FECHA_INI_VIGENCIA_PALANCA] [datetime] NULL,
	[DTM_FECHA_FIN_VIGENCIA_PALANCA] [datetime] NULL,
	[DTM_FECHACARGA] [datetime] NULL,
	[DESC_ORIGEN] [varchar](80) NULL,
	[FK_TIPOSINCONSISTENCIA] [varchar](250) NULL,
	[NUM_ORDEN] [int] NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)


