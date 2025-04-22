-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-08-13
-- Description: Se crea la vista CVD_FECHA_CORTE la cual es un insumo para el tablero Seguimiento a Cargas.
-- =============================================

CREATE VIEW ATOMO.CVD_FECHA_CORTE AS 

 SELECT FECHA_CORTE AS "Fecha Corte",
	  FORMAT(CONVERT(date,fecha_corte, 120), 'dddd', 'es-ES') + ', ' + CONVERT(varchar, FORMAT(CONVERT(date,fecha_corte, 120), 'dd MMMM yyyy', 'es-ES'), 106) AS Fecha

FROM [ATOMO].[STG.TMP_FECHA_CORTE_TD] 