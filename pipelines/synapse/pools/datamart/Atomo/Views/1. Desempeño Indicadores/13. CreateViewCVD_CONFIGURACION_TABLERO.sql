
-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-05-16
-- Description: Se crea la vista CVD_CONFIGURACION_TABLERO la cual es un insumo para el tablero Paneles y TBG's

-- Author:      Oscar Angel 
-- Update Date: 2022-11-17
-- Description: Se realiza ajuste en query con la adición del FK_TIEMPO por duplicidad de registros en un cruce posterior.

-- Author:      Cristian Russi 
-- Update Date: 20223-06-16
-- Description: Se realiza ajuste en query para cruce con las fechas de vigencia por duplicidad que existia en el proceso.

-- Author:      Oscar Angel
-- Update Date: 2023-06-28
-- Description: Se adiciona los campo Num_Orden_Palanca y Num_Orden_Objetivo

-- Author:      Maria Alejandra Delgado
-- Update Date: 2023-11-09
-- Description: Se adiciona filtro o join entre el año y la fecha de vigencia inicial para eliminar la duplicidad en los datos.

-- Author:      Oscar Angel 
-- Update Date: 2024-04-17
-- Description: Se adiciona el campo FK_INDICADOR a la salida de la vista

-- =============================================

CREATE VIEW ATOMO.CVD_CONFIGURACION_TABLERO AS 

SELECT A.DESC_ANNIO,
	 LEFT(convert(varchar, A.DTM_FECHA_REGISTRO,23),4) AS DESC_ANNIO_REGISTRO,
	 A.FK_TABLERO,
	 A.FK_TIEMPO,
	 A.FK_INDICADOR,
	 E.DESC_TABLERO,
	 CASE WHEN A.DESC_VERSION IS NULL OR A.DESC_VERSION = '0'
	       THEN '1.0'
		  ELSE A.DESC_VERSION END AS DESC_VERSION,
     B.DESC_GRUPO,
     B.DESC_EMPRESA,
     B.DESC_VP_EJECUTIVA,
     B.DESC_GRUPO_SEGMENTO,
     B.DESC_SEGMENTO,
     B.DESC_UNIDAD_NEGOCIO_NVL_2,
     B.DESC_UNIDAD_NEGOCIO_NVL_3,
     B.DESC_GERENCIA,
     B.DESC_RUTINA,
	 A.DESC_SIGLA_AREA,
     B.DESC_NIVEL,
	 F.DESC_EJE_PALANCA,
	 F.NUM_ORDEN AS NUM_ORDEN_PALANCA,
	 G.NUM_ORDEN AS NUM_ORDEN_OBJETIVO,
	 G.DESC_OBJETIVO,
     C.ID_INDICADOR,
     C.DESC_NOMBRE_INDICADOR,
	 A.FK_PARAM_INDICADOR,
     D.DESC_DETALLE_INDICADOR,
	 A.DESC_HITO_INDICADOR,
     C.DESC_FRECUENCIA,
	 A.VLR_PESO_INDICADOR,
	 A.DESC_TIPO_TABLERO,
	 A.DESC_TBG,
	 A.VLR_LIMITE_INFERIOR,
	 A.VLR_LIMITE_SUPERIOR,
	 A.DESC_SECUENCIA_ORDEN,
	 A.DESC_CORTO_LARGO_PLAZO,
     C.DESC_REFERENTE,
     D.DESC_RESPONSABLE_MEDICION,
     D.DESC_CARGO_RESPONSABLE_MEDICION,
     D.DESC_CORREO_RESPONSABLE_MEDICION,
     D.DESC_RESPONSABLE_MEDICION_2,
     D.DESC_CARGO_RESPONSABLE_MEDICION_2,
     D.DESC_CORREO_RESPONSABLE_MEDICION_2,
	 A.DTM_FECHACARGA,
	 A.DESC_TABLERO_CVR 

FROM [ATOMO].[DWH.FACT_CONFIGURACION_TABLERO] A
	LEFT JOIN [ATOMO].[DWH.DIM_ESTRUCTURA_DESPLIEGUE] B
		ON A.[DESC_SIGLA_AREA] = B.[DESC_SIGLA] and A.DESC_ANNIO = YEAR(B.DTM_FECHA_VIGENCIA_DESDE) 
	--AND A.[DTM_FECHA_REGISTRO] = B.[DTM_FECHA_VIGENCIA_DESDE]
	LEFT JOIN [ATOMO].[CVD_INDICADOR] C
		ON A.[FK_INDICADOR] = C.[GK_INDICADOR]
	LEFT JOIN [ATOMO].[CVD_PARAMETRIZACION_INDICADOR] D
		ON A.[FK_PARAM_INDICADOR] = D.[GK_PARAM_INDICADOR]
	LEFT JOIN [ATOMO].[CVD_TABLERO] E
		ON A.[FK_TABLERO] = E.[GK_TABLERO]
	LEFT JOIN [ATOMO].[DWH.DIM_EJE_PALANCA] F
		ON A.[FK_EJE_PALANCA] = F.[GK_EJE_PALANCA]
		AND A.[DTM_FECHA_REGISTRO] = F.[DTM_FECHA_INI_VIGENCIA_PALANCA]
	LEFT JOIN [ATOMO].[DWH.DIM_OBJETIVO] G
		ON A.[FK_OBJETIVO] = G.[GK_OBJETIVO]
		AND A.[DTM_FECHA_REGISTRO] = G.[DTM_FECHA_INI_VIGENCIA_OBJETIVO]