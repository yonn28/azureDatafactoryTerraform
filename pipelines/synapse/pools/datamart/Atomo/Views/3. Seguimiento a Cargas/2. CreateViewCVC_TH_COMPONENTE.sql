-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-07-29
-- Description: Se crea la vista CVC_TH_COMPONENTE la cual es un insumo para el tablero Seguimiento a Cargas.

-- Updated by:   Oscar Angel
-- Updated Date: 2022-09-03
-- Description: Se adiciona el campo DTM_VIGENCIA_HASTA
-- =============================================

CREATE VIEW ATOMO.CVC_TH_COMPONENTE
AS SELECT C.GK_COMPONENTE AS FK_COMPONENTE,
	   C.FK_PERIODO,
	   D.VLR_REAL_PERIODO,
	   D.VLR_REAL_ACUM
FROM
	(SELECT * FROM
		(SELECT CAST(COD_PERIODO AS INT) AS FK_PERIODO
			FROM ATOMO.CVD_AUX_TIEMPO_CARGA) AS A
		INNER JOIN
		(
		SELECT GK_COMPONENTE,
		"DTM_VIGENCIA_HASTA"
			FROM ATOMO.CVD_COMPONENTE ) AS B
		ON LEFT(A."FK_PERIODO", 4) = YEAR(B."DTM_VIGENCIA_HASTA")
	) AS C
LEFT JOIN 
	( SELECT FK_COMPONENTE,
			FK_PERIODO,
			VLR_REAL_PERIODO,
			VLR_REAL_ACUM
	 FROM [ATOMO].[DWH.FACT_COMPONENTE]
	) AS D
ON C.GK_COMPONENTE = D.FK_COMPONENTE 
AND C.FK_PERIODO = D.FK_PERIODO