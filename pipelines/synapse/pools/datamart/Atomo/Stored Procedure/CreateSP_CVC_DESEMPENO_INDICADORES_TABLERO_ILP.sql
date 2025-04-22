-- =============================================
-- Author:      Harold Lopez - Santiago Guzman 
-- Create Date: 2022-08-18
-- Description: Se crea la vista CVC_DESEMPENO_INDICADORES_TABLERO_ILP la cual es un inSUMo para la iniciativba de ILP

-- Author:      Oscar Angel 
-- Update Date: 2022-11-11
-- Description: Se realiza ajuste en query por limpieza de campos

-- Author:      Juan Benavides 
-- Update Date: 2022-12-16
-- Description: Se realiza ajuste en query para incluir campos de proyeccion.

-- Author:      Oscar Fabian Angel 
-- Update Date: 2023-03-16
-- Description: Se realiza ajuste para la adicion del campo Plan Acum Periodos

-- Author:      Alejandro Vargas
-- Update Date: 2023-04-11
-- Description: Se realiza la modificacion de los campos % Avance Acumulado ILP, % Avance ILP Años 1 2, % Avance ILP Año 1, % Cumplimiento Año 1, % Cumplimiento Año 2, % Cumplimiento Año 3, % Cumplimiento Años 1 2, % Cumplimiento Años 1 2 3, % Cumplimiento Acumulado

-- Author:      Alejandro Vargas
-- Update Date: 2023-04-18
-- Description: Se realiza la modificacion de los campos Valor Real Proyectado, Valor Meta, Valor Meta Normalizada y % Cumplimiento para los años 1,2,3 y 1 2, Avance ILP 1 y 1 2

-- Author:      Oscar Angel
-- Update Date: 2023-04-26
-- Description: Se realiza creacion de case para los campos Valor Plan Acumulado, Valor Plan Acumulado Normalizado, Valor Real Acumulado, % Avance Acumulado ILP, % Cumplimiento Acumulado de los hitos

-- Author:      Alejandra Delgado
-- Update Date: 2023-05-16
-- Description: Se realiza el ajuste en case para la replica de datosd en meses siguientes dependiento de la vigencia del año hito.

-- Author:      Oscar Fabian Angel 
-- Update Date: 2023-10-09
-- Description: Se realiza ajustes para inclusion de los campos ActivoCumplimientoMin, CumplimientoMinimo, ReconocimientoMinimo

-- Author:      Maria Delgado 
-- Update Date: 2023-12-20
-- Description: Se realiza ajustes para quitar la suma de varios campos en indicadores

-- Author:      Maria Delgado 
-- Update Date: 2023-12-27
-- Description: Se realiza ajustes para la formula de %Cumplimiento ILP

-- =============================================

CREATE PROC [ATOMO].[SP_DESEMPENO_INDICADORES_TABLERO_ILP] AS 
	 SET NOCOUNT ON;


	IF OBJECT_ID('tempdb..#TEMPCVC_INDICADORES_ILP1') IS NOT NULL
		BEGIN
			DROP TABLE #TEMPCVC_INDICADORES_ILP1
		END;

	IF OBJECT_ID('tempdb..#TEMPCVC_INDICADORES_ILP2') IS NOT NULL
		BEGIN
			DROP TABLE #TEMPCVC_INDICADORES_ILP2
		END;

	IF OBJECT_ID('tempdb..#TEMPCVC_INDICADORES_ILP3') IS NOT NULL
		BEGIN
			DROP TABLE #TEMPCVC_INDICADORES_ILP3
		END;

	IF OBJECT_ID('tempdb..#TEMPCVC_INDICADORES_ILP4') IS NOT NULL
		BEGIN
			DROP TABLE #TEMPCVC_INDICADORES_ILP4
		END;

	IF OBJECT_ID('tempdb..#TEMPCVC_INDICADORES_ILP5') IS NOT NULL
		BEGIN
			DROP TABLE #TEMPCVC_INDICADORES_ILP5
		END;

	IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] like '%TMP2CVC_INDICADORES_ILP%') 
	BEGIN
	   TRUNCATE TABLE [ATOMO].[TMP2CVC_INDICADORES_ILP];
	END;

	IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] like '%TEMPCVC_INDICADORES_ILP_replica%') 
	BEGIN
	   TRUNCATE TABLE [ATOMO].[TEMPCVC_INDICADORES_ILP_replica];
	END;


WITH  SUBNIVEL1
	  AS ( SELECT T."DESC_ANNIO" as "Año",
				  NULL AS "Año Hito",
				  T."DESC_CARGO_RESPONSABLE_MEDICION" AS "Cargo Responsable de Medición",
				  T."DESC_CARGO_RESPONSABLE_MEDICION_2" AS "Cargo Responsable de Medición 2",
				  T."DESC_CORREO_RESPONSABLE_MEDICION" AS "Correo Responsable de Medición",
				  T."DESC_CORREO_RESPONSABLE_MEDICION_2" AS "Correo Responsable de Medición 2",
				  T."DESC_CORTO_LARGO_PLAZO" AS "Corto Plazo / Largo Plazo",
				  T."DESC_DETALLE_INDICADOR" AS "Detalle Indicador",
				  T."DESC_EJE_PALANCA" AS "Eje o Palanca",
				  T."DESC_EMPRESA" AS "Empresa",
				  T."DTM_FECHACARGA" AS "Fecha de Carga",
				  T."FK_INDICADOR" AS "FK Indicador",
				  T."FK_PARAM_INDICADOR" AS "FK Parametrización Indicador",
				  T."FK_TABLERO" AS "FK Tablero",
				  T."VIGENCIA_TABLERO_DESDE" AS "Vigencia Tablero desde",
				  T."VIGENCIA_TABLERO_HASTA" AS "Vigencia Tablero hasta",
				  T."DESC_FRECUENCIA" AS "Frecuencia",
				  T."DESC_GERENCIA" AS "Gerencia",
				  T."DESC_GRUPO" AS "Grupo",
				  T."DESC_GRUPO_SEGMENTO" AS "Grupo Segmento",
				  T."DESC_HITO_INDICADOR" AS "Hito / Indicador",
				  T."ID_INDICADOR" AS "ID Indicador",
				  T."DESC_REFERENTE" AS "Indicador Referente",
				  T."DESC_NIVEL" AS "Nivel",
				  T."DESC_NOMBRE_INDICADOR" AS "Nombre Indicador",
				  T."DESC_RESPONSABLE_MEDICION" AS "Nombre Responsable de Medición",
				  T."DESC_RESPONSABLE_MEDICION_2" AS "Nombre Responsable de Medición 2",
				  T."CANT_DECIMALES_CALCULO" AS "Número de Decimales para el Cálculo",
				  T."DESC_OBJETIVO" AS "Objetivo",
				  T."DESC_PERIODO" AS "Periodo",
				  T."PLAN ACUM PERIODOS" AS "Plan Acum Periodos",
				  T."PERIODO AÑO" AS "Periodo Año",
				  T."DESC_RUTINA" AS "Rutina",
				  T."DESC_SECUENCIA_ORDEN" AS "Secuencia / Orden",
				  T."DESC_SEGMENTO" AS "Segmento",
				  T."DESC_SENTIDO" AS "Sentido",
				  T."DESC_SIGLA_AREA" AS "Sigla Área",
				  T."DESC_TABLERO" AS "Tablero",
				  T."FK_PERIODO" AS "Tiempo",
				  T."DESC_TIPO_TABLERO" AS "Tipo Tablero",
				  T."DESC_UNIDAD_NEGOCIO_NVL_2" AS "Unidad de Negocio Nivel 2",
				  T."DESC_UNIDAD_NEGOCIO_NVL_3" AS "Unidad de Negocio Nivel 3",
				  T."VLR_PESO_INDICADOR" AS "Valor Peso Indicador",
				  T."DESC_VERSION" AS "Versión",
				  T."DESC_VP_EJECUTIVA" AS "VP Ejecutiva",
				  I.DESC_VISUALIZA_PERIODO,
				  I.DESC_UNIDAD_MEDIDA,
				  T.FECHA_CARGA_SYNAPSE,
				  T.FECHA_PROXIMA_ACTUALIZA_SYNAPSE,
				  NULL AS CM_RESUMEN,
				  T.DESC_PREMISAS,
				  T.DESC_MENSAJE_CLAVE_INDICADOR,
				  T.DESC_HITO_INDIC_HABILITADOR,
				  T.ACTIVOCUMPLIMIENTOMIN,
				  T.CUMPLIMIENTOMINIMO,
				  T.RECONOCIMIENTOMINIMO,
				  MAX("Valor Meta Normalizada Año 1") AS "Valor Meta Normalizada Año 1",
				  MAX("Valor Meta Normalizada Año 2") AS "Valor Meta Normalizada Año 2",
				  MAX("Valor Meta Normalizada Año 3") AS "Valor Meta Normalizada Año 3",
				  MAX("Valor Meta Normalizada Años 1 2") AS "Valor Meta Normalizada Años 1 2",
				  MAX("Valor Meta Normalizada Años 1 2 3") AS "Valor Meta Normalizada Años 1 2 3",
				  MAX("Valor Real Año 1") AS "Valor Real Año 1",
				  MAX("Valor Real Año 2") AS "Valor Real Año 2",
				  MAX("Valor Real Año 3") AS "Valor Real Año 3",
				  MAX("Valor Real Años 1 2") AS "Valor Real Años 1 2",
				  MAX("Valor Real Años 1 2 3") AS "Valor Real Años 1 2 3",
				  MAX("Valor Real Acumulado") AS "Valor Real Acumulado",
				  T."Valor Real Acumulado_Mes" AS "Valor Real Acumulado_Mes",
				  MAX("Valor Plan Acumulado") AS "Valor Plan Acumulado",
				  MAX("Valor Plan Acumulado Normalizada") AS "Valor Plan Acumulado Normalizada",
				  MAX("Valor Meta Año 1") AS "Valor Meta Año 1",
				  MAX("Valor Meta Año 2") AS "Valor Meta Año 2",
				  MAX("Valor Meta Año 3") AS "Valor Meta Año 3",
				  MAX("Valor Meta Años 1 2") AS "Valor Meta Años 1 2",
				  MAX("Valor Meta Años 1 2 3") AS "Valor Meta Años 1 2 3",
				  MAX("Valor Reto    ") AS "Valor Reto",
				  MAX("Valor Proyección Año 1") AS "Valor Proyección Año 1",
				  MAX("Valor Proyección Año 2") AS "Valor Proyección Año 2",
				  MAX("Valor Proyección Año 3") AS "Valor Proyección Año 3",
				  MAX("Valor Proyección Años 1 2") AS "Valor Proyección Años 1 2",
				  MAX("Valor Proyección Años 1 2 3") AS "Valor Proyección Años 1 2 3",
				  MAX("% Avance Acumulado ILP") AS "% Avance Acumulado ILP",
				  MAX("% Avance ILP Años 1 2")  AS "% Avance ILP Años 1 2",
				  MAX("% Avance ILP Año 1")  AS "% Avance ILP Año 1",
				  MAX("% Cumplimiento Año 1") AS "% Cumplimiento Año 1",
				  MAX("% Cumplimiento Año 2") AS "% Cumplimiento Año 2",
				  MAX("% Cumplimiento Año 3") AS "% Cumplimiento Año 3",
				  MAX("% Cumplimiento Años 1 2") AS "% Cumplimiento Años 1 2",
				  MAX("% Cumplimiento Años 1 2 3")  AS "% Cumplimiento Años 1 2 3",
				  MAX("% Cumplimiento Acumulado")  AS "% Cumplimiento Acumulado",
				  MAX("Valor Real Proyectado Año 1") AS "Valor Real Proyectado Año 1",  
				  MAX("Valor Real Proyectado Año 2") AS "Valor Real Proyectado Año 2", 
				  MAX("Valor Real Proyectado Año 3") AS "Valor Real Proyectado Año 3",      
				  MAX("Valor Real Proyectado Años 1 2") AS "Valor Real Proyectado Años 1 2",
				  MAX("Valor Real Proyectado Años 1 2 3") AS "Valor Real Proyectado Años 1 2 3"
				 -- D.PRC_META_CVR AS "Meta ILP",
	
				  
				FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS T	
				
				INNER JOIN [ATOMO].[CVD_INDICADOR] AS I 
					 ON T."FK_INDICADOR"=I."GK_INDICADOR"
				INNER JOIN [ATOMO].[CVC_DESEMPENO_INDICADOR] B
					 ON B.FK_INDICADOR = I.GK_INDICADOR
			    INNER JOIN [ATOMO].[CVD_CONFIGURACION_TABLERO] A
				     ON A.FK_PARAM_INDICADOR = B.FK_PARAM_INDICADOR AND A.DESC_ANNIO = B.DESC_ANNIO AND A.FK_TABLERO = T.FK_TABLERO 
			    LEFT JOIN [ATOMO].[CVD_PARAMETRIZACION_CVR] D
					 ON REPLACE(A.DESC_VERSION,'.0','') = D.DESC_VERSION AND A.DESC_ANNIO = CAST(D.DTM_VIGENCIA_DESDE AS VARCHAR(4))

				GROUP BY
						T."DESC_ANNIO",
						T."DESC_CARGO_RESPONSABLE_MEDICION",
						T."DESC_CARGO_RESPONSABLE_MEDICION_2",
						T."DESC_CORREO_RESPONSABLE_MEDICION",
						T."DESC_CORREO_RESPONSABLE_MEDICION_2",
						T."DESC_CORTO_LARGO_PLAZO",
						T."DESC_DETALLE_INDICADOR",
						T."DESC_EJE_PALANCA",
						T."DESC_EMPRESA",
						T."DTM_FECHACARGA",
						T."FK_INDICADOR",
						T."FK_PARAM_INDICADOR",
						T."FK_TABLERO",
						T."VIGENCIA_TABLERO_DESDE",
						T."VIGENCIA_TABLERO_HASTA",
						T."DESC_FRECUENCIA",
						T."DESC_GERENCIA",
						T."DESC_GRUPO",
						T."DESC_GRUPO_SEGMENTO",
						T."DESC_HITO_INDICADOR",
						T."ID_INDICADOR",
						T."DESC_REFERENTE",
						T."DESC_NIVEL",
						T."DESC_NOMBRE_INDICADOR",
						T."DESC_RESPONSABLE_MEDICION",
						T."DESC_RESPONSABLE_MEDICION_2",
						T."CANT_DECIMALES_CALCULO",
						T."DESC_OBJETIVO",
						T."DESC_PERIODO",
						T."PLAN ACUM PERIODOS",
						T."PERIODO AÑO",
						T."DESC_RUTINA",
						T."DESC_SECUENCIA_ORDEN",
						T."DESC_SEGMENTO",
						T."DESC_SENTIDO",
						T."DESC_SIGLA_AREA",
						T."DESC_TABLERO",
						T."FK_PERIODO",
						T."DESC_TIPO_TABLERO",
						T."DESC_UNIDAD_NEGOCIO_NVL_2",
						T."DESC_UNIDAD_NEGOCIO_NVL_3",
						T."VLR_PESO_INDICADOR",
						T."DESC_VERSION",
						T."DESC_VP_EJECUTIVA",
						I.DESC_VISUALIZA_PERIODO,
						I.DESC_UNIDAD_MEDIDA,
						I.GK_INDICADOR,
						T.FECHA_CARGA_SYNAPSE,
						T.FECHA_PROXIMA_ACTUALIZA_SYNAPSE,
						T.DESC_PREMISAS,
						T.DESC_MENSAJE_CLAVE_INDICADOR,
						T.DESC_HITO_INDIC_HABILITADOR,
					    T.ACTIVOCUMPLIMIENTOMIN,
				        T.CUMPLIMIENTOMINIMO,
				        T.RECONOCIMIENTOMINIMO,
						T."Valor Real Acumulado_Mes"
						--D.PRC_META_CVR,
						--D.PRC_LIMITE_SUPERIOR_CVR 

						
		   UNION ALL    
					
		   SELECT T."DESC_ANNIO" AS "Año",
				  T."DESC_ANNIO_HITO" AS "Año Hito",
				  T."DESC_CARGO_RESPONSABLE_MEDICION" AS "Cargo Responsable de Medición",
				  T."DESC_CARGO_RESPONSABLE_MEDICION_2" AS "Cargo Responsable de Medición 2",
				  T."DESC_CORREO_RESPONSABLE_MEDICION" AS "Correo Responsable de Medición",
				  T."DESC_CORREO_RESPONSABLE_MEDICION_2" AS "Correo Responsable de Medición 2",
				  T."DESC_CORTO_LARGO_PLAZO" AS "Corto Plazo / Largo Plazo",
				  T."DESC_DETALLE_INDICADOR" AS "Detalle Indicador",
				  T."DESC_EJE_PALANCA" AS "Eje o Palanca",
				  T."DESC_EMPRESA" AS "Empresa",
				  T."DTM_FECHACARGA" AS "Fecha de Carga",
				  T."FK_INDICADOR" AS "FK Indicador",
				  T."FK_PARAM_INDICADOR" AS "FK Parametrización Indicador",
				  T."FK_TABLERO" AS "FK Tablero",
				  T."VIGENCIA_TABLERO_DESDE" AS "Vigencia Tablero desde",
				  T."VIGENCIA_TABLERO_HASTA" AS "Vigencia Tablero hasta",
				  T."DESC_FRECUENCIA" AS "Frecuencia",
				  T."DESC_GERENCIA" AS "Gerencia",
				  T."DESC_GRUPO" AS "Grupo",
				  T."DESC_GRUPO_SEGMENTO" AS "Grupo Segmento",
				  T."DESC_HITO_INDICADOR" AS "Hito / Indicador",
				  T."ID_INDICADOR" AS "ID Indicador",
				  T."DESC_REFERENTE" AS "Indicador Referente",
				  T."DESC_NIVEL" AS "Nivel",
				  T."DESC_NOMBRE_INDICADOR" AS "Nombre Indicador",
				  T."DESC_RESPONSABLE_MEDICION" AS "Nombre Responsable de Medición",
				  T."DESC_RESPONSABLE_MEDICION_2" AS "Nombre Responsable de Medición 2",
				  T."CANT_DECIMALES_CALCULO" AS "Número de Decimales para el Cálculo",
				  T."DESC_OBJETIVO" AS "Objetivo",
				  T."DESC_PERIODO" AS "Periodo",
				  CAST(NULL AS VARCHAR(15)) AS "Plan Acum Periodos",
				  CAST(NULL AS VARCHAR(15)) AS "Periodo Año",
				  T."DESC_RUTINA" AS "Rutina",
				  T."DESC_SECUENCIA_ORDEN" AS "Secuencia / Orden",
				  T."DESC_SEGMENTO" AS "Segmento",
				  T."DESC_SENTIDO" AS "Sentido",
				  T."DESC_SIGLA_AREA" AS "Sigla Área",
				  T."DESC_TABLERO" AS "Tablero",
				  T."FK_PERIODO" AS "Tiempo",
				  T."DESC_TIPO_TABLERO" AS "Tipo Tablero",
				  T."DESC_UNIDAD_NEGOCIO_NVL_2" AS "Unidad de Negocio Nivel 2",
				  T."DESC_UNIDAD_NEGOCIO_NVL_3" AS "Unidad de Negocio Nivel 3",
				  T."VLR_PESO_INDICADOR" AS "Valor Peso Indicador",
				  T."DESC_VERSION" AS "Versión",
				  T."DESC_VP_EJECUTIVA" AS "VP Ejecutiva",
				  I.DESC_VISUALIZA_PERIODO,
				  I.DESC_UNIDAD_MEDIDA,
				  T.FECHA_CARGA_SYNAPSE,
				  T.FECHA_PROXIMA_ACTUALIZA_SYNAPSE,
				  T.CM_RESUMEN   ,
				  T.DESC_PREMISAS,
				  T.DESC_MENSAJE_CLAVE_INDICADOR,
				  T.DESC_HITO_INDIC_HABILITADOR,
				  T.ACTIVOCUMPLIMIENTOMIN,
				  T.CUMPLIMIENTOMINIMO,
				  T.RECONOCIMIENTOMINIMO,
				  CASE WHEN CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE"))= T."DESC_ANNIO_HITO" 
						  THEN SUM("Valor Meta Normalizada Año 1") 
					   ELSE NULL END AS "Valor Meta Normalizada Año 1",
				  CASE WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE")+1)= T."DESC_ANNIO_HITO" AND (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=2)) 
						  THEN SUM("Valor Meta Normalizada Año 2")
					   WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE"))= T."DESC_ANNIO_HITO" and (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=1)) 
						  THEN SUM("Valor Meta Normalizada Año 2")
					   WHEN (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE"))=0 
						  THEN SUM("Valor Meta Normalizada Año 2")
					   ELSE NULL END AS "Valor Meta Normalizada Año 2",
				  CASE WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_HASTA"))= T."DESC_ANNIO_HITO" AND (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=2)) 
						  THEN SUM("Valor Meta Normalizada Año 3") 
					   WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_HASTA"))= T."DESC_ANNIO_HITO" AND (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=1)) 
						  THEN SUM("Valor Meta Normalizada Año 3") 
					   WHEN (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE"))=0 
						  THEN SUM("Valor Meta Normalizada Año 3") 
					   ELSE NULL END AS "Valor Meta Normalizada Año 3",
				  CASE WHEN CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE"))= T."DESC_ANNIO_HITO" 
						  THEN SUM("Valor Meta Normalizada Años 1 2")
					   WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE")+1)= T."DESC_ANNIO_HITO" AND (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=2)) 
						  THEN SUM("Valor Meta Normalizada Años 1 2")
					   WHEN (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE"))=0 
						  THEN SUM("Valor Meta Normalizada Años 1 2")
					   ELSE NULL END AS "Valor Meta Normalizada Años 1 2",
				  SUM("Valor Meta Normalizada Años 1 2 3") AS "Valor Meta Normalizada Años 1 2 3",
				  SUM("Valor Real Año 1") AS "Valor Real Año 1",
				  SUM("Valor Real Año 2") AS "Valor Real Año 2",
				  SUM("Valor Real Año 3") AS "Valor Real Año 3",
				  SUM("Valor Real Años 1 2") AS "Valor Real Años 1 2",
				  SUM("Valor Real Años 1 2 3") AS "Valor Real Años 1 2 3",
				  CASE WHEN T."DESC_ANNIO" >= T."DESC_ANNIO_HITO"
						  THEN SUM("Valor Real Acumulado")   
					   ELSE NULL END AS "Valor Real Acumulado",
				  CAST(NULL AS VARCHAR(15)) AS  "Valor Real Acumulado_Mes",
				  CASE WHEN T."DESC_ANNIO" >= T."DESC_ANNIO_HITO"
						  THEN SUM("Valor Plan Acumulado")      
					   ELSE NULL END AS "Valor Plan Acumulado",
				  CASE WHEN T."DESC_ANNIO" >= T."DESC_ANNIO_HITO"
						  THEN SUM("Valor Plan Acumulado Normalizada")
					   ELSE NULL END AS "Valor Plan Acumulado Normalizada",
				  CASE WHEN CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE"))= T."DESC_ANNIO_HITO" 
						  THEN SUM("Valor Meta Año 1")
					   ELSE NULL END AS "Valor Meta Año 1",
				  CASE WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE")+1)= T."DESC_ANNIO_HITO" AND (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=2)) 
						  THEN SUM("Valor Meta Año 2")
					   WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE"))= T."DESC_ANNIO_HITO" and (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=1)) 
						  THEN SUM("Valor Meta Año 2")
					   WHEN (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE"))=0  
						  THEN SUM("Valor Meta Año 2")
					   ELSE NULL END AS "Valor Meta Año 2",
				  CASE WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_HASTA"))= T."DESC_ANNIO_HITO" AND (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=2)) 
						  THEN SUM("Valor Meta Año 3")
					   WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_HASTA"))= T."DESC_ANNIO_HITO" AND (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=1)) 
						  THEN SUM("Valor Meta Año 3")
					   WHEN (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE"))=0  
						  THEN SUM("Valor Meta Año 3") 
					   ELSE NULL END AS "Valor Meta Año 3",
				  CASE WHEN CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE"))= T."DESC_ANNIO_HITO" 
						  THEN SUM("Valor Meta Años 1 2")
					   WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE")+1)= T."DESC_ANNIO_HITO" AND (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=2)) 
						  THEN SUM("Valor Meta Años 1 2")
					   WHEN (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE"))=0	 
						  THEN SUM("Valor Meta Años 1 2")
					   ELSE NULL END AS "Valor Meta Años 1 2",
				  SUM("Valor Meta Años 1 2 3") AS "Valor Meta Años 1 2 3",
				  SUM("Valor Reto") AS "Valor Reto",
				  SUM("Valor Proyección Año 1") AS "Valor Proyección Año 1",
				  SUM("Valor Proyección Año 2") AS "Valor Proyección Año 2",
				  SUM("Valor Proyección Año 3") AS "Valor Proyección Año 3",
				  SUM("Valor Proyección Años 1 2") AS "Valor Proyección Años 1 2",
				  SUM("Valor Proyección Años 1 2 3") AS "Valor Proyección Años 1 2 3",
				  CASE WHEN T."DESC_ANNIO" >= T."DESC_ANNIO_HITO"
						  THEN SUM("% Avance Acumulado ILP")   
					   ELSE NULL END AS "% Avance Acumulado ILP",
				  CASE WHEN CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE"))= T."DESC_ANNIO_HITO"	  
						  THEN SUM("% Avance ILP Años 1 2")
					   WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE")+1)= T."DESC_ANNIO_HITO" AND (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=2)) 
						  THEN SUM("% Avance ILP Años 1 2")
					   WHEN (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE"))=0	 
						  THEN SUM("% Avance ILP Años 1 2")
					   ELSE NULL END AS "% Avance ILP Años 1 2",
				  CASE WHEN CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE"))= T."DESC_ANNIO_HITO"	
						  THEN SUM("% Avance ILP Año 1")
					   ELSE NULL END AS "% Avance ILP Año 1",
				  CASE WHEN CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE"))= T."DESC_ANNIO_HITO"	
						  THEN SUM("% Cumplimiento Año 1")
					   ELSE NULL END AS "% Cumplimiento Año 1",
				  CASE WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE")+1)= T."DESC_ANNIO_HITO" AND (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=2)) 
						  THEN SUM("% Cumplimiento Año 2")
					   WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE"))= T."DESC_ANNIO_HITO" and (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=1)) 
						  THEN SUM("% Cumplimiento Año 2")
					   WHEN (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE"))=0 
						  THEN SUM("% Cumplimiento Año 2")
					   ELSE NULL END AS "% Cumplimiento Año 2",
				  CASE WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_HASTA"))= T."DESC_ANNIO_HITO" AND (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=2)) 
						  THEN SUM("% Cumplimiento Año 3")
					   WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_HASTA"))= T."DESC_ANNIO_HITO" AND (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=1))	
						  THEN SUM("% Cumplimiento Año 3")
					   WHEN (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE"))=0  
						  THEN SUM("% Cumplimiento Año 3") 
					   ELSE NULL END AS "% Cumplimiento Año 3",
				  CASE WHEN CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE"))= T."DESC_ANNIO_HITO" 
						  THEN SUM("% Cumplimiento Años 1 2")
					   WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE")+1)= T."DESC_ANNIO_HITO" AND (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=2)) 
						  THEN SUM("% Cumplimiento Años 1 2")
					   WHEN (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE"))=0	
						  THEN SUM("% Cumplimiento Años 1 2")   
					   ELSE NULL END AS "% Cumplimiento Años 1 2",
				   SUM("% Cumplimiento Años 1 2 3") AS "% Cumplimiento Años 1 2 3",
				  CASE WHEN T."DESC_ANNIO" >= T."DESC_ANNIO_HITO"
						  THEN SUM("% Cumplimiento Acumulado")
					   ELSE NULL END AS "% Cumplimiento Acumulado",
				  CASE WHEN CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE"))= T."DESC_ANNIO_HITO"	
						  THEN SUM("Valor Real Proyectado Año 1")
					   ELSE NULL END AS "Valor Real Proyectado Año 1",
				 CASE WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE")+1)= T."DESC_ANNIO_HITO" AND (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=2)) 
						  THEN SUM("Valor Real Proyectado Año 2")
					   WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE"))= T."DESC_ANNIO_HITO" and (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=1))	
						  THEN SUM("Valor Real Proyectado Año 2")
					   WHEN (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE"))=0  
						  THEN SUM("Valor Real Proyectado Año 2")
					   ELSE NULL END AS "Valor Real Proyectado Año 2",
				  CASE WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_HASTA"))= T."DESC_ANNIO_HITO" AND (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=2)) 
						  THEN SUM("Valor Real Proyectado Año 3")
					   WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_HASTA"))= T."DESC_ANNIO_HITO" AND (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=1)) 
						  THEN SUM("Valor Real Proyectado Año 3")
					   WHEN (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE"))=0  
						  THEN SUM("Valor Real Proyectado Año 3") 
					   ELSE NULL END AS "Valor Real Proyectado Año 3",
				  CASE WHEN CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE"))= T."DESC_ANNIO_HITO" 
						  THEN SUM("Valor Real Proyectado Años 1 2")
					   WHEN (CONVERT(VARCHAR,YEAR(T."VIGENCIA_TABLERO_DESDE")+1)= T."DESC_ANNIO_HITO" AND (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE")=2))
						  THEN SUM("Valor Real Proyectado Años 1 2")
					   WHEN (YEAR(T."VIGENCIA_TABLERO_HASTA")-YEAR(T."VIGENCIA_TABLERO_DESDE"))=0  
						  THEN SUM("Valor Real Proyectado Años 1 2")
					   ELSE NULL END AS "Valor Real Proyectado Años 1 2",
				     SUM("Valor Real Proyectado Años 1 2 3") AS "Valor Real Proyectado Años 1 2 3"


				  FROM [ATOMO].[CVC_HITO_TABLERO_ILP] AS T
				
				INNER JOIN [ATOMO].[CVD_INDICADOR] AS I 
					 ON T."FK_INDICADOR"=I."GK_INDICADOR"
				GROUP BY
						T."DESC_ANNIO",
						T."DESC_ANNIO_HITO",
						T."DESC_CARGO_RESPONSABLE_MEDICION",
						T."DESC_CARGO_RESPONSABLE_MEDICION_2",
						T."DESC_CORREO_RESPONSABLE_MEDICION",
						T."DESC_CORREO_RESPONSABLE_MEDICION_2",
						T."DESC_CORTO_LARGO_PLAZO",
						T."DESC_DETALLE_INDICADOR",
						T."DESC_EJE_PALANCA",
						T."DESC_EMPRESA",
						T."DTM_FECHACARGA",
						T."FK_INDICADOR",
						T."FK_PARAM_INDICADOR",
						T."FK_TABLERO",
						T."VIGENCIA_TABLERO_DESDE",
						T."VIGENCIA_TABLERO_HASTA",
						T."DESC_FRECUENCIA",
						T."DESC_GERENCIA",
						T."DESC_GRUPO",
						T."DESC_GRUPO_SEGMENTO",
						T."DESC_HITO_INDICADOR",
						T."ID_INDICADOR",
						T."DESC_REFERENTE",
						T."DESC_NIVEL",
						T."DESC_NOMBRE_INDICADOR",
						T."DESC_RESPONSABLE_MEDICION",
						T."DESC_RESPONSABLE_MEDICION_2",
						T."CANT_DECIMALES_CALCULO",
						T."DESC_OBJETIVO",
						T."DESC_PERIODO",
						T."DESC_RUTINA",
						T."DESC_SECUENCIA_ORDEN",
						T."DESC_SEGMENTO",
						T."DESC_SENTIDO",
						T."DESC_SIGLA_AREA",
						T."DESC_TABLERO",
						T."DESC_TIPO_TABLERO",
						T."FK_PERIODO",
						T."DESC_UNIDAD_NEGOCIO_NVL_2",
						T."DESC_UNIDAD_NEGOCIO_NVL_3",
						T."VLR_PESO_INDICADOR",
						T."DESC_VERSION",
						T."DESC_VP_EJECUTIVA",
						I.DESC_VISUALIZA_PERIODO,
						I.DESC_UNIDAD_MEDIDA,
						I.GK_INDICADOR,
						T.FECHA_CARGA_SYNAPSE,
						T.FECHA_PROXIMA_ACTUALIZA_SYNAPSE,
						T.CM_RESUMEN   ,
						T.DESC_PREMISAS,
						T.DESC_MENSAJE_CLAVE_INDICADOR,
						T.DESC_HITO_INDIC_HABILITADOR,
						T.ACTIVOCUMPLIMIENTOMIN,
						T.CUMPLIMIENTOMINIMO,
						T.RECONOCIMIENTOMINIMO
						),

 SUBNIVEL2   
	  AS ( SELECT "Año",
                  "Año Hito",
                  "Cargo Responsable de Medición",
                  "Cargo Responsable de Medición 2",
                  "Correo Responsable de Medición",
                  "Correo Responsable de Medición 2",
                  "Corto Plazo / Largo Plazo",
                  "Detalle Indicador",
                  "Eje o Palanca",
                  "Empresa",
                  "Fecha de Carga",
                  "FK Indicador",
                  "FK Parametrización Indicador",
                  "FK Tablero",
                  "Vigencia Tablero desde",
                  "Vigencia Tablero hasta",
                  "Frecuencia",
                  "Gerencia",
                  "Grupo",
                  "Grupo Segmento",
                  "Hito / Indicador",
                  "ID Indicador",
                  "Indicador Referente",
                  "Nivel",
                  "Nombre Indicador",
                  "Nombre Responsable de Medición",
                  "Nombre Responsable de Medición 2",
                  "Número de Decimales para el Cálculo",
                  "Objetivo",
                  "Periodo",
                  "Plan Acum Periodos",
                  "Periodo Año",
                  "Rutina",
                  "Secuencia / Orden",
                  "Segmento",
                  "Sentido",
                  "Sigla Área",
                  "Tablero",
                  "Tiempo",
                  "Tipo Tablero",
                  "Unidad de Negocio Nivel 2",
                  "Unidad de Negocio Nivel 3",
                  "Valor Peso Indicador",
                  "Versión",
                  "VP Ejecutiva",
                  "DESC_VISUALIZA_PERIODO",
                  "DESC_UNIDAD_MEDIDA",
                  "FECHA_CARGA_SYNAPSE",
                  "FECHA_PROXIMA_ACTUALIZA_SYNAPSE",
                  "CM_RESUMEN",
                  "DESC_PREMISAS",
                  "DESC_MENSAJE_CLAVE_INDICADOR",
                  "DESC_HITO_INDIC_HABILITADOR",
				  "ACTIVOCUMPLIMIENTOMIN",
				  "CUMPLIMIENTOMINIMO",
				  "RECONOCIMIENTOMINIMO",
---- Valor Meta Año Normalizada
				  "Valor Meta Normalizada Año 1",
				   "Valor Meta Normalizada Año 2",
				   "Valor Meta Normalizada Año 3",
				   "Valor Meta Normalizada Años 1 2",
				   "Valor Meta Normalizada Años 1 2 3",
                  "Valor Real Año 1",
                  "Valor Real Año 2",
                  "Valor Real Año 3",
                  "Valor Real Años 1 2",
                  "Valor Real Años 1 2 3",
				  "Valor Real Acumulado",
                  "Valor Real Acumulado_Mes",
				  "Valor Plan Acumulado",
				  "Valor Plan Acumulado Normalizada",
---- Valor metas año
				  "Valor Meta Año 1",
				  "Valor Meta Año 2",
				  "Valor Meta Año 3",
				  "Valor Meta Años 1 2",
				  "Valor Meta Años 1 2 3",
                  "Valor Reto",
                  "Valor Proyección Año 1",
                  "Valor Proyección Año 2",
                  "Valor Proyección Año 3",
                  "Valor Proyección Años 1 2",
                  "Valor Proyección Años 1 2 3",
				  "% Avance Acumulado ILP",
				  "% Avance ILP Años 1 2",
				  "% Avance ILP Año 1",

---- Cumplimiento Año
				    "% Cumplimiento Año 1",
				    "% Cumplimiento Año 2",
					"% Cumplimiento Año 3",
					"% Cumplimiento Años 1 2",
					"% Cumplimiento Años 1 2 3",
					"% Cumplimiento Acumulado",
---- Valor Real Proyectado
					"Valor Real Proyectado Año 1",
					"Valor Real Proyectado Año 2",
					"Valor Real Proyectado Año 3",
					"Valor Real Proyectado Años 1 2",
					"Valor Real Proyectado Años 1 2 3",
---- Meta año Final
	CASE WHEN ("Valor Meta Normalizada Años 1 2 3" IS NOT NULL)
						THEN (CASE WHEN ("Valor Meta Normalizada Años 1 2 3" IS NULL)
									  THEN "Valor Meta Años 1 2 3"
								   ELSE "Valor Meta Normalizada Años 1 2 3" END)
				     ELSE "Valor Meta Años 1 2 3"END AS META_ANNIO_FINAL

		FROM SUBNIVEL1  )

SELECT * INTO #TEMPCVC_INDICADORES_ILP1 FROM SUBNIVEL2;

WITH SUBNIVEL3  
	  AS ( SELECT "Año",
				  "Año Hito",
				  "Cargo Responsable de Medición",
				  "Cargo Responsable de Medición 2",
				  "Correo Responsable de Medición",
				  "Correo Responsable de Medición 2",
				  "Corto Plazo / Largo Plazo",
				  "Detalle Indicador",
				  "Eje o Palanca",
				  "Empresa",
				  "Fecha de Carga",
				  "FK Indicador",
				  "FK Parametrización Indicador",
				  "FK Tablero",
				  CAST("Vigencia Tablero desde" AS DATE) AS "Vigencia Tablero desde",
				  CAST("Vigencia Tablero hasta" AS DATE) AS "Vigencia Tablero hasta",
				  "Frecuencia",
				  "Gerencia",
				  "Grupo",
				  "Grupo Segmento",
				  UPPER(LEFT("Hito / Indicador", 1)) + LOWER(SUBSTRING("Hito / Indicador", 2, LEN("Hito / Indicador"))) AS "Hito / Indicador",
				  "ID Indicador",
				  "Indicador Referente",
				  "Nivel",
				  "Nombre Indicador",
				  "Nombre Responsable de Medición",
				  "Nombre Responsable de Medición 2",
				  "Número de Decimales para el Cálculo",
				  "Objetivo",
				  "Periodo",
				  "Plan Acum Periodos",
				  "Periodo Año",
				  "Rutina",
				  REPLACE("Secuencia / Orden",'SIN CLASIFICAR','999') AS "Secuencia / Orden",
				  "Segmento",
				  "Sentido",
				  "Sigla Área",
				  "Tablero",
				  CAST ("Tiempo" AS INT) AS "Tiempo",
				  "Tipo Tablero",
				  "Unidad de Negocio Nivel 2",
				  "Unidad de Negocio Nivel 3",
				  "Valor Peso Indicador",
				  "Versión",
				  "VP Ejecutiva",
				  "Valor Meta Normalizada Año 1",
				  "Valor Meta Normalizada Año 2",
				  "Valor Meta Normalizada Año 3",
				  "Valor Meta Normalizada Años 1 2",
				  "Valor Meta Normalizada Años 1 2 3",
				  "Valor Real Año 1",
				  "Valor Real Año 2",
				  "Valor Real Año 3",
				  "Valor Real Años 1 2",
				  "Valor Real Años 1 2 3",
				  CASE WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde"), '03') AND concat(year("Vigencia Tablero desde"),'05')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Real Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde"), '03')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde"), '06') AND concat(year("Vigencia Tablero desde"),'08')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Real Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde"), '06')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde"), '09') AND concat(year("Vigencia Tablero desde"),'11')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Real Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde"), '09')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						 
						 ---- Validacion Segundo año
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+1, '03') AND concat(year("Vigencia Tablero desde")+1,'05')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Real Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+1, '03')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+1, '06') AND concat(year("Vigencia Tablero desde")+1,'08')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Real Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+1, '06')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+1, '09') AND concat(year("Vigencia Tablero desde")+1,'11')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Real Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+1, '09')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						 
						 ---- Validacion Tercer año
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+2, '03') AND concat(year("Vigencia Tablero desde")+2,'05')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Real Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+2, '03')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+2, '06') AND concat(year("Vigencia Tablero desde")+2,'08')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Real Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+2, '06')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+2, '09') AND concat(year("Vigencia Tablero desde")+2,'11')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Real Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+2, '09')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")

				WHEN "Frecuencia" = 'Semestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde"), '06') AND concat(year("Vigencia Tablero desde"),'11')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Real Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde"), '06')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Semestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+1, '06') AND concat(year("Vigencia Tablero desde")+1,'11')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Real Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+1, '06')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Semestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+2, '06') AND concat(year("Vigencia Tablero desde")+2,'11')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Real Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+2, '06')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				ELSE [Valor Real Acumulado]  END AS "Valor Real Acumulado",
				
				  "Valor Real Acumulado_Mes",
				  CASE WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde"), '03') AND concat(year("Vigencia Tablero desde"),'05')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde"), '03')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde"), '06') AND concat(year("Vigencia Tablero desde"),'08')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde"), '06')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde"), '09') AND concat(year("Vigencia Tablero desde"),'11')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde"), '09')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						 
						 ---- Validacion Segundo año
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+1, '03') AND concat(year("Vigencia Tablero desde")+1,'05')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+1, '03')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+1, '06') AND concat(year("Vigencia Tablero desde")+1,'08')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+1, '06')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+1, '09') AND concat(year("Vigencia Tablero desde")+1,'11')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+1, '09')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						 
						 ---- Validacion Tercer año
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+2, '03') AND concat(year("Vigencia Tablero desde")+2,'05')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+2, '03')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+2, '06') AND concat(year("Vigencia Tablero desde")+2,'08')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+2, '06')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+2, '09') AND concat(year("Vigencia Tablero desde")+2,'11')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+2, '09')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
					   
				WHEN "Frecuencia" = 'Semestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde"), '06') AND concat(year("Vigencia Tablero desde"),'11')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado] 
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde"), '06')
						   AND DTI.[FK_INDICADOR]  = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Semestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+1, '06') AND concat(year("Vigencia Tablero desde")+1,'11')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+1, '06')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Semestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+2, '06') AND concat(year("Vigencia Tablero desde")+2,'11')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+2, '06')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				ELSE [Valor Plan Acumulado]  END AS "Valor Plan Acumulado",
			
				  "Valor Plan Acumulado Normalizada",
				  "Valor Meta Año 1",
				  "Valor Meta Año 2",
				  "Valor Meta Año 3",
				  "Valor Meta Años 1 2",
				  "Valor Meta Años 1 2 3",
				  "Valor Reto",
				  "Valor Proyección Año 1",
				  "Valor Proyección Año 2",
				  "Valor Proyección Año 3",
				  "Valor Proyección Años 1 2",
				  "Valor Proyección Años 1 2 3",
				  "% Avance Acumulado ILP",
				  "% Avance ILP Años 1 2",
				  "% Avance ILP Año 1",
				  "% Cumplimiento Año 1",
				  "% Cumplimiento Año 2",
				  "% Cumplimiento Año 3",
				  "% Cumplimiento Años 1 2",
				  "% Cumplimiento Años 1 2 3",
				  "% Cumplimiento Acumulado",
				  "Valor Real Proyectado Año 1",
				  "Valor Real Proyectado Año 2",
				  "Valor Real Proyectado Año 3",
				  "Valor Real Proyectado Años 1 2",
				  "Valor Real Proyectado Años 1 2 3",
				  DESC_VISUALIZA_PERIODO AS "_CC Reporta Periodo",
				  DESC_UNIDAD_MEDIDA AS UnidadMedida,
				  FECHA_CARGA_SYNAPSE,
				  FECHA_PROXIMA_ACTUALIZA_SYNAPSE,
				  CM_RESUMEN   ,
				  DESC_PREMISAS AS "Premisas",
				  DESC_MENSAJE_CLAVE_INDICADOR AS "Mensaje clave indicador",
				  DESC_HITO_INDIC_HABILITADOR AS "Hito/Ind Habilitador",
				  ACTIVOCUMPLIMIENTOMIN,
				  CUMPLIMIENTOMINIMO,
				  RECONOCIMIENTOMINIMO,
				  CASE WHEN Periodo = 0 
						  THEN NULL 
					   ELSE CAST(Periodo + '01' AS DATE) END AS Fecha,
				  CASE WHEN Periodo = 0 
						  THEN NULL 
					   ELSE REPLACE(FORMAT(CAST(Periodo + '01' AS DATE),'MMM','es-ES'),'.','') END AS "Mes",
				  CASE WHEN UPPER("Hito / Indicador") = 'INDICADOR' 
						  THEN 'DetalleKPIPanel'
					   ELSE 'DetalleSegHitosPanel' END AS ".CC Drill Through Detalle KPI Panel",
				  CASE WHEN UPPER("Hito / Indicador") = 'INDICADOR' 
						  THEN 'DetalleKPI'
					   ELSE 'DetalleSegHitos' END AS "_CC Drill Through Detalle KPI",
				  CASE WHEN UPPER("Hito / Indicador") = 'INDICADOR' 
						  THEN '     I'
					   WHEN UPPER("Hito / Indicador") = 'HITO' 
						  THEN '     H'
					   ELSE "Hito / Indicador" END AS "_CC Hito/Ind",
				  CASE "Eje o Palanca"
					   WHEN 'Excelencia operacional HSE/ASP' 
						  THEN 1
					   WHEN 'Estricta disciplina de capital' 
						  THEN 2
					   WHEN 'Competitividad y sostenibilidad' 
						  THEN 3
					   ELSE NULL END AS "_CC Orden Eje/Palanca",
				  COALESCE("Valor Meta Normalizada Años 1 2 3","Valor Meta Años 1 2 3") AS "Meta Años 1 2 3 para Brecha",
				  META_ANNIO_FINAL,
---- Limite Inferior Año
				  CASE WHEN (CUMPLIMIENTOMINIMO IS NULL)
						THEN NULL 
					 WHEN (META_ANNIO_FINAL = 0)
						THEN NULL
					 WHEN ("Valor Meta Normalizada Años 1 2 3" IS NULL AND ("Sentido" = 'Negativo' OR META_ANNIO_FINAL < 0))
						THEN (META_ANNIO_FINAL + ((1 - CUMPLIMIENTOMINIMO/100 ) * CUMPLIMIENTOMINIMO/100))
					 WHEN ("Valor Meta Normalizada Años 1 2 3" IS NOT NULL AND ("Sentido" = 'Negativo' OR META_ANNIO_FINAL < 0))
						THEN (META_ANNIO_FINAL + ((1 - CUMPLIMIENTOMINIMO/100) * META_ANNIO_FINAL))
					 WHEN ("Valor Meta Normalizada Años 1 2 3" IS NULL)
						THEN (CUMPLIMIENTOMINIMO/100 * META_ANNIO_FINAL)
					 WHEN ("Valor Meta Normalizada Años 1 2 3" IS NOT NULL)
						THEN (CUMPLIMIENTOMINIMO/100 * META_ANNIO_FINAL)
					ELSE NULL END AS VLR_LIMITE_INFERIOR_ANNIO

				FROM #TEMPCVC_INDICADORES_ILP1  )

	SELECT * INTO #TEMPCVC_INDICADORES_ILP2 FROM SUBNIVEL3;


		WITH SUBNIVEL4
	  AS ( SELECT "Año",
				  "Año Hito",
				  "Cargo Responsable de Medición",
				  "Cargo Responsable de Medición 2",
				  "Correo Responsable de Medición",
				  "Correo Responsable de Medición 2",
				  "Corto Plazo / Largo Plazo",
				  "Detalle Indicador",
				  "Eje o Palanca",
				  "Empresa",
				  "Fecha de Carga",
				  "FK Indicador",
				  "FK Parametrización Indicador",
				  "FK Tablero",
				  "Vigencia Tablero desde",
				  "Vigencia Tablero hasta",
				  "Frecuencia",
				  "Gerencia",
				  "Grupo",
				  "Grupo Segmento",
				  "Hito / Indicador",
				  "ID Indicador",
				  "Indicador Referente",
				  "Nivel",
				  "Nombre Indicador",
				  "Nombre Responsable de Medición",
				  "Nombre Responsable de Medición 2",
				  "Número de Decimales para el Cálculo",
				  "Objetivo",
				  "Periodo",
				  "Plan Acum Periodos",
				  "Periodo Año",
				  "Rutina",
				  "Secuencia / Orden",
				  "Segmento",
				  "Sentido",
				  "Sigla Área",
				  "Tablero",
				  "Tiempo",
				  "Tipo Tablero",
				  "Unidad de Negocio Nivel 2",
				  "Unidad de Negocio Nivel 3",
				  "Valor Peso Indicador",
				  "Versión",
				  "VP Ejecutiva",
				  "Valor Meta Normalizada Año 1",
				  "Valor Meta Normalizada Año 2",
				  "Valor Meta Normalizada Año 3",
				  "Valor Meta Normalizada Años 1 2",
				  "Valor Meta Normalizada Años 1 2 3",
				  "Valor Real Año 1",
				  "Valor Real Año 2",
				  "Valor Real Año 3",
				  "Valor Real Años 1 2",
				  "Valor Real Años 1 2 3",
				  "Valor Real Acumulado",
				  "Valor Real Acumulado_Mes",
				  "Valor Plan Acumulado",
				   "Valor Plan Acumulado Normalizada",
				  "Valor Meta Año 1",
				  "Valor Meta Año 2",
				  "Valor Meta Año 3",
				  "Valor Meta Años 1 2",
				  "Valor Meta Años 1 2 3",
				  "Valor Reto",
				  "Valor Proyección Año 1",
				  "Valor Proyección Año 2",
				  "Valor Proyección Año 3",
				  "Valor Proyección Años 1 2",
				  "Valor Proyección Años 1 2 3",
				  "% Avance Acumulado ILP",
				  "% Avance ILP Años 1 2",
				  "% Avance ILP Año 1",
				  "% Cumplimiento Año 1",
				  "% Cumplimiento Año 2",
				  "% Cumplimiento Año 3",
				  "% Cumplimiento Años 1 2",
				  "% Cumplimiento Años 1 2 3",
				  "% Cumplimiento Acumulado",
				  "Valor Real Proyectado Año 1",
				  "Valor Real Proyectado Año 2",
				  "Valor Real Proyectado Año 3",
				  "Valor Real Proyectado Años 1 2",
				  "Valor Real Proyectado Años 1 2 3",
				  "_CC Reporta Periodo",
				  UnidadMedida,
				  FECHA_CARGA_SYNAPSE,
				  FECHA_PROXIMA_ACTUALIZA_SYNAPSE,
				  CM_RESUMEN   ,
				  "Premisas",
				  "Mensaje clave indicador",
				  "Hito/Ind Habilitador",
				  ACTIVOCUMPLIMIENTOMIN,
				  CUMPLIMIENTOMINIMO,
				  RECONOCIMIENTOMINIMO,
				  "Fecha",
				  "Mes",
				  ".CC Drill Through Detalle KPI Panel",
				  "_CC Drill Through Detalle KPI",
				  "_CC Hito/Ind",
				  "_CC Orden Eje/Palanca",
				  "Meta Años 1 2 3 para Brecha",
				  META_ANNIO_FINAL,
				  VLR_LIMITE_INFERIOR_ANNIO,
				  ------------------------CALCULO DE RECTA ANNIO -------------------------------------------------
				  	 CASE WHEN ("Sentido" = 'Positivo' AND ("Valor Real Proyectado Años 1 2 3" > VLR_LIMITE_INFERIOR_ANNIO) AND ("Valor Real Proyectado Años 1 2 3" < META_ANNIO_FINAL))
						THEN 1
					 WHEN ("Sentido" = 'Positivo' AND ("Valor Real Proyectado Años 1 2 3"  > META_ANNIO_FINAL) AND ("Valor Real Proyectado Años 1 2 3"  < '1'))
						THEN 2
					 WHEN ("Sentido" = 'Positivo' AND ("Valor Real Proyectado Años 1 2 3"  < VLR_LIMITE_INFERIOR_ANNIO))
						THEN 3
					 WHEN ("Sentido" = 'Positivo' AND ("Valor Real Proyectado Años 1 2 3"  > '1'))
						THEN 4
					 WHEN ("Sentido" = 'Negativo' AND ("Valor Real Proyectado Años 1 2 3"  > META_ANNIO_FINAL AND "Valor Real Proyectado Años 1 2 3"  < VLR_LIMITE_INFERIOR_ANNIO))
						THEN 1
					 WHEN ("Sentido" = 'Negativo' AND ("Valor Real Proyectado Años 1 2 3"  > '1' AND "Valor Real Proyectado Años 1 2 3"  <META_ANNIO_FINAL))
						THEN 2
					 WHEN ("Sentido" = 'Negativo' AND ("Valor Real Proyectado Años 1 2 3" > VLR_LIMITE_INFERIOR_ANNIO))
						THEN 3
					 WHEN ("Sentido" = 'Negativo' AND ("Valor Real Proyectado Años 1 2 3"  < '1'))
						THEN 4
					 ELSE  NULL  END AS RECTA_ANNIO		   
				   		   FROM #TEMPCVC_INDICADORES_ILP2 )

	SELECT * INTO #TEMPCVC_INDICADORES_ILP3 FROM SUBNIVEL4;


		WITH SUBNIVEL5
	  AS ( SELECT "Año",
				  "Año Hito",
				  "Cargo Responsable de Medición",
				  "Cargo Responsable de Medición 2",
				  "Correo Responsable de Medición",
				  "Correo Responsable de Medición 2",
				  "Corto Plazo / Largo Plazo",
				  "Detalle Indicador",
				  "Eje o Palanca",
				  "Empresa",
				  "Fecha de Carga",
				  "FK Indicador",
				  "FK Parametrización Indicador",
				  "FK Tablero",
				  "Vigencia Tablero desde",
				  "Vigencia Tablero hasta",
				  "Frecuencia",
				  "Gerencia",
				  "Grupo",
				  "Grupo Segmento",
				  "Hito / Indicador",
				  "ID Indicador",
				  "Indicador Referente",
				  "Nivel",
				  "Nombre Indicador",
				  "Nombre Responsable de Medición",
				  "Nombre Responsable de Medición 2",
				  "Número de Decimales para el Cálculo",
				  "Objetivo",
				  "Periodo",
				  "Plan Acum Periodos",
				  "Periodo Año",
				  "Rutina",
				  "Secuencia / Orden",
				  "Segmento",
				  "Sentido",
				  "Sigla Área",
				  "Tablero",
				  "Tiempo",
				  "Tipo Tablero",
				  "Unidad de Negocio Nivel 2",
				  "Unidad de Negocio Nivel 3",
				  "Valor Peso Indicador",
				  "Versión",
				  "VP Ejecutiva",
				  "Valor Meta Normalizada Año 1",
				  "Valor Meta Normalizada Año 2",
				  "Valor Meta Normalizada Año 3",
				  "Valor Meta Normalizada Años 1 2",
				  "Valor Meta Normalizada Años 1 2 3",
				  "Valor Real Año 1",
				  "Valor Real Año 2",
				  "Valor Real Año 3",
				  "Valor Real Años 1 2",
				  "Valor Real Años 1 2 3",
				  "Valor Real Acumulado",
				  "Valor Real Acumulado_Mes",
				  "Valor Plan Acumulado",
				   "Valor Plan Acumulado Normalizada",
				  "Valor Meta Año 1",
				  "Valor Meta Año 2",
				  "Valor Meta Año 3",
				  "Valor Meta Años 1 2",
				  "Valor Meta Años 1 2 3",
				  "Valor Reto",
				  "Valor Proyección Año 1",
				  "Valor Proyección Año 2",
				  "Valor Proyección Año 3",
				  "Valor Proyección Años 1 2",
				  "Valor Proyección Años 1 2 3",
				  "% Avance Acumulado ILP",
				  "% Avance ILP Años 1 2",
				  "% Avance ILP Año 1",
				  "% Cumplimiento Año 1",
				  "% Cumplimiento Año 2",
				  "% Cumplimiento Año 3",
				  "% Cumplimiento Años 1 2",
				  "% Cumplimiento Años 1 2 3",
				  "% Cumplimiento Acumulado",
				  "Valor Real Proyectado Año 1",
				  "Valor Real Proyectado Año 2",
				  "Valor Real Proyectado Año 3",
				  "Valor Real Proyectado Años 1 2",
				  "Valor Real Proyectado Años 1 2 3",
				  "_CC Reporta Periodo",
				  UnidadMedida,
				  FECHA_CARGA_SYNAPSE,
				  FECHA_PROXIMA_ACTUALIZA_SYNAPSE,
				  CM_RESUMEN   ,
				  "Premisas",
				  "Mensaje clave indicador",
				  "Hito/Ind Habilitador",
				  ACTIVOCUMPLIMIENTOMIN,
				  CUMPLIMIENTOMINIMO,
				  RECONOCIMIENTOMINIMO,
				  "Fecha",
				  "Mes",
				  ".CC Drill Through Detalle KPI Panel",
				  "_CC Drill Through Detalle KPI",
				  "_CC Hito/Ind",
				  "_CC Orden Eje/Palanca",
				  "Meta Años 1 2 3 para Brecha",
				  META_ANNIO_FINAL,
				  VLR_LIMITE_INFERIOR_ANNIO,
				  RECTA_ANNIO,
				  	------------------------ CALCULO DE P_ANNIO ----------------------------------------------------------
						 CASE --WHEN (MONTH(CAST(Periodo + '01' AS DATE)) <> 12)
							--THEN NULL
						 WHEN RECTA_ANNIO = 1 AND (CUMPLIMIENTOMINIMO IS NOT NULL) AND ("Valor Real Proyectado Años 1 2 3" IS NOT NULL) 
						      AND (META_ANNIO_FINAL IS NOT NULL OR META_ANNIO_FINAL <> 0) AND (ReconocimientoMinimo IS NOT NULL)
							THEN 
								 RECONOCIMIENTOMINIMO/100 + (1 -  RECONOCIMIENTOMINIMO/100)
									* (("Valor Real Proyectado Años 1 2 3" - (META_ANNIO_FINAL  * VLR_LIMITE_INFERIOR_ANNIO) / META_ANNIO_FINAL)) /
									((META_ANNIO_FINAL) - (META_ANNIO_FINAL * VLR_LIMITE_INFERIOR_ANNIO / META_ANNIO_FINAL))
						 ELSE NULL  END AS P_ANNIO

				 FROM #TEMPCVC_INDICADORES_ILP3)

	SELECT * INTO #TEMPCVC_INDICADORES_ILP4 FROM SUBNIVEL5;


	WITH SUBNIVEL6
	  AS ( SELECT "Año",
				  "Año Hito",
				  "Cargo Responsable de Medición",
				  "Cargo Responsable de Medición 2",
				  "Correo Responsable de Medición",
				  "Correo Responsable de Medición 2",
				  "Corto Plazo / Largo Plazo",
				  "Detalle Indicador",
				  "Eje o Palanca",
				  "Empresa",
				  "Fecha de Carga",
				  "FK Indicador",
				  "FK Parametrización Indicador",
				  "FK Tablero",
				  "Vigencia Tablero desde",
				  "Vigencia Tablero hasta",
				  "Frecuencia",
				  "Gerencia",
				  "Grupo",
				  "Grupo Segmento",
				  "Hito / Indicador",
				  "ID Indicador",
				  "Indicador Referente",
				  "Nivel",
				  "Nombre Indicador",
				  "Nombre Responsable de Medición",
				  "Nombre Responsable de Medición 2",
				  "Número de Decimales para el Cálculo",
				  "Objetivo",
				  "Periodo",
				  "Plan Acum Periodos",
				  "Periodo Año",
				  "Rutina",
				  "Secuencia / Orden",
				  "Segmento",
				  "Sentido",
				  "Sigla Área",
				  "Tablero",
				  "Tiempo",
				  "Tipo Tablero",
				  "Unidad de Negocio Nivel 2",
				  "Unidad de Negocio Nivel 3",
				  "Valor Peso Indicador",
				  "Versión",
				  "VP Ejecutiva",
				  "Valor Meta Normalizada Año 1",
				  "Valor Meta Normalizada Año 2",
				  "Valor Meta Normalizada Año 3",
				  "Valor Meta Normalizada Años 1 2",
				  "Valor Meta Normalizada Años 1 2 3",
				  "Valor Real Año 1",
				  "Valor Real Año 2",
				  "Valor Real Año 3",
				  "Valor Real Años 1 2",
				  "Valor Real Años 1 2 3",
				  "Valor Real Acumulado",
				  "Valor Real Acumulado_Mes",
				  "Valor Plan Acumulado",
				  CASE WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde"), '03') AND concat(year("Vigencia Tablero desde"),'05')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado Normalizada]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde"), '03')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde"), '06') AND concat(year("Vigencia Tablero desde"),'08')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado Normalizada]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde"), '06')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde"), '09') AND concat(year("Vigencia Tablero desde"),'11')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado Normalizada]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde"), '09')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						 
						 ---- Validacion Segundo año
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+1, '03') AND concat(year("Vigencia Tablero desde")+1,'05')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado Normalizada]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+1, '03')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+1, '06') AND concat(year("Vigencia Tablero desde")+1,'08')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado Normalizada]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+1, '06')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+1, '09') AND concat(year("Vigencia Tablero desde")+1,'11')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado Normalizada]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+1, '09')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						 
						 ---- Validacion Tercer año
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+2, '03') AND concat(year("Vigencia Tablero desde")+2,'05')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado Normalizada]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+2, '03')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+2, '06') AND concat(year("Vigencia Tablero desde")+2,'08')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado Normalizada]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+2, '06')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+2, '09') AND concat(year("Vigencia Tablero desde")+2,'11')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado Normalizada]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+2, '09')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")

				WHEN "Frecuencia" = 'Semestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde"), '06') AND concat(year("Vigencia Tablero desde"),'11')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado Normalizada]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde"), '06')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Semestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+1, '06') AND concat(year("Vigencia Tablero desde")+1,'11')) AND "Hito / Indicador" = 'Indicador'
				  THEN (SELECT [Valor Plan Acumulado Normalizada]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+1, '06')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				WHEN "Frecuencia" = 'Semestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+2, '06') AND concat(year("Vigencia Tablero desde")+2,'11')) AND "Hito / Indicador" = 'Indicador'
				   THEN (SELECT [Valor Plan Acumulado Normalizada]
						FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
						WHERE DTI.FK_TABLERO = "FK Tablero"
						   AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+2, '06')
						   AND DTI.[FK_INDICADOR] = "FK Indicador"
						   AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				ELSE [Valor Plan Acumulado Normalizada]  END AS "Valor Plan Acumulado Normalizada",
				  "Valor Meta Año 1",
				  "Valor Meta Año 2",
				  "Valor Meta Año 3",
				  "Valor Meta Años 1 2",
				  "Valor Meta Años 1 2 3",
				  "Valor Reto",
				  "Valor Proyección Año 1",
				  "Valor Proyección Año 2",
				  "Valor Proyección Año 3",
				  "Valor Proyección Años 1 2",
				  "Valor Proyección Años 1 2 3",
				  CASE WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde"), '03') AND concat(year("Vigencia Tablero desde"),'05')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Avance Acumulado ILP]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
								  WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde"), '03')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						  WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde"), '06') AND concat(year("Vigencia Tablero desde"),'08')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Avance Acumulado ILP]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
								  WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde"), '06')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						  WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde"), '09') AND concat(year("Vigencia Tablero desde"),'11')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Avance Acumulado ILP]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
								  WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde"), '09')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						 
						 ---- Validacion Segundo año
						 WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+1, '03') AND concat(year("Vigencia Tablero desde")+1,'05')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Avance Acumulado ILP]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
								  WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+1, '03')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						  WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+1, '06') AND concat(year("Vigencia Tablero desde")+1,'08')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Avance Acumulado ILP]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
								  WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+1, '06')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						  WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+1, '09') AND concat(year("Vigencia Tablero desde")+1,'11')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Avance Acumulado ILP]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
								  WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+1, '09')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						 
						 ---- Validacion Tercer año
						  WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+2, '03') AND concat(year("Vigencia Tablero desde")+2,'05')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Avance Acumulado ILP]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
								  WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+2, '03')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						  WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+2, '06') AND concat(year("Vigencia Tablero desde")+2,'08')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Avance Acumulado ILP]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
								  WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+2, '06')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						  WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+2, '09') AND concat(year("Vigencia Tablero desde")+2,'11')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Avance Acumulado ILP]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
								  WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+2, '09')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
				
						  WHEN "Frecuencia" = 'Semestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde"), '06') AND concat(year("Vigencia Tablero desde"),'11')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Avance Acumulado ILP]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
									WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde"), '06')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						  WHEN "Frecuencia" = 'Semestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+1, '06') AND concat(year("Vigencia Tablero desde")+1,'11')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Avance Acumulado ILP]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
									WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+1, '06')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						  WHEN "Frecuencia" = 'Semestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+2, '06') AND concat(year("Vigencia Tablero desde")+2,'11')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Avance Acumulado ILP]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
									WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+2, '06')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						  ELSE [% Avance Acumulado ILP]  END  AS [% Avance Acumulado ILP],
				  "% Avance ILP Años 1 2",
				  "% Avance ILP Año 1",
				  "% Cumplimiento Año 1",
				  "% Cumplimiento Año 2",
				  "% Cumplimiento Año 3",
				  "% Cumplimiento Años 1 2",
				  "% Cumplimiento Años 1 2 3",
				  "% Cumplimiento Acumulado",
				  "Valor Real Proyectado Año 1",
				  "Valor Real Proyectado Año 2",
				  "Valor Real Proyectado Año 3",
				  "Valor Real Proyectado Años 1 2",
				  "Valor Real Proyectado Años 1 2 3",
				  "_CC Reporta Periodo",
				  "UnidadMedida",
				  "FECHA_CARGA_SYNAPSE",
				  "FECHA_PROXIMA_ACTUALIZA_SYNAPSE",
				  "CM_RESUMEN"   ,
				  "Premisas",
				  "Mensaje clave indicador",
				  "Hito/Ind Habilitador",
				  "ACTIVOCUMPLIMIENTOMIN",
				  "CUMPLIMIENTOMINIMO",
				  "RECONOCIMIENTOMINIMO",
				  "Fecha",
				  "Mes",
				  ".CC Drill Through Detalle KPI Panel",
				  "_CC Drill Through Detalle KPI",
				  "_CC Hito/Ind",
				  "_CC Orden Eje/Palanca",
				  "Meta Años 1 2 3 para Brecha",
				  CONVERT(INT,CAST(Fecha AS DATETIME)) AS Orden,
				  CASE WHEN UPPER("Hito / Indicador") = 'HITO' and "Valor Real Acumulado" IS NOT NULL 
						 THEN 'ok'
					   WHEN (MONTH(Fecha)=1 AND (Frecuencia <> 'Mensual' AND Frecuencia IS NOT NULL)) 
						   OR (MONTH(Fecha)=2 AND (Frecuencia <> 'Mensual' AND Frecuencia IS NOT NULL))
						   OR (MONTH(Fecha)=3 AND (Frecuencia not in ('Mensual','Trimestral') AND Frecuencia IS NOT NULL))
						   OR (MONTH(Fecha)=4 AND (Frecuencia not in ('Mensual','Trimestral') AND Frecuencia IS NOT NULL))
						   OR (MONTH(Fecha)=5 AND (Frecuencia not in ('Mensual','Trimestral') AND Frecuencia IS NOT NULL))
						   OR (MONTH(Fecha)=6 AND (Frecuencia not in ('Mensual','Trimestral','Semestral') AND Frecuencia IS NOT NULL))
						   OR (MONTH(Fecha)=7 AND (Frecuencia not in ('Mensual','Trimestral','Semestral') AND Frecuencia IS NOT NULL))
						   OR (MONTH(Fecha)=8 AND (Frecuencia not in ('Mensual','Trimestral','Semestral') AND Frecuencia IS NOT NULL))
						   OR (MONTH(Fecha)=9 AND (Frecuencia not in ('Mensual','Trimestral','Semestral') AND Frecuencia IS NOT NULL))
						   OR (MONTH(Fecha)=10 AND (Frecuencia not in ('Mensual','Trimestral','Semestral') AND Frecuencia IS NOT NULL))
						   OR (MONTH(Fecha)=11 AND (Frecuencia not in ('Mensual','Trimestral','Semestral') AND Frecuencia IS NOT NULL))
						   OR (MONTH(Fecha)=12 AND (Frecuencia not in ('Mensual','Trimestral','Semestral','Anual') AND Frecuencia IS NOT NULL))
						 THEN 'Borrar'
					   ELSE 'OK' END AS Borrar,
				  ISNULL(Fecha,CAST('19000101' AS DATE)) AS Fecha_Final,
				  CAST(ISNULL("Secuencia / Orden",'99') AS INT) AS ".CC Secuencia/Orden",
				  "Periodo" + "Sigla Área" + CAST("FK Parametrización Indicador" AS VARCHAR) AS 'clave',
				  META_ANNIO_FINAL,
				  VLR_LIMITE_INFERIOR_ANNIO,
				  RECTA_ANNIO,
				  P_ANNIO,
	------------------------ CALCULO DE _CC % Cumplimiento ILP Val------------------------------
        CASE WHEN ACTIVOCUMPLIMIENTOMIN = 0 
	   THEN CASE WHEN "% Cumplimiento Años 1 2 3" IS NULL 
				   THEN NULL 
		         WHEN "% Cumplimiento Años 1 2 3" < 1
						THEN 0
				WHEN "% Cumplimiento Años 1 2 3" >= 1
						THEN 1
				 WHEN "% Cumplimiento Años 1 2 3" >= 1 AND "Valor Real Proyectado Años 1 2 3" >= 100
					THEN 1		
	             WHEN "% Cumplimiento Años 1 2 3" IS NOT NULL AND "Valor Real Acumulado" IS NULL
				   THEN NULL
			     ELSE CASE WHEN "% Cumplimiento Años 1 2 3" < 1
						THEN 0
					ELSE 1 END 
				END
	ELSE CASE-- WHEN (MONTH(Fecha) <> 12)
				      --     THEN NULL
			            WHEN ("Valor Real Acumulado" = 0 AND "Valor Meta Años 1 2 3" = 0 )
						   THEN 0	
						WHEN "% Cumplimiento Años 1 2 3" = 0
						   THEN 0
						WHEN "% Cumplimiento Años 1 2 3" >= 1
							THEN 1
						WHEN ((Sentido = 'Positivo' AND "% Cumplimiento Años 1 2 3" >= 1) OR (Sentido = 'Negativo' AND  "% Cumplimiento Años 1 2 3" >= 1))
					   	   THEN 1  
						WHEN ((Sentido = 'Positivo' AND "% Cumplimiento Años 1 2 3" >= 1) OR (Sentido = 'Negativo' AND  "% Cumplimiento Años 1 2 3" >= 1))
					   	   THEN 1  
						WHEN ((Sentido = 'Positivo' AND "% Cumplimiento Años 1 2 3" < 1 AND ("% Cumplimiento Años 1 2 3"< (CUMPLIMIENTOMINIMO/100))) 
								OR (Sentido = 'Negativo' AND  "% Cumplimiento Años 1 2 3" < 1) AND ("% Cumplimiento Años 1 2 3"< (CUMPLIMIENTOMINIMO/100)) 
								OR (Sentido IS NULL AND  "% Cumplimiento Años 1 2 3" < 1) AND ("% Cumplimiento Años 1 2 3"< (CUMPLIMIENTOMINIMO/100)))
					   	   THEN 0    
						WHEN (((CUMPLIMIENTOMINIMO IS NULL) AND ("Valor Real Acumulado" < "Valor Meta Años 1 2 3") AND Sentido ='Positivo'))
						   THEN 0
						WHEN (((CUMPLIMIENTOMINIMO IS NULL) AND ("Valor Real Acumulado" > "Valor Meta Años 1 2 3") AND Sentido ='Negativo')) 
						   THEN 0	
						WHEN (CUMPLIMIENTOMINIMO IS NOT NULL AND ("Valor Real Acumulado" = CUMPLIMIENTOMINIMO))
					       THEN CUMPLIMIENTOMINIMO      
						WHEN ("Valor Real Acumulado"  = "Valor Meta Años 1 2 3" AND "Valor Real Acumulado" IS NULL AND  "Valor Meta Años 1 2 3" IS NULL) 
						   THEN NULL
						WHEN ("Valor Real Acumulado"  = "Valor Meta Años 1 2 3") 
						   THEN META_ANNIO_FINAL
		  ELSE 
			  	P_ANNIO
		
					  END
		END AS "_CC % Cumplimiento ILP Val",
	"Meta Años 1 2 3 para Brecha" - "Valor Real Proyectado Años 1 2 3" AS "_CC Valor Brecha"

		   FROM #TEMPCVC_INDICADORES_ILP4)

	SELECT * INTO #TEMPCVC_INDICADORES_ILP5 FROM SUBNIVEL6;


	 WITH SUBNIVEL7
	  AS (SELECT CASE WHEN "% Avance Acumulado ILP" < 0 
						THEN 0
					  ELSE "% Avance Acumulado ILP" END AS "% Avance Acumulado ILP",
				 
		   CASE WHEN "% Avance ILP Años 1 2" < 0 
				  THEN 0 
				ELSE "% Avance ILP Años 1 2" END  AS "% Avance ILP Años 1 2",
		   CASE WHEN "% Avance ILP Año 1" < 0 
				  THEN 0
				ELSE "% Avance ILP Año 1" END AS "% Avance ILP Año 1",
		   CASE WHEN "% Cumplimiento Año 1" < 0 
				  THEN 0
				ELSE "% Cumplimiento Año 1" END AS "% Cumplimiento Año 1",
		   CASE WHEN "% Cumplimiento Año 2" < 0 
				  THEN 0
				ELSE "% Cumplimiento Año 2" END AS "% Cumplimiento Año 2",
		   CASE WHEN "% Cumplimiento Año 3" < 0 
				  THEN 0
				ELSE "% Cumplimiento Año 3" END AS "% Cumplimiento Año 3",
		   CASE WHEN "% Cumplimiento Años 1 2" < 0 
				  THEN 0
				ELSE "% Cumplimiento Años 1 2" END AS "% Cumplimiento Años 1 2",
		   CASE WHEN "% Cumplimiento Años 1 2 3" < 0 
				  THEN 0
				ELSE "% Cumplimiento Años 1 2 3" END AS "% Cumplimiento Años 1 2 3",
		   CASE WHEN "% Cumplimiento Acumulado" < 0 
				  THEN 0 
				ELSE CASE WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde"), '03') AND concat(year("Vigencia Tablero desde"),'05')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Cumplimiento Acumulado]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
								  WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde"), '03')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						  WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde"), '06') AND concat(year("Vigencia Tablero desde"),'08')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Cumplimiento Acumulado]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
								  WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde"), '06')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						  WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde"), '09') AND concat(year("Vigencia Tablero desde"),'11')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Cumplimiento Acumulado]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
								  WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde"), '09')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						 
						 ---- Validacion Segundo año
						 WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+1, '03') AND concat(year("Vigencia Tablero desde")+1,'05')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Cumplimiento Acumulado]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
								  WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+1, '03')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						  WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+1, '06') AND concat(year("Vigencia Tablero desde")+1,'08')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Cumplimiento Acumulado]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
								  WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+1, '06')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						  WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+1, '09') AND concat(year("Vigencia Tablero desde")+1,'11')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Cumplimiento Acumulado]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
								  WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+1, '09')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						 
						 ---- Validacion Tercer año
						  WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+2, '03') AND concat(year("Vigencia Tablero desde")+2,'05')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Cumplimiento Acumulado]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
								  WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+2, '03')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						  WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+2, '06') AND concat(year("Vigencia Tablero desde")+2,'08')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Cumplimiento Acumulado]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
								  WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+2, '06')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						  WHEN "Frecuencia" = 'Trimestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+2, '09') AND concat(year("Vigencia Tablero desde")+2,'11')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Cumplimiento Acumulado]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
								  WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+2, '09')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")

						  WHEN "Frecuencia" = 'Semestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde"), '06') AND concat(year("Vigencia Tablero desde"),'11')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Cumplimiento Acumulado]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
								  WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde"), '06')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						  WHEN "Frecuencia" = 'Semestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+1, '06') AND concat(year("Vigencia Tablero desde")+1,'11')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Cumplimiento Acumulado]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
									WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+1, '06')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						  WHEN "Frecuencia" = 'Semestral' AND ("Periodo" BETWEEN concat(year("Vigencia Tablero desde")+2, '06') AND concat(year("Vigencia Tablero desde")+2,'11')) AND "Hito / Indicador" = 'Indicador'
							THEN (SELECT [% Cumplimiento Acumulado]
								  FROM [ATOMO].[CVC_DESEMPENO_TABLERO_ILP] AS DTI
								  WHERE DTI.FK_TABLERO = "FK Tablero"
									  AND DTI.[DESC_PERIODO] = concat(year("Vigencia Tablero desde")+2, '06')
									  AND DTI.[FK_INDICADOR] = "FK Indicador"
									  AND DTI.[FK_PARAM_INDICADOR] = "FK Parametrización Indicador")
						  ELSE [% Cumplimiento Acumulado] END END AS [% Cumplimiento Acumulado],

		   ".CC Drill Through Detalle KPI Panel",
		   "_CC Drill Through Detalle KPI",
		   "_CC Hito/Ind",
		   "_CC Orden Eje/Palanca"
		   "_CC Reporta Periodo",
		   LEFT("Tiempo",4) AS "Año",
		   "Cargo Responsable de Medición",
		   "Cargo Responsable de Medición 2",
		   "Correo Responsable de Medición",
		   "Correo Responsable de Medición 2",
		   "Corto Plazo / Largo Plazo",
		   "Detalle Indicador",
		   "Eje o Palanca",
		   "Empresa",
		   "Fecha de Carga",
		   "FK Indicador",
		   "FK Parametrización Indicador",
		   "FK Tablero",
		   CAST("Vigencia Tablero desde" AS DATE) AS "Vigencia Tablero desde",
		   CAST("Vigencia Tablero hasta" AS DATE) AS "Vigencia Tablero hasta",
		   "Frecuencia",
		   "Gerencia",
		   "Grupo",
		   "Grupo Segmento",
		   "Hito / Indicador",
		   "ID Indicador",
		   "Indicador Referente",
		   UPPER(LEFT("Mes", 1)) + LOWER(SUBSTRING("Mes", 2, LEN("Mes"))) AS "Mes",
		   "Nivel",
		   "Nombre Indicador",
		   "Nombre Responsable de Medición",
		   "Nombre Responsable de Medición 2",
		   "Número de Decimales para el Cálculo",
		   "Objetivo",
		   "Periodo",
		   "Año Hito",
		   "Plan Acum Periodos",
		   "Periodo Año",
		   "Rutina",
		   "Secuencia / Orden",
		   "Segmento",
		   "Sentido",
		   "Sigla Área",
		   "Tablero",
		   "Tiempo",
		   "Tipo Tablero",
		   "UnidadMedida",
		   "Unidad de Negocio Nivel 2",
		   "Unidad de Negocio Nivel 3",
		   "Valor Peso Indicador",
		   "Valor Meta Normalizada Año 1",
		   "Valor Meta Normalizada Año 2",
		   "Valor Meta Normalizada Año 3",
		   "Valor Meta Normalizada Años 1 2",
		   "Valor Meta Normalizada Años 1 2 3",
		   [Valor Plan Acumulado] ,
		   [Valor Plan Acumulado Normalizada],
		   "Valor Meta Año 1",
		   "Valor Meta Año 2",
		   "Valor Meta Año 3",
		   "Valor Meta Años 1 2",
		   "Valor Meta Años 1 2 3",
		   "Valor Reto",
		   "Valor Proyección Año 1",
		   "Valor Proyección Año 2",
		   "Valor Proyección Año 3",
		   "Valor Proyección Años 1 2",
		   "Valor Proyección Años 1 2 3",
		   "Valor Real Año 1",
		   "Valor Real Año 2",
		   "Valor Real Año 3",
		   "Valor Real Años 1 2",
		   "Valor Real Años 1 2 3",
		   [Valor Real Acumulado],
		   "Valor Real Acumulado_Mes",
		   "Valor Real Proyectado Año 1",
		   "Valor Real Proyectado Año 2",
		   "Valor Real Proyectado Año 3",
		   "Valor Real Proyectado Años 1 2",
		   "Valor Real Proyectado Años 1 2 3",
		   "Versión",
		   "VP Ejecutiva",
		   FECHA_CARGA_SYNAPSE,
		   FECHA_PROXIMA_ACTUALIZA_SYNAPSE,
		   CM_RESUMEN   ,
		   "Premisas",
		   "Mensaje clave indicador",
		   "Hito/Ind Habilitador",
		   "Nombre Indicador" + ' - ' + "Detalle Indicador" AS ".CC Nombre Indicador - Detalle",
		   CAST(Fecha AS VARCHAR) + Objetivo AS "Llave",
		   "_CC % Cumplimiento ILP Val",
		   "_CC % Cumplimiento ILP Val" * "Valor Peso Indicador" AS ".CC % Cumplimiento tablero Ban",
		   "_CC Valor Brecha",
		   CASE WHEN UPPER("Sentido") = 'POSITIVO' 
				  THEN CASE WHEN "_CC Valor Brecha" > 0 
							  THEN 'Verde'
							WHEN "_CC Valor Brecha" < 0 
							  THEN 'Rojo' 
							ELSE 'Negro' END
				ELSE CASE WHEN UPPER("Sentido") = 'NEGATIVO' 
							THEN CASE 
						  WHEN "_CC Valor Brecha" > 0 
							THEN 'Rojo'
						  WHEN "_CC Valor Brecha" < 0 
							THEN 'Verde'
						  ELSE 'Negro' END
				ELSE NULL END END AS "CC Color Brecha",
		   CASE WHEN "ACTIVOCUMPLIMIENTOMIN" IS NULL
		          THEN 0 
				ELSE "ACTIVOCUMPLIMIENTOMIN" END AS "ActivoCumplimientoMin",
		   "CUMPLIMIENTOMINIMO" AS "CumplimientoMinimo",
		   "RECONOCIMIENTOMINIMO" AS "ReconocimientoMinimo"
	
		   FROM #TEMPCVC_INDICADORES_ILP5 F1
		   WHERE F1."Sigla Área" = 'ILP')


INSERT INTO ATOMO.TMP2CVC_INDICADORES_ILP
SELECT * FROM SUBNIVEL7;

INSERT INTO [ATOMO].[TEMPCVC_INDICADORES_ILP_replica]
SELECT "FK Indicador",
	"FK Parametrización Indicador",
	"FK Tablero",
	"Periodo",
	"Tiempo",
	"Valor Meta Normalizada Año 1",
	"Valor Meta Normalizada Año 2",
	"Valor Meta Normalizada Año 3",
	"Valor Meta Normalizada Años 1 2",
	"Valor Meta Normalizada Años 1 2 3",
	"Valor Real Acumulado",
	"Valor Plan Acumulado",
	"Valor Plan Acumulado Normalizada",
	"Valor Meta Año 1",
	"Valor Meta Año 2",
	"Valor Meta Año 3",
	"Valor Meta Años 1 2",
	"Valor Meta Años 1 2 3",
	"% Avance Acumulado ILP",
	"% Cumplimiento Acumulado",
	"% Avance ILP Años 1 2",
	"% Avance ILP Año 1",
	"% Cumplimiento Año 1",
	"% Cumplimiento Año 2",
	"% Cumplimiento Año 3",
	"% Cumplimiento Años 1 2",
	"% Cumplimiento Años 1 2 3",
	"Valor Real Proyectado Año 1",
	"Valor Real Proyectado Año 2",
	"Valor Real Proyectado Año 3",
	"Valor Real Proyectado Años 1 2",
    "Valor Real Proyectado Años 1 2 3"

FROM [ATOMO].[TMP2CVC_INDICADORES_ILP]
WHERE "Periodo" = concat("Año Hito", '12')
   AND "FK Tablero" = "FK Tablero"
   AND "FK Indicador" = "FK Indicador"
   AND "FK Parametrización Indicador" = "FK Parametrización Indicador"
   
GROUP BY "FK Indicador",
		"FK Parametrización Indicador",
		"FK Tablero",
		"Periodo",
		"Tiempo",
		"Valor Meta Normalizada Año 1",
		"Valor Meta Normalizada Año 2",
		"Valor Meta Normalizada Año 3",
		"Valor Meta Normalizada Años 1 2",
		"Valor Meta Normalizada Años 1 2 3",
		"Valor Real Acumulado",
		"Valor Plan Acumulado",
		"Valor Plan Acumulado Normalizada",
		"Valor Meta Año 1",
		"Valor Meta Año 2",
		"Valor Meta Año 3",
		"Valor Meta Años 1 2",
		"Valor Meta Años 1 2 3",
		"% Avance Acumulado ILP",
		"% Cumplimiento Acumulado",
		"% Avance ILP Años 1 2",
		"% Avance ILP Año 1",
		"% Cumplimiento Año 1",
		"% Cumplimiento Año 2",
		"% Cumplimiento Año 3",
		"% Cumplimiento Años 1 2",
		"% Cumplimiento Años 1 2 3",
		"Valor Real Proyectado Año 1",
		"Valor Real Proyectado Año 2",
		"Valor Real Proyectado Año 3",
		"Valor Real Proyectado Años 1 2",
		"Valor Real Proyectado Años 1 2 3";
GO
