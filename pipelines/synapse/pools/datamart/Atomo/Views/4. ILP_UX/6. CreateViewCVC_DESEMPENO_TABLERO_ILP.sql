-- =============================================
-- Author:      Harold Lopez - Santiago Guzman
-- Create Date: 2022-08-18
-- Description: Se crea la vista CVC_DESEMPENO_TABLERO_ILP la cual es un insumo para la iniciativba de ILP

-- Author:      Oscar Angel 
-- Update Date: 2022-11-11
-- Description: Se realiza ajuste en query por limpieza de campos

-- Author:      Juan Benavides 
-- Update Date: 2022-12-16
-- Description: Se realiza ajuste en query para incluir campos de proyeccion.

-- Author:      Oscar Fabian Angel 
-- Update Date: 2023-03-15
-- Description: Se realiza ajuste para la adicion del campo Plan Acum Periodos

-- Author:      Alejandro Vargas
-- Update Date: 2023-04-11
-- Description: Se realiza modificacion de los campos % Avance ILP Año 1 y % Avance ILP Años 1 2

-- Author:      Oscar Fabian Angel 
-- Update Date: 2023-10-06
-- Description: Se realiza ajustes para inclusion de los campos ACTIVOCUMPLIMIENTOMIN, CUMPLIMIENTOMINIMO, RECONOCIMIENTOMINIMO
-- =============================================

CREATE VIEW [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS 
SELECT A.DESC_ANNIO,
       A.FK_TABLERO,
       A.DESC_TABLERO,
       A.VIGENCIA_TABLERO_DESDE,
       A.VIGENCIA_TABLERO_HASTA,
       A.DESC_VERSION,
       A.DESC_GRUPO,
       A.DESC_EMPRESA,
       A.DESC_VP_EJECUTIVA,
       A.DESC_GRUPO_SEGMENTO,
       A.DESC_SEGMENTO,
       A.DESC_GERENCIA,
       A.DESC_RUTINA,
       A.DESC_SIGLA_AREA,
       A.DESC_NIVEL,
       A.DESC_EJE_PALANCA,
       A.DESC_OBJETIVO,
       A.ID_INDICADOR,
       A.DESC_NOMBRE_INDICADOR,
       A.FK_PARAM_INDICADOR,
       A.DESC_DETALLE_INDICADOR,
       A.DESC_HITO_INDICADOR,
       A.DESC_FRECUENCIA,
       A.VLR_PESO_INDICADOR,
       A.DESC_TIPO_TABLERO,
       A.DESC_SECUENCIA_ORDEN,
       A.DESC_CORTO_LARGO_PLAZO,
       A.DESC_REFERENTE,
       A.DESC_RESPONSABLE_MEDICION,
       A.DESC_CARGO_RESPONSABLE_MEDICION,
       A.DESC_CORREO_RESPONSABLE_MEDICION,
       A.DESC_RESPONSABLE_MEDICION_2,
       A.DESC_CARGO_RESPONSABLE_MEDICION_2,
       A.DESC_CORREO_RESPONSABLE_MEDICION_2,
       A.DTM_FECHACARGA,
       A.DESC_HITO_INDIC_HABILITADOR,
	   A.ACTIVOCUMPLIMIENTOMIN,
	   A.CUMPLIMIENTOMINIMO,
	   A.RECONOCIMIENTOMINIMO,
       A.DESC_UNIDAD_NEGOCIO_NVL_2,        
       A.DESC_UNIDAD_NEGOCIO_NVL_3,  
       A.FK_INDICADOR,
       A.FK_PERIODO,
       A.DESC_PERIODO,
       A."PLAN ACUM PERIODOS",
       A."PERIODO AÑO",
       A.DESC_PREMISAS,
       A.DESC_MENSAJE_CLAVE_INDICADOR,
       A.DESC_SENTIDO,
       A."Valor Meta Normalizada Año 1",
       A."Valor Meta Normalizada Año 2",
       A."Valor Meta Normalizada Año 3",
       A."Valor Meta Normalizada Años 1 2",
       A."Valor Meta Normalizada Años 1 2 3",
       A."Valor Real Año 1",
       A."Valor Real Año 2",
       A."Valor Real Año 3",
       A."Valor Real Años 1 2",
       A."Valor Real Años 1 2 3",
       A."Valor Real Acumulado",
       A."Valor Real Acumulado_Mes",
       A."Valor Plan Acumulado",
       A."Valor Plan Acumulado Normalizada",
       A."Valor Meta Año 1",
       A."Valor Meta Año 2",
       A."Valor Meta Año 3",
       A."Valor Meta Años 1 2",
       A."Valor Meta Años 1 2 3",
       A."Valor Reto    ",
       A."Valor Proyección Año 1",
       A."Valor Proyección Año 2",
       A."Valor Proyección Año 3",
       A."Valor Proyección Años 1 2",
       A."Valor Proyección Años 1 2 3",
       A."% Avance Acumulado ILP",
       /*A."% Avance ILP Años 1 2",
       A."% Avance ILP Año 1",*/
       A."% Cumplimiento Acumulado",
       A."Valor Real Proyectado Año 1",   
       A."Valor Real Proyectado Año 2",
       A."Valor Real Proyectado Año 3",  
       A."Valor Real Proyectado Años 1 2",
       A."Valor Real Proyectado Años 1 2 3",
       A.FECHA_CARGA_SYNAPSE,        
       A.FECHA_PROXIMA_ACTUALIZA_SYNAPSE,
       A.CANT_DECIMALES_REPORTE,
       A.CANT_DECIMALES_CALCULO,

/*Case % Cumplimiento Año 1*/
					 CASE WHEN A."Valor Real Proyectado Año 1" IS NULL 
					THEN NULL 
				 WHEN UPPER(A."DESC_SENTIDO") = 'POSITIVO' AND (ISNULL(A."VLR_META_NORM_ANNIO_1",A."VLR_META_ANNIO_1")<0 ) 
					THEN ((ISNULL(A."VLR_META_NORM_ANNIO_1",A."VLR_META_ANNIO_1")- A."Valor Real Proyectado Año 1") / ISNULL(A."VLR_META_NORM_ANNIO_1",A."VLR_META_ANNIO_1")) + 1 
				 WHEN ((A."VLR_META_ANNIO_1" = 0 AND A."VLR_META_NORM_ANNIO_1" = 0) OR (A."VLR_META_ANNIO_1" IS NULL AND A."VLR_META_NORM_ANNIO_1" = 0) OR (A."VLR_META_ANNIO_1" = 0 AND A."VLR_META_NORM_ANNIO_1" IS NULL)) AND A."Valor Real Proyectado Año 1" = 0 
					THEN 1 
				 WHEN (A."VLR_META_ANNIO_1" = 0 AND A."Valor Real Proyectado Año 1" = 0 AND (A."VLR_META_NORM_ANNIO_1" IS NULL OR A."VLR_META_NORM_ANNIO_1" = 0 )) OR (A."VLR_META_NORM_ANNIO_1" = 0 AND A."Valor Real Proyectado Año 1" = 0)
					THEN 1
                 WHEN (UPPER(A."DESC_SENTIDO") = 'NEGATIVO' AND ((A."VLR_META_ANNIO_1" = 0 AND A."VLR_META_NORM_ANNIO_1" = 0) OR (A."VLR_META_ANNIO_1" IS NULL AND 
							A."VLR_META_NORM_ANNIO_1" = 0) OR (A."VLR_META_ANNIO_1" = 0 AND A."VLR_META_NORM_ANNIO_1" IS NULL) OR (ISNULL(A."VLR_META_NORM_ANNIO_1",A."VLR_META_ANNIO_1")=0)) AND A."Valor Real Proyectado Año 1" > 0) OR (UPPER(A."DESC_SENTIDO") = 'POSITIVO' AND ((A."VLR_META_ANNIO_1" = 0 AND A."VLR_META_NORM_ANNIO_1" = 0) OR (A."VLR_META_ANNIO_1" IS NULL AND A."VLR_META_NORM_ANNIO_1" = 0) OR (A."VLR_META_ANNIO_1" = 0 AND A."VLR_META_NORM_ANNIO_1" IS NULL) OR (ISNULL(A."VLR_META_NORM_ANNIO_1",A."VLR_META_ANNIO_1")=0)) AND A."Valor Real Proyectado Año 1" < 0) 
					THEN 0 
				 WHEN (UPPER(A."DESC_SENTIDO") = 'NEGATIVO' AND ((A."VLR_META_ANNIO_1" = 0 AND A."VLR_META_NORM_ANNIO_1" = 0) OR (A."VLR_META_ANNIO_1" IS NULL AND A."VLR_META_NORM_ANNIO_1" = 0) 	  OR (A."VLR_META_ANNIO_1" = 0 AND A."VLR_META_NORM_ANNIO_1" IS NULL) OR (ISNULL(A."VLR_META_NORM_ANNIO_1",A."VLR_META_ANNIO_1")=0)) AND A."Valor Real Proyectado Año 1" < 0) 
						OR (UPPER(A."DESC_SENTIDO") = 'POSITIVO' AND ((A."VLR_META_ANNIO_1" = 0 AND A."VLR_META_NORM_ANNIO_1" = 0) OR (A."VLR_META_ANNIO_1" IS NULL AND 
						A."VLR_META_NORM_ANNIO_1" = 0) OR (A."VLR_META_ANNIO_1" = 0 AND A."VLR_META_NORM_ANNIO_1" IS NULL) OR (ISNULL(A."VLR_META_NORM_ANNIO_1",A."VLR_META_ANNIO_1")=0)) 
						AND A."Valor Real Proyectado Año 1" > 0) 
					THEN 1 
				 WHEN (A."DESC_SENTIDO" = 'Negativo' OR A."VLR_META_ANNIO_1" < 0) AND A.DESC_META_NORMALIZADA = 'No' 
					THEN CASE WHEN A."VLR_META_ANNIO_1" = 0 
								 THEN 0 
							  ELSE ((A."VLR_META_ANNIO_1" - A."Valor Real Proyectado Año 1") / A."VLR_META_ANNIO_1") + 1 END 
				 WHEN (A."DESC_SENTIDO" = 'Negativo' OR A."VLR_META_NORM_ANNIO_1" < 0) AND A.DESC_META_NORMALIZADA = 'Si' 
					THEN CASE WHEN A."VLR_META_NORM_ANNIO_1" = 0 
								THEN 0 
							  ELSE CASE WHEN A."VLR_META_NORM_ANNIO_1" IS NULL AND A."VLR_META_ANNIO_1" <> 0 
										   THEN ((A."VLR_META_ANNIO_1"-A."Valor Real Proyectado Año 1") / A."VLR_META_ANNIO_1") + 1 
										ELSE ((A."VLR_META_NORM_ANNIO_1"-A."Valor Real Proyectado Año 1") / A."VLR_META_NORM_ANNIO_1") + 1 
									END 
						 END 
                 WHEN A.DESC_META_NORMALIZADA = 'No' 
					THEN CASE WHEN A."VLR_META_ANNIO_1" = 0 
								 THEN 0 
						 ELSE (A."Valor Real Proyectado Año 1" / A."VLR_META_ANNIO_1") END
				 WHEN A.DESC_META_NORMALIZADA = 'Si' 
					THEN CASE WHEN A."VLR_META_NORM_ANNIO_1" = 0 
								 THEN 0 
							  ELSE CASE WHEN A."VLR_META_NORM_ANNIO_1" IS NULL AND A."VLR_META_ANNIO_1" <> 0 
										   THEN (A."Valor Real Proyectado Año 1" / A."VLR_META_ANNIO_1") 
										ELSE CASE WHEN A."VLR_META_NORM_ANNIO_1" = 0 
													THEN 0 
											      ELSE (A."Valor Real Proyectado Año 1" / A."VLR_META_NORM_ANNIO_1") 
											 END 
								   END
                         END 
				 ELSE NULL END AS "% Cumplimiento Año 1",

/*Case % Cumplimiento Año 2*/
			 CASE WHEN A."Valor Real Proyectado Año 2" IS NULL 
					THEN NULL 
				 WHEN UPPER(A."DESC_SENTIDO") = 'POSITIVO' AND (ISNULL(A."VLR_META_NORM_ANNIO_2",A."VLR_META_ANNIO_2")<0 ) 
					THEN ((ISNULL(A."VLR_META_NORM_ANNIO_2",A."VLR_META_ANNIO_2")- A."Valor Real Proyectado Año 2") / ISNULL(A."VLR_META_NORM_ANNIO_2",A."VLR_META_ANNIO_2")) + 1 
				 WHEN ((A."VLR_META_ANNIO_2" = 0 AND A."VLR_META_NORM_ANNIO_2" = 0) OR (A."VLR_META_ANNIO_2" IS NULL AND A."VLR_META_NORM_ANNIO_2" = 0) OR (A."VLR_META_ANNIO_2" = 0 AND A."VLR_META_NORM_ANNIO_2" IS NULL)) AND A."Valor Real Proyectado Año 2" = 0 
					THEN 1 
				 WHEN (A."VLR_META_ANNIO_2" = 0 AND A."Valor Real Proyectado Año 2" = 0 AND (A."VLR_META_NORM_ANNIO_2" IS NULL OR A."VLR_META_NORM_ANNIO_2" = 0 )) OR (A."VLR_META_NORM_ANNIO_2" = 0 AND A."Valor Real Proyectado Año 2" = 0)
					THEN 1
                 WHEN (UPPER(A."DESC_SENTIDO") = 'NEGATIVO' AND ((A."VLR_META_ANNIO_2" = 0 AND A."VLR_META_NORM_ANNIO_2" = 0) OR (A."VLR_META_ANNIO_2" IS NULL AND 
							A."VLR_META_NORM_ANNIO_2" = 0) OR (A."VLR_META_ANNIO_2" = 0 AND A."VLR_META_NORM_ANNIO_2" IS NULL) OR (ISNULL(A."VLR_META_NORM_ANNIO_2",A."VLR_META_ANNIO_2")=0)) AND A."Valor Real Proyectado Año 2" > 0) OR (UPPER(A."DESC_SENTIDO") = 'POSITIVO' AND ((A."VLR_META_ANNIO_2" = 0 AND A."VLR_META_NORM_ANNIO_2" = 0) OR (A."VLR_META_ANNIO_2" IS NULL AND A."VLR_META_NORM_ANNIO_2" = 0) OR (A."VLR_META_ANNIO_2" = 0 AND A."VLR_META_NORM_ANNIO_2" IS NULL) OR (ISNULL(A."VLR_META_NORM_ANNIO_2",A."VLR_META_ANNIO_2")=0)) AND A."Valor Real Proyectado Año 2" < 0) 
					THEN 0 
				 WHEN (UPPER(A."DESC_SENTIDO") = 'NEGATIVO' AND ((A."VLR_META_ANNIO_2" = 0 AND A."VLR_META_NORM_ANNIO_2" = 0) OR (A."VLR_META_ANNIO_2" IS NULL AND A."VLR_META_NORM_ANNIO_2" = 0) 	  OR (A."VLR_META_ANNIO_2" = 0 AND A."VLR_META_NORM_ANNIO_2" IS NULL) OR (ISNULL(A."VLR_META_NORM_ANNIO_2",A."VLR_META_ANNIO_2")=0)) AND A."Valor Real Proyectado Año 2" < 0) 
						OR (UPPER(A."DESC_SENTIDO") = 'POSITIVO' AND ((A."VLR_META_ANNIO_2" = 0 AND A."VLR_META_NORM_ANNIO_2" = 0) OR (A."VLR_META_ANNIO_2" IS NULL AND 
						A."VLR_META_NORM_ANNIO_2" = 0) OR (A."VLR_META_ANNIO_2" = 0 AND A."VLR_META_NORM_ANNIO_2" IS NULL) OR (ISNULL(A."VLR_META_NORM_ANNIO_2",A."VLR_META_ANNIO_2")=0)) 
						AND A."Valor Real Proyectado Año 2" > 0) 
					THEN 1 
				 WHEN (A."DESC_SENTIDO" = 'Negativo' OR A."VLR_META_ANNIO_2" < 0) AND A.DESC_META_NORMALIZADA = 'No' 
					THEN CASE WHEN A."VLR_META_ANNIO_2" = 0 
								 THEN 0 
							  ELSE ((A."VLR_META_ANNIO_2" - A."Valor Real Proyectado Año 2") / A."VLR_META_ANNIO_2") + 1 END 
				 WHEN (A."DESC_SENTIDO" = 'Negativo' OR A."VLR_META_NORM_ANNIO_2" < 0) AND A.DESC_META_NORMALIZADA = 'Si' 
					THEN CASE WHEN A."VLR_META_NORM_ANNIO_2" = 0 
								THEN 0 
							  ELSE CASE WHEN A."VLR_META_NORM_ANNIO_2" IS NULL AND A."VLR_META_ANNIO_2" <> 0 
										   THEN ((A."VLR_META_ANNIO_2"-A."Valor Real Proyectado Año 2") / A."VLR_META_ANNIO_2") + 1 
										ELSE ((A."VLR_META_NORM_ANNIO_2"-A."Valor Real Proyectado Año 2") / A."VLR_META_NORM_ANNIO_2") + 1 
									END 
						 END 
                 WHEN A.DESC_META_NORMALIZADA = 'No' 
					THEN CASE WHEN A."VLR_META_ANNIO_2" = 0 
								 THEN 0 
						 ELSE (A."Valor Real Proyectado Año 2" / A."VLR_META_ANNIO_2") END
				 WHEN A.DESC_META_NORMALIZADA = 'Si' 
					THEN CASE WHEN A."VLR_META_NORM_ANNIO_2" = 0 
								 THEN 0 
							  ELSE CASE WHEN A."VLR_META_NORM_ANNIO_2" IS NULL AND A."VLR_META_ANNIO_2" <> 0 
										   THEN (A."Valor Real Proyectado Año 2" / A."VLR_META_ANNIO_2") 
										ELSE CASE WHEN A."VLR_META_NORM_ANNIO_2" = 0 
													THEN 0 
											      ELSE (A."Valor Real Proyectado Año 2" / A."VLR_META_NORM_ANNIO_2") 
											 END 
								   END
                         END 
				 ELSE NULL END AS "% Cumplimiento Año 2",
				 
/*Case % Cumplimiento Año 3*/
			 CASE WHEN A."Valor Real Proyectado Año 3" IS NULL 
					THEN NULL 
				 WHEN UPPER(A."DESC_SENTIDO") = 'POSITIVO' AND (ISNULL(A."VLR_META_NORM_ANNIO_3",A."VLR_META_ANNIO_3")<0 ) 
					THEN ((ISNULL(A."VLR_META_NORM_ANNIO_3",A."VLR_META_ANNIO_3")- A."Valor Real Proyectado Año 3") / ISNULL(A."VLR_META_NORM_ANNIO_3",A."VLR_META_ANNIO_3")) + 1 
				 WHEN ((A."VLR_META_ANNIO_3" = 0 AND A."VLR_META_NORM_ANNIO_3" = 0) OR (A."VLR_META_ANNIO_3" IS NULL AND A."VLR_META_NORM_ANNIO_3" = 0) OR (A."VLR_META_ANNIO_3" = 0 AND A."VLR_META_NORM_ANNIO_3" IS NULL)) AND A."Valor Real Proyectado Año 3" = 0 
					THEN 1 
				 WHEN (A."VLR_META_ANNIO_3" = 0 AND A."Valor Real Proyectado Año 3" = 0 AND (A."VLR_META_NORM_ANNIO_3" IS NULL OR A."VLR_META_NORM_ANNIO_3" = 0 )) OR (A."VLR_META_NORM_ANNIO_3" = 0 AND A."Valor Real Proyectado Año 3" = 0)
					THEN 1
                 WHEN (UPPER(A."DESC_SENTIDO") = 'NEGATIVO' AND ((A."VLR_META_ANNIO_3" = 0 AND A."VLR_META_NORM_ANNIO_3" = 0) OR (A."VLR_META_ANNIO_3" IS NULL AND 
							A."VLR_META_NORM_ANNIO_3" = 0) OR (A."VLR_META_ANNIO_3" = 0 AND A."VLR_META_NORM_ANNIO_3" IS NULL) OR (ISNULL(A."VLR_META_NORM_ANNIO_3",A."VLR_META_ANNIO_3")=0)) AND A."Valor Real Proyectado Año 3" > 0) OR (UPPER(A."DESC_SENTIDO") = 'POSITIVO' AND ((A."VLR_META_ANNIO_3" = 0 AND A."VLR_META_NORM_ANNIO_3" = 0) OR (A."VLR_META_ANNIO_3" IS NULL AND A."VLR_META_NORM_ANNIO_3" = 0) OR (A."VLR_META_ANNIO_3" = 0 AND A."VLR_META_NORM_ANNIO_3" IS NULL) OR (ISNULL(A."VLR_META_NORM_ANNIO_3",A."VLR_META_ANNIO_3")=0)) AND A."Valor Real Proyectado Año 3" < 0) 
					THEN 0 
				 WHEN (UPPER(A."DESC_SENTIDO") = 'NEGATIVO' AND ((A."VLR_META_ANNIO_3" = 0 AND A."VLR_META_NORM_ANNIO_3" = 0) OR (A."VLR_META_ANNIO_3" IS NULL AND A."VLR_META_NORM_ANNIO_3" = 0) 	  OR (A."VLR_META_ANNIO_3" = 0 AND A."VLR_META_NORM_ANNIO_3" IS NULL) OR (ISNULL(A."VLR_META_NORM_ANNIO_3",A."VLR_META_ANNIO_3")=0)) AND A."Valor Real Proyectado Año 3" < 0) 
						OR (UPPER(A."DESC_SENTIDO") = 'POSITIVO' AND ((A."VLR_META_ANNIO_3" = 0 AND A."VLR_META_NORM_ANNIO_3" = 0) OR (A."VLR_META_ANNIO_3" IS NULL AND 
						A."VLR_META_NORM_ANNIO_3" = 0) OR (A."VLR_META_ANNIO_3" = 0 AND A."VLR_META_NORM_ANNIO_3" IS NULL) OR (ISNULL(A."VLR_META_NORM_ANNIO_3",A."VLR_META_ANNIO_3")=0)) 
						AND A."Valor Real Proyectado Año 3" > 0) 
					THEN 1 
				 WHEN (A."DESC_SENTIDO" = 'Negativo' OR A."VLR_META_ANNIO_3" < 0) AND A.DESC_META_NORMALIZADA = 'No' 
					THEN CASE WHEN A."VLR_META_ANNIO_3" = 0 
								 THEN 0 
							  ELSE ((A."VLR_META_ANNIO_3" - A."Valor Real Proyectado Año 3") / A."VLR_META_ANNIO_3") + 1 END 
				 WHEN (A."DESC_SENTIDO" = 'Negativo' OR A."VLR_META_NORM_ANNIO_3" < 0) AND A.DESC_META_NORMALIZADA = 'Si' 
					THEN CASE WHEN A."VLR_META_NORM_ANNIO_3" = 0 
								THEN 0 
							  ELSE CASE WHEN A."VLR_META_NORM_ANNIO_3" IS NULL AND A."VLR_META_ANNIO_3" <> 0 
										   THEN ((A."VLR_META_ANNIO_3"-A."Valor Real Proyectado Año 3") / A."VLR_META_ANNIO_3") + 1 
										ELSE ((A."VLR_META_NORM_ANNIO_3"-A."Valor Real Proyectado Año 3") / A."VLR_META_NORM_ANNIO_3") + 1 
									END 
						 END 
                 WHEN A.DESC_META_NORMALIZADA = 'No' 
					THEN CASE WHEN A."VLR_META_ANNIO_3" = 0 
								 THEN 0 
						 ELSE (A."Valor Real Proyectado Año 3" / A."VLR_META_ANNIO_3") END
				 WHEN A.DESC_META_NORMALIZADA = 'Si' 
					THEN CASE WHEN A."VLR_META_NORM_ANNIO_3" = 0 
								 THEN 0 
							  ELSE CASE WHEN A."VLR_META_NORM_ANNIO_3" IS NULL AND A."VLR_META_ANNIO_3" <> 0 
										   THEN (A."Valor Real Proyectado Año 3" / A."VLR_META_ANNIO_3") 
										ELSE CASE WHEN A."VLR_META_NORM_ANNIO_3" = 0 
													THEN 0 
											      ELSE (A."Valor Real Proyectado Año 3" / A."VLR_META_NORM_ANNIO_3") 
											 END 
								   END
                         END 
				 ELSE NULL END AS "% Cumplimiento Año 3",

/*Case % Cumplimiento Año 12*/
			 CASE WHEN A."Valor Real Proyectado Años 1 2" IS NULL 
					THEN NULL 
				 WHEN UPPER(A."DESC_SENTIDO") = 'POSITIVO' AND (ISNULL(A."VLR_META_NORM_ANNIO_12",A."VLR_META_ANNIO_12")<0 ) 
					THEN ((ISNULL(A."VLR_META_NORM_ANNIO_12",A."VLR_META_ANNIO_12")- A."Valor Real Proyectado Años 1 2") / ISNULL(A."VLR_META_NORM_ANNIO_12",A."VLR_META_ANNIO_12")) + 1 
				 WHEN ((A."VLR_META_ANNIO_12" = 0 AND A."VLR_META_NORM_ANNIO_12" = 0) OR (A."VLR_META_ANNIO_12" IS NULL AND A."VLR_META_NORM_ANNIO_12" = 0) OR (A."VLR_META_ANNIO_12" = 0 AND A."VLR_META_NORM_ANNIO_12" IS NULL)) AND A."Valor Real Proyectado Años 1 2" = 0 
					THEN 1 
				 WHEN (A."VLR_META_ANNIO_12" = 0 AND A."Valor Real Proyectado Años 1 2" = 0 AND (A."VLR_META_NORM_ANNIO_12" IS NULL OR A."VLR_META_NORM_ANNIO_12" = 0 )) OR (A."VLR_META_NORM_ANNIO_12" = 0 AND A."Valor Real Proyectado Años 1 2" = 0)
					THEN 1
                 WHEN (UPPER(A."DESC_SENTIDO") = 'NEGATIVO' AND ((A."VLR_META_ANNIO_12" = 0 AND A."VLR_META_NORM_ANNIO_12" = 0) OR (A."VLR_META_ANNIO_12" IS NULL AND 
							A."VLR_META_NORM_ANNIO_12" = 0) OR (A."VLR_META_ANNIO_12" = 0 AND A."VLR_META_NORM_ANNIO_12" IS NULL) OR (ISNULL(A."VLR_META_NORM_ANNIO_12",A."VLR_META_ANNIO_12")=0)) AND A."Valor Real Proyectado Años 1 2" > 0) OR (UPPER(A."DESC_SENTIDO") = 'POSITIVO' AND ((A."VLR_META_ANNIO_12" = 0 AND A."VLR_META_NORM_ANNIO_12" = 0) OR (A."VLR_META_ANNIO_12" IS NULL AND A."VLR_META_NORM_ANNIO_12" = 0) OR (A."VLR_META_ANNIO_12" = 0 AND A."VLR_META_NORM_ANNIO_12" IS NULL) OR (ISNULL(A."VLR_META_NORM_ANNIO_12",A."VLR_META_ANNIO_12")=0)) AND A."Valor Real Proyectado Años 1 2" < 0) 
					THEN 0 
				 WHEN (UPPER(A."DESC_SENTIDO") = 'NEGATIVO' AND ((A."VLR_META_ANNIO_12" = 0 AND A."VLR_META_NORM_ANNIO_12" = 0) OR (A."VLR_META_ANNIO_12" IS NULL AND A."VLR_META_NORM_ANNIO_12" = 0) 	  OR (A."VLR_META_ANNIO_12" = 0 AND A."VLR_META_NORM_ANNIO_12" IS NULL) OR (ISNULL(A."VLR_META_NORM_ANNIO_12",A."VLR_META_ANNIO_12")=0)) AND A."Valor Real Proyectado Años 1 2" < 0) 
						OR (UPPER(A."DESC_SENTIDO") = 'POSITIVO' AND ((A."VLR_META_ANNIO_12" = 0 AND A."VLR_META_NORM_ANNIO_12" = 0) OR (A."VLR_META_ANNIO_12" IS NULL AND 
						A."VLR_META_NORM_ANNIO_12" = 0) OR (A."VLR_META_ANNIO_12" = 0 AND A."VLR_META_NORM_ANNIO_12" IS NULL) OR (ISNULL(A."VLR_META_NORM_ANNIO_12",A."VLR_META_ANNIO_12")=0)) 
						AND A."Valor Real Proyectado Años 1 2" > 0) 
					THEN 1 
				 WHEN (A."DESC_SENTIDO" = 'Negativo' OR A."VLR_META_ANNIO_12" < 0) AND A.DESC_META_NORMALIZADA = 'No' 
					THEN CASE WHEN A."VLR_META_ANNIO_12" = 0 
								 THEN 0 
							  ELSE ((A."VLR_META_ANNIO_12" - A."Valor Real Proyectado Años 1 2") / A."VLR_META_ANNIO_12") + 1 END 
				 WHEN (A."DESC_SENTIDO" = 'Negativo' OR A."VLR_META_NORM_ANNIO_12" < 0) AND A.DESC_META_NORMALIZADA = 'Si' 
					THEN CASE WHEN A."VLR_META_NORM_ANNIO_12" = 0 
								THEN 0 
							  ELSE CASE WHEN A."VLR_META_NORM_ANNIO_12" IS NULL AND A."VLR_META_ANNIO_12" <> 0 
										   THEN ((A."VLR_META_ANNIO_12"-A."Valor Real Proyectado Años 1 2") / A."VLR_META_ANNIO_12") + 1 
										ELSE ((A."VLR_META_NORM_ANNIO_12"-A."Valor Real Proyectado Años 1 2") / A."VLR_META_NORM_ANNIO_12") + 1 
									END 
						 END 
                 WHEN A.DESC_META_NORMALIZADA = 'No' 
					THEN CASE WHEN A."VLR_META_ANNIO_12" = 0 
								 THEN 0 
						 ELSE (A."Valor Real Proyectado Años 1 2" / A."VLR_META_ANNIO_12") END
				 WHEN A.DESC_META_NORMALIZADA = 'Si' 
					THEN CASE WHEN A."VLR_META_NORM_ANNIO_12" = 0 
								 THEN 0 
							  ELSE CASE WHEN A."VLR_META_NORM_ANNIO_12" IS NULL AND A."VLR_META_ANNIO_12" <> 0 
										   THEN (A."Valor Real Proyectado Años 1 2" / A."VLR_META_ANNIO_12") 
										ELSE CASE WHEN A."VLR_META_NORM_ANNIO_12" = 0 
													THEN 0 
											      ELSE (A."Valor Real Proyectado Años 1 2" / A."VLR_META_NORM_ANNIO_12") 
											 END 
								   END
                         END 
				 ELSE NULL END AS "% Cumplimiento Años 1 2",

/*Case % Cumplimiento Año 123*/
			 CASE WHEN A."Valor Real Proyectado Años 1 2 3" IS NULL 
					THEN NULL 
				 WHEN UPPER(A."DESC_SENTIDO") = 'POSITIVO' AND (ISNULL(A."VLR_META_NORM_ANNIO_123",A."VLR_META_ANNIO_123")<0 ) 
					THEN ((ISNULL(A."VLR_META_NORM_ANNIO_123",A."VLR_META_ANNIO_123")- A."Valor Real Proyectado Años 1 2 3") / ISNULL(A."VLR_META_NORM_ANNIO_123",A."VLR_META_ANNIO_123")) + 1 
				 WHEN ((A."VLR_META_ANNIO_123" = 0 AND A."VLR_META_NORM_ANNIO_123" = 0) OR (A."VLR_META_ANNIO_123" IS NULL AND A."VLR_META_NORM_ANNIO_123" = 0) OR (A."VLR_META_ANNIO_123" = 0 AND A."VLR_META_NORM_ANNIO_123" IS NULL)) AND A."Valor Real Proyectado Años 1 2 3" = 0 
					THEN 1 
				 WHEN (A."VLR_META_ANNIO_123" = 0 AND A."Valor Real Proyectado Años 1 2 3" = 0 AND (A."VLR_META_NORM_ANNIO_123" IS NULL OR A."VLR_META_NORM_ANNIO_123" = 0 )) OR (A."VLR_META_NORM_ANNIO_123" = 0 AND A."Valor Real Proyectado Años 1 2 3" = 0)
					THEN 1
                 WHEN (UPPER(A."DESC_SENTIDO") = 'NEGATIVO' AND ((A."VLR_META_ANNIO_123" = 0 AND A."VLR_META_NORM_ANNIO_123" = 0) OR (A."VLR_META_ANNIO_123" IS NULL AND 
							A."VLR_META_NORM_ANNIO_123" = 0) OR (A."VLR_META_ANNIO_123" = 0 AND A."VLR_META_NORM_ANNIO_123" IS NULL) OR (ISNULL(A."VLR_META_NORM_ANNIO_123",A."VLR_META_ANNIO_123")=0)) AND A."Valor Real Proyectado Años 1 2 3" > 0) OR (UPPER(A."DESC_SENTIDO") = 'POSITIVO' AND ((A."VLR_META_ANNIO_123" = 0 AND A."VLR_META_NORM_ANNIO_123" = 0) OR (A."VLR_META_ANNIO_123" IS NULL AND A."VLR_META_NORM_ANNIO_123" = 0) OR (A."VLR_META_ANNIO_123" = 0 AND A."VLR_META_NORM_ANNIO_123" IS NULL) OR (ISNULL(A."VLR_META_NORM_ANNIO_123",A."VLR_META_ANNIO_123")=0)) AND A."Valor Real Proyectado Años 1 2 3" < 0) 
					THEN 0 
				 WHEN (UPPER(A."DESC_SENTIDO") = 'NEGATIVO' AND ((A."VLR_META_ANNIO_123" = 0 AND A."VLR_META_NORM_ANNIO_123" = 0) OR (A."VLR_META_ANNIO_123" IS NULL AND A."VLR_META_NORM_ANNIO_123" = 0) 	  OR (A."VLR_META_ANNIO_123" = 0 AND A."VLR_META_NORM_ANNIO_123" IS NULL) OR (ISNULL(A."VLR_META_NORM_ANNIO_123",A."VLR_META_ANNIO_123")=0)) AND A."Valor Real Proyectado Años 1 2 3" < 0) 
						OR (UPPER(A."DESC_SENTIDO") = 'POSITIVO' AND ((A."VLR_META_ANNIO_123" = 0 AND A."VLR_META_NORM_ANNIO_123" = 0) OR (A."VLR_META_ANNIO_123" IS NULL AND 
						A."VLR_META_NORM_ANNIO_123" = 0) OR (A."VLR_META_ANNIO_123" = 0 AND A."VLR_META_NORM_ANNIO_123" IS NULL) OR (ISNULL(A."VLR_META_NORM_ANNIO_123",A."VLR_META_ANNIO_123")=0)) 
						AND A."Valor Real Proyectado Años 1 2 3" > 0) 
					THEN 1 
				 WHEN (A."DESC_SENTIDO" = 'Negativo' OR A."VLR_META_ANNIO_123" < 0) AND A.DESC_META_NORMALIZADA = 'No' 
					THEN CASE WHEN A."VLR_META_ANNIO_123" = 0 
								 THEN 0 
							  ELSE ((A."VLR_META_ANNIO_123" - A."Valor Real Proyectado Años 1 2 3") / A."VLR_META_ANNIO_123") + 1 END 
				 WHEN (A."DESC_SENTIDO" = 'Negativo' OR A."VLR_META_NORM_ANNIO_123" < 0) AND A.DESC_META_NORMALIZADA = 'Si' 
					THEN CASE WHEN A."VLR_META_NORM_ANNIO_123" = 0 
								THEN 0 
							  ELSE CASE WHEN A."VLR_META_NORM_ANNIO_123" IS NULL AND A."VLR_META_ANNIO_123" <> 0 
										   THEN ((A."VLR_META_ANNIO_123"-A."Valor Real Proyectado Años 1 2 3") / A."VLR_META_ANNIO_123") + 1 
										ELSE ((A."VLR_META_NORM_ANNIO_123"-A."Valor Real Proyectado Años 1 2 3") / A."VLR_META_NORM_ANNIO_123") + 1 
									END 
						 END 
                 WHEN A.DESC_META_NORMALIZADA = 'No' 
					THEN CASE WHEN A."VLR_META_ANNIO_123" = 0 
								 THEN 0 
						 ELSE (A."Valor Real Proyectado Años 1 2 3" / A."VLR_META_ANNIO_123") END
				 WHEN A.DESC_META_NORMALIZADA = 'Si' 
					THEN CASE WHEN A."VLR_META_NORM_ANNIO_123" = 0 
								 THEN 0 
							  ELSE CASE WHEN A."VLR_META_NORM_ANNIO_123" IS NULL AND A."VLR_META_ANNIO_123" <> 0 
										   THEN (A."Valor Real Proyectado Años 1 2 3" / A."VLR_META_ANNIO_123") 
										ELSE CASE WHEN A."VLR_META_NORM_ANNIO_123" = 0 
													THEN 0 
											      ELSE (A."Valor Real Proyectado Años 1 2 3" / A."VLR_META_NORM_ANNIO_123") 
											 END 
								   END
                         END 
				 ELSE NULL END AS "% Cumplimiento Años 1 2 3",

/* Avan ILP*/
			 CASE WHEN A."Valor Real Proyectado Año 1" IS NULL
					THEN NULL 
					WHEN (COALESCE(A."Valor Meta Normalizada Años 1 2 3",A."Valor Meta Años 1 2 3") = 0 OR COALESCE(A."Valor Meta Normalizada Años 1 2 3",A."Valor Meta Años 1 2 3") IS NULL) AND A."Valor Real Proyectado Año 1" <> 0
					THEN CASE WHEN UPPER(A."DESC_SENTIDO") = 'POSITIVO' AND A."Valor Real Proyectado Año 1" > 0
								THEN 1
								WHEN UPPER(A."DESC_SENTIDO") = 'POSITIVO' AND A."Valor Real Proyectado Año 1" < 0
								THEN 0
								WHEN UPPER(A."DESC_SENTIDO") = 'NEGATIVO' AND A."Valor Real Proyectado Año 1" < 0
								THEN 1
								WHEN UPPER(A."DESC_SENTIDO") = 'NEGATIVO' AND A."Valor Real Proyectado Año 1" > 0
								THEN 0
								ELSE NULL END
					WHEN (COALESCE(A."Valor Meta Normalizada Años 1 2 3",A."Valor Meta Años 1 2 3") = 0) AND A."Valor Real Proyectado Año 1" = 0 
						THEN 1
					WHEN UPPER(DESC_SENTIDO) = 'NEGATIVO' THEN ((COALESCE(A."Valor Meta Normalizada Años 1 2 3",A."Valor Meta Años 1 2 3")-A."Valor Real Proyectado Año 1")/(COALESCE(A."Valor Meta Normalizada Años 1 2 3",A."Valor Meta Años 1 2 3")))+1
				ELSE (A."Valor Real Proyectado Año 1" / COALESCE(A."Valor Meta Normalizada Años 1 2 3",A."Valor Meta Años 1 2 3")) 
				END AS "% Avance ILP Año 1",
				
			 CASE WHEN A."Valor Real Proyectado Años 1 2" IS NULL
					THEN NULL 
					WHEN (COALESCE(A."Valor Meta Normalizada Años 1 2 3",A."Valor Meta Años 1 2 3") = 0 OR COALESCE(A."Valor Meta Normalizada Años 1 2 3",A."Valor Meta Años 1 2 3") IS NULL) AND A."Valor Real Proyectado Años 1 2" <> 0
					THEN CASE WHEN UPPER(A."DESC_SENTIDO") = 'POSITIVO' AND A."Valor Real Proyectado Años 1 2" > 0
								THEN 1
								WHEN UPPER(A."DESC_SENTIDO") = 'POSITIVO' AND A."Valor Real Proyectado Años 1 2" < 0
								THEN 0
								WHEN UPPER(A."DESC_SENTIDO") = 'NEGATIVO' AND A."Valor Real Proyectado Años 1 2" < 0
								THEN 1
								WHEN UPPER(A."DESC_SENTIDO") = 'NEGATIVO' AND A."Valor Real Proyectado Años 1 2" > 0
								THEN 0
								ELSE NULL END
					WHEN (COALESCE(A."Valor Meta Normalizada Años 1 2 3",A."Valor Meta Años 1 2 3") = 0) AND A."Valor Real Proyectado Años 1 2" = 0 
						THEN 1
					WHEN UPPER(DESC_SENTIDO) = 'NEGATIVO' THEN ((COALESCE(A."Valor Meta Normalizada Años 1 2 3",A."Valor Meta Años 1 2 3")-A."Valor Real Proyectado Años 1 2")/(COALESCE(A."Valor Meta Normalizada Años 1 2 3",A."Valor Meta Años 1 2 3")))+1
				ELSE (A."Valor Real Proyectado Años 1 2" / COALESCE(A."Valor Meta Normalizada Años 1 2 3",A."Valor Meta Años 1 2 3")) 
				END AS "% Avance ILP Años 1 2"
FROM (
	SELECT *,
				CASE WHEN B.DESC_ANNIO =  CONVERT(VARCHAR(4), B.VIGENCIA_TABLERO_DESDE, 111) AND SUBSTRING(B.FK_PERIODO,5,2) BETWEEN '01' AND '11'
						 THEN SUM(B.[Valor Proyección Año 1])
					   ELSE SUM(B.[Valor Real Año 1]) END AS "Valor Real Proyectado Año 1",   

				  CASE WHEN B.DESC_ANNIO < CONVERT(VARCHAR(4), DATEADD(year, 1, B.VIGENCIA_TABLERO_DESDE), 111)  
						 THEN SUM(B.[Valor Proyección Año 2])
					   WHEN B.DESC_ANNIO = CONVERT(VARCHAR(4), DATEADD(year, 1, B.VIGENCIA_TABLERO_DESDE), 111) AND SUBSTRING(B.FK_PERIODO,5,2) BETWEEN '01' AND '11'
						 THEN SUM(B.[Valor Proyección Año 2])
					   ELSE SUM(B.[Valor Real Año 2]) END AS "Valor Real Proyectado Año 2",

				  CASE WHEN B.DESC_ANNIO = B.VIGENCIA_TABLERO_HASTA AND SUBSTRING(B.FK_PERIODO,5,2) = '12'
						 THEN SUM(B.[Valor Real Año 3])
					   ELSE SUM(B.[Valor Proyección Año 3]) END "Valor Real Proyectado Año 3",  
			
				  CASE WHEN B.DESC_ANNIO < CONVERT(VARCHAR(4), DATEADD(year, 1, B.VIGENCIA_TABLERO_DESDE), 111)  
						 THEN SUM(B.[Valor Proyección Años 1 2])
					   WHEN B.DESC_ANNIO = CONVERT(VARCHAR(4), DATEADD(year, 1, B.VIGENCIA_TABLERO_DESDE), 111) AND SUBSTRING(B.FK_PERIODO,5,2) BETWEEN '01' AND '11'
						 THEN SUM(B.[Valor Proyección Años 1 2])
					   ELSE SUM(B.[Valor Real Años 1 2]) END "Valor Real Proyectado Años 1 2",

				  CASE WHEN B.DESC_ANNIO = B.VIGENCIA_TABLERO_HASTA AND SUBSTRING(B.FK_PERIODO,5,2) = '12'
						 THEN SUM(B.[Valor Real Años 1 2 3])
					   ELSE SUM(B.[Valor Proyección Años 1 2 3]) END AS "Valor Real Proyectado Años 1 2 3"
	FROM (
	SELECT A.DESC_ANNIO,
				  A.FK_TABLERO,
				  A.DESC_TABLERO,
				  A.VIGENCIA_TABLERO_DESDE,
				  A.VIGENCIA_TABLERO_HASTA,
				  A.DESC_VERSION,
				  A.DESC_GRUPO,
				  A.DESC_EMPRESA,
				  A.DESC_VP_EJECUTIVA,
				  A.DESC_GRUPO_SEGMENTO,
				  A.DESC_SEGMENTO,
				  A.DESC_GERENCIA,
				  A.DESC_RUTINA,
				  A.DESC_SIGLA_AREA,
				  A.DESC_NIVEL,
				  A.DESC_EJE_PALANCA,
				  A.DESC_OBJETIVO,
				  A.ID_INDICADOR,
				  A.DESC_NOMBRE_INDICADOR,
				  A.FK_PARAM_INDICADOR,
				  A.DESC_DETALLE_INDICADOR,
				  A.DESC_HITO_INDICADOR,
				  A.DESC_FRECUENCIA,
				  A.VLR_PESO_INDICADOR,
				  A.DESC_TIPO_TABLERO,
				  A.DESC_SECUENCIA_ORDEN,
				  A.DESC_CORTO_LARGO_PLAZO,
				  A.DESC_REFERENTE,
				  A.DESC_RESPONSABLE_MEDICION,
				  A.DESC_CARGO_RESPONSABLE_MEDICION,
				  A.DESC_CORREO_RESPONSABLE_MEDICION,
				  A.DESC_RESPONSABLE_MEDICION_2,
				  A.DESC_CARGO_RESPONSABLE_MEDICION_2,
				  A.DESC_CORREO_RESPONSABLE_MEDICION_2,
				  A.DTM_FECHACARGA,
				  A.DESC_HITO_INDIC_HABILITADOR,
				  A.ACTIVOCUMPLIMIENTOMIN,
				  A.CUMPLIMIENTOMINIMO,
				  A.RECONOCIMIENTOMINIMO,
				  A.DESC_UNIDAD_NEGOCIO_NVL_2,        
				  A.DESC_UNIDAD_NEGOCIO_NVL_3,  
				  B.FK_INDICADOR,
				  B.FK_PERIODO,
				  B.DESC_PERIODO,
				  B."PLAN ACUM PERIODOS",
				  B."PERIODO AÑO",
				  B.DESC_PREMISAS,
				  B.DESC_MENSAJE_CLAVE_INDICADOR,
				  B.DESC_SENTIDO,
				  B.DESC_META_NORMALIZADA,
				  sum(B.VLR_META_NORM_ANNIO_1) AS "Valor Meta Normalizada Año 1",
				  sum(B.VLR_META_NORM_ANNIO_2) AS "Valor Meta Normalizada Año 2",
				  sum(B.VLR_META_NORM_ANNIO_3) AS "Valor Meta Normalizada Año 3",
				  sum(B.VLR_META_NORM_ANNIO_12) AS "Valor Meta Normalizada Años 1 2",
				  sum(B.VLR_META_NORM_ANNIO_123) AS "Valor Meta Normalizada Años 1 2 3",
				  /*sum(B.VLR_REAL_ANNIO_1) AS "Valor Real Año 1",
				  sum(B.VLR_REAL_ANNIO_2) AS "Valor Real Año 2",
				  sum(B.VLR_REAL_ANNIO_3) AS "Valor Real Año 3",
				  sum(B.VLR_REAL_ANNIO_12) AS "Valor Real Años 1 2",
				  sum(B.VLR_REAL_ANNIO_123) AS "Valor Real Años 1 2 3",
				  */
				  CASE WHEN B.[FK_PERIODO]> concat(year(A.VIGENCIA_TABLERO_DESDE), '12')
					THEN (select [VLR_REAL_ANNIO_1] from [ATOMO].[CVC_DESEMPENO_INDICADOR_ILP] AS ANNO1
						where ANNO1.FK_TABLERO = A.[FK_TABLERO] and FK_PERIODO = concat(year(VIGENCIA_TABLERO_DESDE), '12') and B.[FK_INDICADOR] = ANNO1.[FK_INDICADOR] and A.FK_PARAM_INDICADOR = ANNO1.[FK_PARAM_INDICADOR])
					ELSE sum(B.[VLR_REAL_ANNIO_1]) END AS "Valor Real Año 1",

				CASE WHEN B.[FK_PERIODO]> concat(year(VIGENCIA_TABLERO_DESDE)+1, '12')
					THEN (select [VLR_REAL_ANNIO_2] from [ATOMO].[CVC_DESEMPENO_INDICADOR_ILP] AS ANNO2
						where ANNO2.FK_TABLERO = A.[FK_TABLERO] and FK_PERIODO = concat(year(VIGENCIA_TABLERO_DESDE)+1, '12') and B.[FK_INDICADOR] = ANNO2.[FK_INDICADOR] and A.FK_PARAM_INDICADOR = ANNO2.[FK_PARAM_INDICADOR])
					ELSE sum(B.[VLR_REAL_ANNIO_2]) END AS "Valor Real Año 2",

				  sum(B.VLR_REAL_ANNIO_3) AS "Valor Real Año 3",

				CASE WHEN B.[FK_PERIODO]> concat(year(VIGENCIA_TABLERO_DESDE)+1, '12')
					THEN (select [VLR_REAL_ANNIO_12] from [ATOMO].[CVC_DESEMPENO_INDICADOR_ILP] AS ANNO12
						where ANNO12.FK_TABLERO = A.[FK_TABLERO] and FK_PERIODO = concat(year(VIGENCIA_TABLERO_DESDE)+1, '12') and B.[FK_INDICADOR] = ANNO12.[FK_INDICADOR] and A.FK_PARAM_INDICADOR = ANNO12.[FK_PARAM_INDICADOR])
					ELSE sum(B.[VLR_REAL_ANNIO_12]) END AS "Valor Real Años 1 2",

				  sum(B.VLR_REAL_ANNIO_123) AS "Valor Real Años 1 2 3",
				  sum(B.VLR_REAL_ACUMULADO) AS "Valor Real Acumulado",
				  B.VLR_REAL_ACUMULADO_MES AS "Valor Real Acumulado_Mes",
				  sum(B.VLR_PLAN_ACUMULADO) AS "Valor Plan Acumulado",
				  sum(B.VLR_PLAN_ACUM_NORM) AS "Valor Plan Acumulado Normalizada",
				  sum(B.VLR_META_ANNIO_1) AS "Valor Meta Año 1",
				  sum(B.VLR_META_ANNIO_2) AS "Valor Meta Año 2",
				  sum(B.VLR_META_ANNIO_3) AS "Valor Meta Año 3",
				  sum(B.VLR_META_ANNIO_12) AS "Valor Meta Años 1 2",
				  sum(B.VLR_META_ANNIO_123) AS "Valor Meta Años 1 2 3",
				  sum(B.VLR_RETO) AS "Valor Reto    ",
				  sum(B.VLR_PROYECCION_ANNIO_1) AS "Valor Proyección Año 1",
				  sum(B.VLR_PROYECCION_ANNIO_2) AS "Valor Proyección Año 2",
				  sum(B.VLR_PROYECCION_ANNIO_3) AS "Valor Proyección Año 3",
				  sum(B.VLR_PROYECCION_ANNIO_12) AS "Valor Proyección Años 1 2",
				  sum(B.VLR_PROYECCION_ANNIO_123) AS "Valor Proyección Años 1 2 3",
				  sum(B.PRC_AVAN_ACUM_ILP) AS "% Avance Acumulado ILP",
				  sum(B.PRC_AVAN_ILP_ANNO12) AS "% Avance ILP Años 1 2",
				  sum(B.PRC_AVAN_ILP_ANNO1) AS "% Avance ILP Año 1",
				  sum(B.PRC_CUMP_ACUM) AS "% Cumplimiento Acumulado",

				  B.FECHA_CARGA_SYNAPSE,        
				  B.FECHA_PROXIMA_ACTUALIZA_SYNAPSE,
				  C.CANT_DECIMALES_REPORTE,
				  C.CANT_DECIMALES_CALCULO,
				  B."VLR_REAL_PROY_ANNO1",
				  B."VLR_META_NORM_ANNIO_1",
				  B."VLR_META_ANNIO_1",
				  B."VLR_REAL_PROY_ANNO2",
				  B."VLR_META_NORM_ANNIO_2",
				  B."VLR_META_ANNIO_2",
				  B."VLR_REAL_PROY_ANNO3",
				  B."VLR_META_NORM_ANNIO_3",
				  B."VLR_META_ANNIO_3",
				  B."VLR_REAL_PROY_ANNO12",
				  B."VLR_META_NORM_ANNIO_12",
				  B."VLR_META_ANNIO_12",
				  B."VLR_REAL_PROY_ANNO123",
				  B."VLR_META_NORM_ANNIO_123",
				  B."VLR_META_ANNIO_123"

			FROM [ATOMO].[CVD_CONFIGURACION_TABLERO_ILP] AS A
				INNER JOIN [ATOMO].[CVC_DESEMPENO_INDICADOR_ILP] AS B
					ON A.FK_PARAM_INDICADOR = B.FK_PARAM_INDICADOR
					AND A.DESC_ANNIO = B.DESC_ANNIO
					AND A.FK_TABLERO = B.FK_TABLERO
				LEFT JOIN [ATOMO].[CVD_INDICADOR] AS C
					ON B.FK_INDICADOR = C.GK_INDICADOR

	GROUP BY A.DESC_ANNIO                                ,
			 A.FK_TABLERO                                ,
			 A.DESC_TABLERO                              ,
			 A.VIGENCIA_TABLERO_DESDE					,
			 A.VIGENCIA_TABLERO_HASTA					,
			 A.DESC_VERSION                              ,
			 A.DESC_GRUPO                                ,
			 A.DESC_EMPRESA                              ,
			 A.DESC_VP_EJECUTIVA                         ,
			 A.DESC_GRUPO_SEGMENTO                       ,
			 A.DESC_SEGMENTO                             ,
			 A.DESC_GERENCIA                             ,
			 A.DESC_RUTINA                               ,
			 A.DESC_SIGLA_AREA                           ,
			 A.DESC_NIVEL                                ,
			 A.DESC_EJE_PALANCA                          ,
			 A.DESC_OBJETIVO                             ,
			 A.ID_INDICADOR                              ,
			 A.DESC_NOMBRE_INDICADOR                     ,
			 A.FK_PARAM_INDICADOR                        ,
			 A.DESC_DETALLE_INDICADOR                    ,
			 A.DESC_HITO_INDICADOR                       ,
			 A.DESC_FRECUENCIA                           ,
			 A.VLR_PESO_INDICADOR                        ,
			 A.DESC_TIPO_TABLERO                         ,
			 A.DESC_SECUENCIA_ORDEN                      ,
			 A.DESC_CORTO_LARGO_PLAZO                    ,
			 A.DESC_REFERENTE                            ,
			 A.DESC_RESPONSABLE_MEDICION                 ,
			 A.DESC_CARGO_RESPONSABLE_MEDICION           ,
			 A.DESC_CORREO_RESPONSABLE_MEDICION          ,
			 A.DESC_RESPONSABLE_MEDICION_2               ,
			 A.DESC_CARGO_RESPONSABLE_MEDICION_2         ,
			 A.DESC_CORREO_RESPONSABLE_MEDICION_2        ,
			 A.DTM_FECHACARGA                            ,
			 A.DESC_HITO_INDIC_HABILITADOR               ,
			 A.ACTIVOCUMPLIMIENTOMIN                     ,
			 A.CUMPLIMIENTOMINIMO                        ,
			 A.RECONOCIMIENTOMINIMO                      ,
			 A.DESC_UNIDAD_NEGOCIO_NVL_2                 ,        
			 A.DESC_UNIDAD_NEGOCIO_NVL_3                 ,  
			 B.FK_INDICADOR                              ,
			 B.FK_PERIODO                                ,
			 B.DESC_PERIODO                              ,
			 B."PLAN ACUM PERIODOS"                      ,
			 B."PERIODO AÑO"								,
			 B.VLR_REAL_ACUMULADO_MES					,
			 B.DESC_PREMISAS                             ,
			 B.DESC_MENSAJE_CLAVE_INDICADOR              ,
			 B.DESC_SENTIDO                              ,
			 B.DESC_META_NORMALIZADA					 ,
			 B.FECHA_CARGA_SYNAPSE                       ,
			 B.FECHA_PROXIMA_ACTUALIZA_SYNAPSE           ,
			 CAST(B.FK_PERIODO AS VARCHAR)               ,
			 C.CANT_DECIMALES_REPORTE                    ,
			 C.CANT_DECIMALES_CALCULO,
			 B."VLR_REAL_PROY_ANNO1",
			 B."VLR_META_NORM_ANNIO_1",
			 B."VLR_META_ANNIO_1",
			 B."DESC_SENTIDO",
			 B."VLR_REAL_PROY_ANNO2",
			 B."VLR_META_NORM_ANNIO_2",
			 B."VLR_META_ANNIO_2",
			 B."VLR_REAL_PROY_ANNO3",
			 B."VLR_META_NORM_ANNIO_3",
			 B."VLR_META_ANNIO_3",
			 B."VLR_REAL_PROY_ANNO12",
			 B."VLR_META_NORM_ANNIO_12",
			 B."VLR_META_ANNIO_12",
			 B."VLR_REAL_PROY_ANNO123",
			 B."VLR_META_NORM_ANNIO_123",
			 B."VLR_META_ANNIO_123"
	)B
	GROUP BY
		B."DESC_ANNIO",
		B."FK_TABLERO",
		B."DESC_TABLERO",
		B."VIGENCIA_TABLERO_DESDE",
		B."VIGENCIA_TABLERO_HASTA",
		B."DESC_VERSION",
		B."DESC_GRUPO",
		B."DESC_EMPRESA",
		B."DESC_VP_EJECUTIVA",
		B."DESC_GRUPO_SEGMENTO",
		B."DESC_SEGMENTO",
		B."DESC_GERENCIA",
		B."DESC_RUTINA",
		B."DESC_SIGLA_AREA",
		B."DESC_NIVEL",
		B."DESC_EJE_PALANCA",
		B."DESC_OBJETIVO",
		B."ID_INDICADOR",
		B."DESC_NOMBRE_INDICADOR",
		B."FK_PARAM_INDICADOR",
		B."DESC_DETALLE_INDICADOR",
		B."DESC_HITO_INDICADOR",
		B."DESC_FRECUENCIA",
		B."VLR_PESO_INDICADOR",
		B."DESC_TIPO_TABLERO",
		B."DESC_SECUENCIA_ORDEN",
		B."DESC_CORTO_LARGO_PLAZO",
		B."DESC_REFERENTE",
		B."DESC_RESPONSABLE_MEDICION",
		B."DESC_CARGO_RESPONSABLE_MEDICION",
		B."DESC_CORREO_RESPONSABLE_MEDICION",
		B."DESC_RESPONSABLE_MEDICION_2",
		B."DESC_CARGO_RESPONSABLE_MEDICION_2",
		B."DESC_CORREO_RESPONSABLE_MEDICION_2",
		B."DTM_FECHACARGA",
		B."DESC_HITO_INDIC_HABILITADOR",
		B."ACTIVOCUMPLIMIENTOMIN",
		B."CUMPLIMIENTOMINIMO",
		B."RECONOCIMIENTOMINIMO",
		B."DESC_UNIDAD_NEGOCIO_NVL_2",
		B."DESC_UNIDAD_NEGOCIO_NVL_3",
		B."FK_INDICADOR",
		B."FK_PERIODO",
		B."DESC_PERIODO",
		B."PLAN ACUM PERIODOS",
		B."PERIODO AÑO",
		B."DESC_PREMISAS",
		B."DESC_MENSAJE_CLAVE_INDICADOR",
		B."DESC_SENTIDO",
		B."DESC_META_NORMALIZADA",
		B."Valor Meta Normalizada Año 1",
		B."Valor Meta Normalizada Año 2",
		B."Valor Meta Normalizada Año 3",
		B."Valor Meta Normalizada Años 1 2",
		B."Valor Meta Normalizada Años 1 2 3",
		B."Valor Real Año 1",
		B."Valor Real Año 2",
		B."Valor Real Año 3",
		B."Valor Real Años 1 2",
		B."Valor Real Años 1 2 3",
		B."Valor Real Acumulado",
		B."Valor Real Acumulado_Mes",
		B."Valor Plan Acumulado",
		B."Valor Plan Acumulado Normalizada",
		B."Valor Meta Año 1",
		B."Valor Meta Año 2",
		B."Valor Meta Año 3",
		B."Valor Meta Años 1 2",
		B."Valor Meta Años 1 2 3",
		B."Valor Reto    ",
		B."Valor Proyección Año 1",
		B."Valor Proyección Año 2",
		B."Valor Proyección Año 3",
		B."Valor Proyección Años 1 2",
		B."Valor Proyección Años 1 2 3",
		B."% Avance Acumulado ILP",
		B."% Avance ILP Años 1 2",
		B."% Avance ILP Año 1",
		B."% Cumplimiento Acumulado",
		B."FECHA_CARGA_SYNAPSE",
		B."FECHA_PROXIMA_ACTUALIZA_SYNAPSE",
		B."CANT_DECIMALES_REPORTE",
		B."CANT_DECIMALES_CALCULO",
		B."VLR_REAL_PROY_ANNO1",
		B."VLR_META_NORM_ANNIO_1",
		B."VLR_META_ANNIO_1",
		B."VLR_REAL_PROY_ANNO2",
		B."VLR_META_NORM_ANNIO_2",
		B."VLR_META_ANNIO_2",
		B."VLR_REAL_PROY_ANNO3",
		B."VLR_META_NORM_ANNIO_3",
		B."VLR_META_ANNIO_3",
		B."VLR_REAL_PROY_ANNO12",
		B."VLR_META_NORM_ANNIO_12",
		B."VLR_META_ANNIO_12",
		B."VLR_REAL_PROY_ANNO123",
		B."VLR_META_NORM_ANNIO_123",
		B."VLR_META_ANNIO_123"
) A;