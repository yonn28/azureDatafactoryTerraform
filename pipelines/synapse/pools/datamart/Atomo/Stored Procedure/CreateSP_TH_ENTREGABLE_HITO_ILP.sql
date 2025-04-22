
-- =============================================
-- Author:      Maria Alejandra Delgado
-- Create Date: 202-05-16
-- Description: Se crea el procedimiento para la carga de la tabla temp TMP2CVC_TH_ENTREGABLE_HITO_ILP la cual es un insumo para la tabla TH_ENTREGABLE_HITO_ILP
-- =============================================

CREATE PROC [ATOMO].[SP_TH_ENTREGABLE_HITO_ILP] AS 
	 SET NOCOUNT ON;

		IF OBJECT_ID('tempdb..#TEMPCVC_TH_ENTREGABLE_HITO_ILP1') IS NOT NULL
		BEGIN
			DROP TABLE #TEMPCVC_TH_ENTREGABLE_HITO_ILP1
		END;

	IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] like '%TMP2CVC_TH_ENTREGABLE_HITO_ILP%') 
	BEGIN
	   TRUNCATE TABLE [ATOMO].[TMP2CVC_TH_ENTREGABLE_HITO_ILP];
	END;

		IF EXISTS(SELECT [name] FROM sys.tables WHERE [name] like '%TEMPCVC_TH_ENTREGABLE_HITO_ILP_replica%') 
	BEGIN
	   DROP TABLE [ATOMO].[TEMPCVC_TH_ENTREGABLE_HITO_ILP_replica];
	END;


WITH SUNBIVEL1 
AS (SELECT C.FK_INDICADOR AS FK_HITO,
	C.FK_PARAM_INDICADOR,
	C.GK_ENTREGABLE_HITO AS FK_ENTREGABLE,
	C.FK_PERIODO,
	D.DTM_FECHA_EJECUCION_REAL,
	D.DESC_CAUSAS,
	D.DESC_ACCIONES,
	D.DESC_PREMISA_ESC_BAJO_ENTREGABLE,
	D.DESC_PREMISA_ESC_MEDIO_ENTREGABLE,
	D.DESC_PREMISA_ESC_ALTO_ENTREGABLE,
	D.DESC_CORREO_USUARIO,
	D.DTM_FECHA_EVENTO_REGISTRO,
	D.DTM_FECHACARGA,
	D.VLR_PLAN_ENTREGABLE,
	D.VLR_REAL_ENTREGABLE,
	D.PRC_CUMP_ENTREGABLE,
	D.VLR_REAL_FINAL_ENTREGABLE,
	D.VLR_PROY_ESC_BAJO_ENTREGABLE,
	D.VLR_PROY_ESC_MEDIO_ENTREGABLE,
	D.VLR_PROY_ESC_ALTO_ENTREGABLE,
	D.VLR_CUMP_ESC_BAJO_ENTREGABLE,
	D.VLR_CUMP_ESC_MEDIO_ENTREGABLE,
	D.VLR_CUMP_ESC_ALTO_ENTREGABLE
 FROM
( 
 	SELECT * FROM
	(	SELECT CAST(COD_PERIODO AS INT) AS FK_PERIODO
		FROM [ATOMO].[CVD_AUX_TIEMPO_CARGA]) AS A
	INNER JOIN
	(
	SELECT 
		GK_ENTREGABLE_HITO,
		FK_INDICADOR,
		FK_PARAM_INDICADOR,
		DTM_FECHA_USAR
	 FROM [ATOMO].[DWH.DIM_ENTREGABLES_HITO]
	) AS B 
  ON  LEFT(A.FK_PERIODO, 4) = YEAR(B.DTM_FECHA_USAR)
) AS C
LEFT JOIN  (SELECT FK_HITO,
			FK_PARAM_INDICADOR,
			FK_ENTREGABLE,
			FK_PERIODO,
			DTM_FECHA_EJECUCION_REAL,
			DESC_CAUSAS,
			DESC_ACCIONES,
			DESC_PREMISA_ESC_BAJO_ENTREGABLE,
			DESC_PREMISA_ESC_MEDIO_ENTREGABLE,
			DESC_PREMISA_ESC_ALTO_ENTREGABLE,
			DESC_CORREO_USUARIO,
			DTM_FECHA_EVENTO_REGISTRO,
			DTM_FECHACARGA,
			VLR_PLAN_ENTREGABLE,
			VLR_REAL_ENTREGABLE,
			PRC_CUMP_ENTREGABLE,
			VLR_REAL_FINAL_ENTREGABLE,
			VLR_PROY_ESC_BAJO_ENTREGABLE,
			VLR_PROY_ESC_MEDIO_ENTREGABLE,
			VLR_PROY_ESC_ALTO_ENTREGABLE,
			VLR_CUMP_ESC_BAJO_ENTREGABLE,
			VLR_CUMP_ESC_MEDIO_ENTREGABLE,
			VLR_CUMP_ESC_ALTO_ENTREGABLE

		 FROM [ATOMO].[DWH.FACT_ENTREGABLE_HITO]
        ) AS D
	ON C.GK_ENTREGABLE_HITO = D.FK_ENTREGABLE 
	AND C.FK_INDICADOR = D.FK_HITO 
	AND C.FK_PARAM_INDICADOR = D.FK_PARAM_INDICADOR 
	AND C.FK_PERIODO = D.FK_PERIODO),

SUBNIVEL2  AS  (
		   SELECT 
			
		   te."VLR_CUMP_ESC_MEDIO_ENTREGABLE" AS "Valor cumplimiento escenario medio entregable", 
	       ct."Periodo_Vigencia",
		   ht."DESC_ANNIO_HITO" AS "Año Hito",
		   te."DESC_ACCIONES" AS "Acciones", 
           te."DESC_CAUSAS" AS "Causas", 
           te."DTM_FECHA_EJECUCION_REAL" AS "Fecha de ejecución real",
           te."FK_ENTREGABLE" AS "Llave foránea entregable", 
           diilp."Tablero" AS "Nombre del tablero", 
           diilp."FK Tablero" AS "LLave foranea del tablero", 
           te."FK_PARAM_INDICADOR" AS "Llave foránea parámetro indicador", 
           substring(ct."Periodo_Vigencia", 1, 4)  + substring(cast(te."FK_PERIODO" AS VARCHAR(6)),5,6) AS "Periodo", 
		   te."FK_PERIODO",
           te."DESC_PREMISA_ESC_ALTO_ENTREGABLE" AS "Premisa escenario alto entregable", 
           te."DESC_PREMISA_ESC_BAJO_ENTREGABLE" AS "Premisa escenario bajo entregable", 
           te."DESC_PREMISA_ESC_MEDIO_ENTREGABLE" AS "Premisa escenario medio entregable", 
           te."PRC_CUMP_ENTREGABLE" AS "Porcentaje cumplimiento entregable", 
           te."VLR_CUMP_ESC_ALTO_ENTREGABLE" AS "Valor cumplimiento escenario alto entregable", 
           te."VLR_CUMP_ESC_BAJO_ENTREGABLE" AS "Valor cumplimiento escenario bajo entregable",
	       te."VLR_PROY_ESC_ALTO_ENTREGABLE" AS "Valor proyección escenario alto entregable", 
           te."VLR_PROY_ESC_BAJO_ENTREGABLE" AS "Valor proyección escenario bajo entregable", 
           te."VLR_PROY_ESC_MEDIO_ENTREGABLE" AS "Valor proyección escenario medio entregable",
           te."VLR_REAL_ENTREGABLE" AS "Valor real entregable", 
           te."VLR_REAL_FINAL_ENTREGABLE" AS "Valor real final entregable",  
		   CONVERT(DATE, ((substring(ct."Periodo_Vigencia", 1, 4)+substring(cast(te."FK_PERIODO" AS VARCHAR(6)), 5,6))+'01')) AS "Fecha",
           de.".Peso Entregable" AS "CVC_ENTREGABLES_HITO..Peso Entregable", 
           de."DESC_ENTREGABLE" AS "CVC_ENTREGABLES_HITO.Descripción Entregable", 
           de."DTM_FECHA_ENTREGABLE" AS "CVC_ENTREGABLES_HITO.Fecha del Entregable", 
           de."FK_PARAM_INDICADOR" AS "Llave foránea Parametrización Indicador",
           de."DESC_NOMBRE_INDICADOR" AS "CVC_ENTREGABLES_HITO.Nombre Hito",
           de."DESC_UNIDAD_MEDIDA" AS "CVC_ENTREGABLES_HITO.Unidad de Medida", 
           de."VLR_PESO_ENTREGABLE" AS "CVC_ENTREGABLES_HITO.Peso del Entregable", 
           de."VLR_PLAN_ENTREGABLE" AS "CVC_ENTREGABLES_HITO.Plan Entregable", 
           da."DESC_ACTIVIDAD" AS "CVD_ACTIVIDADES_ENTREGABLES_HITO.Descripción Actividad",
           da."DTM_FECHA_ACTIVIDAD" AS "CVD_ACTIVIDADES_ENTREGABLES_HITO.Fecha de Actividad", 
           da."GK_ACTIVIDAD_ENTREGABLE_HITO" AS "CVD_ACTIVIDADES_ENTREGABLES_HITO.GK_ACTIVIDAD_ENTREGABLE_HITO", 
           ct."DESC_TABLERO_CVR" AS "CVD_CONFIGURACION_TABLERO.DESC_TABLERO_CVR", 
           ct.[DESC_DETALLE_INDICADOR] AS "CVD_CONFIGURACION_TABLERO.Detalle Indicador", 
           ct.[DESC_SIGLA_AREA] AS "CVD_CONFIGURACION_TABLERO.Sigla Área", 
           ct.[DESC_TABLERO] AS "CVD_CONFIGURACION_TABLERO.Tablero", 
           CASE WHEN ((ct."DESC_TBG" is null  OR ct."DESC_TBG" = ''))
                  THEN 'No' ELSE ct."DESC_TBG" END AS "CVD_CONFIGURACION_TABLERO.TBG",
           ct."VLR_PESO_INDICADOR" AS "CVD_CONFIGURACION_TABLERO.Valor Peso Indicador", 
           substring(ct."Periodo_Vigencia", 1, 4)+substring(cast(te."FK_PERIODO" AS VARCHAR(6)), 4,6)+'-'+cast(te."FK_ENTREGABLE" AS VARCHAR)+'-'+cast(da."GK_ACTIVIDAD_ENTREGABLE_HITO" AS VARCHAR) AS ".Llave Actividad Entregable", 
           ((de."DESC_NOMBRE_INDICADOR"+' - ')+ct.[DESC_DETALLE_INDICADOR]) AS ".CC Nombre Indicador - Detalle",
           dt."% Cumplimiento Acumulado" AS "_CC Cumplimiento Acumulado", 
           dt."% Cumplimiento Año Esc Alto" AS "_CC Proy Año Hito Alto", 
           dt."% Cumplimiento Año Esc Bajo" AS "_CC Proy Año Hito Bajo", 
           dt."% Cumplimiento Año Esc Medio" AS "_CC Proy Año Hito Medio", 
           diilp."CM_RESUMEN" 
		   
		   FROM [ATOMO].[CVC_TH_ENTREGABLE_HITO] AS te 
				 LEFT JOIN [ATOMO].[CVC_DESEMPENO_INDICADORES_TABLERO_ILP] AS diilp
					 ON te."FK_PARAM_INDICADOR" = diilp.[FK Parametrización Indicador]
					 AND te."FK_PERIODO" = diilp."Periodo"
				 LEFT JOIN [ATOMO].[CVC_ENTREGABLES_HITO] AS de 
					 ON te."FK_ENTREGABLE" = de."GK_ENTREGABLE_HITO" 
				 LEFT JOIN [ATOMO].[CVD_ACTIVIDADES_ENTREGABLES_HITO] AS da
					 ON te."FK_ENTREGABLE" = da."FK_ENTREGABLE_HITO" 
				 LEFT JOIN [ATOMO].[CVD_CONFIGURACION_TABLERO_ILP] AS ct
					 ON te."FK_PARAM_INDICADOR" = ct.[FK_PARAM_INDICADOR]
					 AND diilp."FK Tablero" = ct.[FK_TABLERO]
				 LEFT JOIN [ATOMO].[CVC_DESEMPENO_INDICADORES_TABLERO] AS dt 
					 ON dt."FK Parametrización Indicador" = te."FK_PARAM_INDICADOR" 
					AND dt."Periodo" = te."FK_PERIODO" 
					AND dt."Sigla Área" = ct.[DESC_SIGLA_AREA]
					AND diilp."FK Tablero" = dt."FK Tablero"
				 LEFT JOIN [ATOMO].[CVC_HITO_TABLERO_ILP]  AS ht
					ON te."FK_PARAM_INDICADOR" = ht."FK_PARAM_INDICADOR"
					AND te."FK_PERIODO" = ht."FK_PERIODO"
					AND diilp."FK Tablero" = ht.FK_TABLERO
				)

SELECT * INTO #TEMPCVC_TH_ENTREGABLE_HITO_ILP1 FROM SUBNIVEL2;

WITH SUBNIVEL3  
	  AS (
		SELECT 	 	   
		   "Valor cumplimiento escenario medio entregable",
		   "Periodo", 
		   "Año Hito",
		   "Acciones", 
           "Causas", 
		   "Periodo_Vigencia",
           "Fecha de ejecución real",
           "Llave foránea entregable", 
           "Nombre del tablero", 
           "LLave foranea del tablero", 
           "Llave foránea parámetro indicador", 
           "Premisa escenario alto entregable", 
           "Premisa escenario bajo entregable", 
           "Premisa escenario medio entregable", 
           "Porcentaje cumplimiento entregable", 
           "Valor cumplimiento escenario alto entregable", 
           "Valor cumplimiento escenario bajo entregable",
	       "Valor proyección escenario alto entregable", 
           "Valor proyección escenario bajo entregable", 
           "Valor proyección escenario medio entregable",
           "Valor real entregable", 
           "Valor real final entregable",  
		   "Fecha",
           "CVC_ENTREGABLES_HITO..Peso Entregable", 
           "CVC_ENTREGABLES_HITO.Descripción Entregable", 
           "CVC_ENTREGABLES_HITO.Fecha del Entregable", 
           "Llave foránea Parametrización Indicador",  
           "CVC_ENTREGABLES_HITO.Nombre Hito",
           "CVC_ENTREGABLES_HITO.Unidad de Medida", 
           "CVC_ENTREGABLES_HITO.Peso del Entregable", 
           "CVC_ENTREGABLES_HITO.Plan Entregable", 
           "CVD_ACTIVIDADES_ENTREGABLES_HITO.Descripción Actividad",
           "CVD_ACTIVIDADES_ENTREGABLES_HITO.Fecha de Actividad", 
           "CVD_ACTIVIDADES_ENTREGABLES_HITO.GK_ACTIVIDAD_ENTREGABLE_HITO", 
           "CVD_CONFIGURACION_TABLERO.DESC_TABLERO_CVR", 
           "CVD_CONFIGURACION_TABLERO.Detalle Indicador", 
           "CVD_CONFIGURACION_TABLERO.Sigla Área", 
           "CVD_CONFIGURACION_TABLERO.Tablero", 
           "CVD_CONFIGURACION_TABLERO.TBG",
           "CVD_CONFIGURACION_TABLERO.Valor Peso Indicador", 
           ".Llave Actividad Entregable", 
           ".CC Nombre Indicador - Detalle",
           "_CC Cumplimiento Acumulado", 
           "_CC Proy Año Hito Alto", 
           "_CC Proy Año Hito Bajo", 
           "_CC Proy Año Hito Medio", 
           "CM_RESUMEN" 
			
		   FROM   #TEMPCVC_TH_ENTREGABLE_HITO_ILP1 
		   ) 

INSERT INTO ATOMO.TMP2CVC_TH_ENTREGABLE_HITO_ILP
SELECT * FROM SUBNIVEL3;


SELECT distinct "Valor cumplimiento escenario medio entregable",
				"Valor proyección escenario medio entregable",
				"Fecha de ejecución real",
				"Valor real entregable",
				"Porcentaje cumplimiento entregable",
				"Valor real final entregable",
				"_CC Proy Año Hito Medio",
				"_CC Cumplimiento Acumulado",
				"CM_RESUMEN",
				"Periodo_Vigencia",
				"Periodo",
				"Año Hito", 
				"Llave foránea parámetro indicador", 
				"LLave foranea del tablero","Llave foránea entregable", 
				count("Llave foránea entregable") AS Duplicados
INTO [ATOMO].[TEMPCVC_TH_ENTREGABLE_HITO_ILP_replica]
FROM [ATOMO].[TMP2CVC_TH_ENTREGABLE_HITO_ILP] 
WHERE "Periodo" = concat("Año Hito", '12')
and  "Llave foránea parámetro indicador" = "Llave foránea parámetro indicador"
and "LLave foranea del tablero" = "LLave foranea del tablero"
and "Llave foránea entregable" = "Llave foránea entregable"
GROUP BY 
"Valor cumplimiento escenario medio entregable",
"Valor proyección escenario medio entregable",
"Fecha de ejecución real",
"Valor real entregable",
"Porcentaje cumplimiento entregable",
"Valor real final entregable",
"_CC Proy Año Hito Medio",
"_CC Cumplimiento Acumulado",
"CM_RESUMEN",
"Periodo_Vigencia",
"Periodo",
"Año Hito", 
"Llave foránea parámetro indicador", 
"LLave foranea del tablero",
"Llave foránea entregable"

GO