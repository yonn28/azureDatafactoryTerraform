
-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-05-13
-- Description: Se crea la vista CVD_TABLERO la cual es un insumo para el tablero Paneles y TBG's
-- =============================================

CREATE VIEW ATOMO.CVD_TABLERO AS

SELECT GK_TABLERO,
	 ID_TABLERO,
	 DESC_SIGLA_AREA,
	 DESC_TABLERO,
	 DESC_CONTACTO_RED_DESEMPENO,
	 DESC_CARGO_CONTACTO_RED_DESEMPENO,
	 DTM_FECHA_VIGENCIA_DESDE,
	 DTM_FECHA_VIGENCIA_HASTA,
	 DTM_FECHACARGA 
	 
FROM [ATOMO].[DWH.DIM_TABLERO] 