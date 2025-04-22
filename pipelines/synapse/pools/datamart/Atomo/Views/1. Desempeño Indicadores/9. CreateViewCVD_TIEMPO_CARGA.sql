
-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-05-16
-- Description: Se crea la vista CVD_TIEMPO_CARGA la cual es un insumo para el tablero Paneles y TBG's
-- =============================================

CREATE VIEW [ATOMO].[CVD_TIEMPO_CARGA]

AS SELECT DISTINCT DESC_TIPO_CARGA,
	 DTM_FECHA_INICIO,
	 DTM_FECHA_FIN,
	 DESC_PROCESO_TIPO_CARGA,
	 DESC_PERIODO_CARGA,
	 DESC_DETALLE,
	 DESC_ENTREGABLE,
	 DESC_ESTADO,
	 CASE 
		WHEN GETDATE() BETWEEN DTM_FECHA_INICIO AND DTM_FECHA_FIN 
			 AND DESC_TIPO_CARGA = 'Indicadores - Datos' THEN 1
		ELSE 0
	END AS "_CC Marca Fehca",
	SUBSTRING(CAST(DESC_PERIODO_CARGA AS VARCHAR),1,4) AS "Año Periodo",
	SUBSTRING(CAST(DESC_PERIODO_CARGA AS VARCHAR),5,2) AS "Mes Periodo"
FROM [ATOMO].[DWH.DIM_TIEMPO_CARGA]
WHERE LEN(DESC_PERIODO_CARGA) > 4;
