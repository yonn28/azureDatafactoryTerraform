-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-06-01
-- Description: Se crea la Dimension DWH.DIM_OBJETIVO la cual es un insumo para las vistas de los tableros de Atomo

-- Updated by:  Cristian Pulido
-- Updated Date: 2022-08-24
-- Description: Se agrega el campo "NUM_ORDEN" para combinación de las iniciativas Atomo ILP y Atomo UX
-- =============================================

CREATE TABLE [ATOMO].[DWH.DIM_OBJETIVO]
(
    [GK_OBJETIVO] [bigint] NOT NULL,
	[ID_OBJETIVO] [varchar](50) NOT NULL,
	[DESC_OBJETIVO] [varchar](500) NULL,
	[DTM_FECHA_INI_VIGENCIA_OBJETIVO] [datetime] NULL,
	[DTM_FECHA_FIN_VIGENCIA_OBJETIVO] [datetime] NULL,
	[DTM_FECHACARGA] [datetime] NULL,
	[DESC_ORIGEN] [varchar](80) NULL,
	[FK_TIPOSINCONSISTENCIA] [varchar](250) NULL,
	[NUM_ORDEN] [bigint] NULL,
    CONSTRAINT [ObjetivoPK] UNIQUE NONCLUSTERED 
	(
	[GK_OBJETIVO] ASC
	) NOT ENFORCED 
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	CLUSTERED COLUMNSTORE INDEX
)

