
-- =============================================
-- Author:      Oscar Angel 
-- Create Date: 2022-05-13
-- Description: Se crea la vista CVD_PARAMETRIZACION_CVR la cual es un insumo para el tablero Paneles y TBG's

-- Updated by:   Oscar Angel 
-- Updated Date: 2022-09-02
-- Description: Se adiciona los campos DESC_ESTANDAR, FK_CONFIG_TABLERO por ajuste en la combinación de las iniciativas ILP y UX

-- Author:      Oscar Angel 
-- Update Date: 2022-11-10
-- Description: Se realiza ajuste en query por limpieza de columnas en la tabla TD.THDesempenoIndicadorILP
-- =============================================

CREATE VIEW [ATOMO].[CVD_PARAMETRIZACION_CVR] AS 

SELECT DISTINCT GK_CVR,
	 DESC_VERSION,
	 PRC_LIMITE_INFERIOR_CVR,
	 PRC_LIMITE_SUPERIOR_CVR,
	 PRC_META_CVR,
	 DTM_VIGENCIA_DESDE,
	 DTM_FECHACARGA,
	 DESC_ORIGEN,
	 DEC_ESTANDAR AS DESC_ESTANDAR

FROM [ATOMO].[DWH.DIM_CONFIGURACION_CVR]