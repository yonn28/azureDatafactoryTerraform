
-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-05-23
-- Description: Se crea la vista CVD_ESTRUCTURA_DESPLIEGUE la cual es un insumo para el tablero Resultados Consolidados.
-- =============================================

CREATE VIEW ATOMO.CVD_ESTRUCTURA_DESPLIEGUE AS 

SELECT ID_ESTRUCTURA,
	 DESC_GRUPO,
	 DESC_EMPRESA,
	 DESC_VP_EJECUTIVA,
	 DESC_GRUPO_SEGMENTO,
	 DESC_SEGMENTO,
	 DESC_UNIDAD_NEGOCIO_NVL_2,
	 DESC_UNIDAD_NEGOCIO_NVL_3,
	 DESC_GERENCIA,
	 DESC_RUTINA,
	 DTM_FECHA_VIGENCIA_DESDE,
	 DTM_FECHA_VIGENCIA_HASTA,
	 DESC_SIGLA,
	 DESC_NIVEL,
	 DESC_ESTADO_REG,
	 DTM_FECHACARGA 

FROM [ATOMO].[DWH.DIM_ESTRUCTURA_DESPLIEGUE] 