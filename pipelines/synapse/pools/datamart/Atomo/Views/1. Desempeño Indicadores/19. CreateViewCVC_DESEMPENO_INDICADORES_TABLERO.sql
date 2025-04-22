
-- =============================================
-- Author:      Diego Rangel
-- Create Date: 2022-06-02
-- Description: Se crea la vista CVC_DESEMPENO_INDICADORES_TABLERO la cual es un insumo para el tablero Paneles y TBG's

-- Updated by:   Oscar Angel
-- Updated Date: 2022-06-30
-- Description: Se realiza la adición de los campos VLR_LIMITE_SUPERIOR_PERIODO y VLR_LIMITE_INFERIOR_PERIODO los cuales son necesario para visualizar el semaforo "_CC Semaforo TBG Per" de manera correcta en el tablero Paneles y TBG's

-- Updated by:   Oscar Angel
-- Updated Date: 2022-09-03
-- Description: Se realiza la adición de varios campos por combinación de las iniciativas Atomo ILP y UX
-- =============================================

CREATE VIEW [ATOMO].[CVC_DESEMPENO_INDICADORES_TABLERO]
AS SELECT "% Cumplimiento Acumulado"
		,"% Cumplimiento Año Esc Alto"
		,"% Cumplimiento Año Esc Bajo"
		,"% Cumplimiento Año Esc Medio"
		,"% Cumplimiento Periodo"
		,"% Desempeño Acumulado"
		,"% Desempeño Año Esc Alto"
		,"% Desempeño Año Esc Bajo"
		,"% Desempeño Año Esc Medio"
		,"% Desempeño Periodo"
		,".CC Drill Through Detalle KPI Panel"
		,".CC Secuencia/Orden"
		,".CC Semaforo Reporta Periodo"
		,"_CC Drill Through Detalle KPI"
		,"_CC Hito/Ind"
		,"_CC Negativo"
		,"_CC NegativoNeg"
		,"_CC Orden Eje/Palanca"
		,"_CC Panel / TBG"
		,"_CC Positivo"
		,"_CC Reporta Periodo"
		,"_CC Semaforo TBG Acum"
		,CASE WHEN "Real Acumulado" = 0 AND "CVR Año Decimal" = 0 AND "_CC Semaforo TBG Acum CVR" = 5 
		        THEN 1 
			  ELSE "_CC Semaforo TBG Acum CVR" END AS "_CC Semaforo TBG Acum CVR"
		,"_CC Semaforo TBG Per"
		,"_CC Semaforo TBG Proy Alto"
		,"_CC Semaforo TBG Proy Bajo"
		,"_CC Semaforo TBG Proy Medio"
		,"_CC URL Gauge"
		,"_CC Valor Cump Satisfacción"
		,"Acciones de Aseguramiento"
		,"Año"
		,"Borrar"
		,"Cargo Responsable de Medición"
		,"Cargo Responsable de Medición 2"
		,"Causas del Desempeño - Acum"
		,"Causas del Desempeño - Periodo"
		,"clave"
		,"Correo Responsable de Medición"
		,"Correo Responsable de Medición 2"
		,"Corto Plazo / Largo Plazo"
		,"CVR Año Decimal"
		,"CVR Esc Alto"
		,"CVR Esc Bajo"
		,"CVR Esc Medio"
		,"Detalle Indicador"
		,"Eje o Palanca"
		,"Numero Orden Palanca"
	    ,"Numero Orden Objetivo"
		,"Empresa"
		,"Fecha_Final" AS Fecha
		,"Fecha de Carga"
		,"FK Indicador"
		,"FK Parametrización Indicador"
		,"FK Tablero"
		,"Frecuencia"
		,"Gerencia"
		,"Grupo"
		,"Grupo Segmento"
		,"Hito / Indicador"
		,"ID Indicador"
		,"Indicador Referente"
		,"Limite Inferior CVR"
		,"Limite Superior CVR"
		,UPPER(LEFT("Mes", 1)) + LOWER(SUBSTRING("Mes", 2, LEN("Mes"))) AS "Mes"
		,"Meta Año"
		,"Meta Año +1"
		,"Meta Año +2"
		,"Meta Año Final"
		,"Meta Año Normalizado"
		,"Meta CVR"
		,"Meta Normalizada"
		,"MetaCalc"
		,"Nivel"
		,"Nombre Indicador"
		,"Nombre Responsable de Medición"
		,"Nombre Responsable de Medición 2"
		,"Número de Decimales para el Cálculo"
		,"Objetivo"
		,"Orden"
		,"Periodo"
		,"Plan Acumulado"
		,"Plan Acumulado Normalizado"
		,"Plan Periodo"
		,"Plan Periodo Normalizado"
		,"PlanAcumuladoCalc"
		,"PlanPeriodoCalc"
		,"Premisas Esc. Alto"
		,"Premisas Esc. Bajo"
		,"Premisas Esc. Medio"
		,"Proyección Año Esc Alto"
		,"Proyección Año Esc Bajo"
		,"Proyección Año Esc Medio"
		,"Proyección Periodo +1"
		,"Proyección Periodo +2"
		,"Proyección Periodo +3"
		,"Real Acumulado"
		,"Real Periodo"
		,"Rutina"
		,"Secuencia / Orden"
		,"Segmento"
		,"Sentido"
		,"Sigla Área"
		,"Tablero"
		,"Tiempo"
		,"Tipo Tablero"
		,"TituloTablero"
		,"Unidad de Negocio Nivel 2"
		,"Unidad de Negocio Nivel 3"
		,"UnidadMedida"
		,"URL"
		,"Valor Límite Inferior"
		,"Valor Límite Inferior Acumulado"
		,"Valor Límite Inferior Año"
		,"Valor Límite Superior"
		,"Valor Límite Superior Acumulado"
		,"Valor Límite Inferior Periodo"
		,"Valor Límite Superior Periodo"
		,"Valor Límite Superior Año"
		,"Valor num Límite Inferior"
		,"Valor num Límite Superior"
		,"Valor Peso Indicador"
		,"Versión"
		,"VP Ejecutiva"
		,FECHA_CARGA_SYNAPSE
		,FECHA_PROXIMA_ACTUALIZA_SYNAPSE
		,CM_RESUMEN
		,ESC_UX.DESCR_COMENTARIO AS Desc_Comentario
		,DESC_ESTANDAR
		,CASE
			WHEN "PlanAcumuladoCalc" is not null and "PlanAcumuladoCalc" < 0 and "Sentido"='Negativo' THEN "_CC NegativoNeg"
			WHEN "Sentido"='Positivo' THEN "_CC Positivo"
			WHEN "Sentido"='Negativo' THEN "_CC Negativo" 
			WHEN "Sentido" IS NULL and "Hito / Indicador"='Hito' THEN "_CC Positivo"
			ELSE 'Error'
		 END AS "_CC Estado Desemp Acum Semaforo"
		,CASE
			WHEN TBG='Si' then '1' + CAST(".CC Secuencia/Orden" AS VARCHAR) 
			ELSE '99' + CAST(".CC Secuencia/Orden" AS VARCHAR)
		 END AS ".CC TBG Secuencia / Orden"
		,ISNULL(TBG,'No') AS TBG
		,"Nombre Indicador" + ' - ' + "Detalle Indicador" AS ".CC Nombre Indicador - Detalle"
		,CAST(Fecha AS VARCHAR) + Objetivo AS Llave
		,CASE WHEN DESC_TABLERO_CVR = 'Áreas No CVR' THEN 'No TBG'
		      ELSE 'TBG'
		 END AS DESC_TABLERO_CVR
FROM
(
		SELECT *
		,CASE
			WHEN "_CC Reporta Periodo"='Si' THEN "_CC Semaforo TBG Per"
			ELSE "_CC Semaforo TBG Acum"
		 END AS ".CC Semaforo Reporta Periodo"
		,CONVERT(INT,CAST(Fecha AS DATETIME)) AS Orden
		,CASE
			WHEN UPPER("Hito / Indicador") = 'HITO' and "Real Acumulado" is not null THEN 'Ok'
			WHEN 
				(MONTH(Fecha)=1 and (Frecuencia <> 'Mensual' and Frecuencia is not null))
				OR (MONTH(Fecha)=2 and (Frecuencia <> 'Mensual' and Frecuencia is not null))
				OR (MONTH(Fecha)=3 and (Frecuencia not in ('Mensual','Trimestral') and Frecuencia is not null))
				OR (MONTH(Fecha)=4 and (Frecuencia not in ('Mensual','Trimestral') and Frecuencia is not null))
				OR (MONTH(Fecha)=5 and (Frecuencia not in ('Mensual','Trimestral') and Frecuencia is not null))
				OR (MONTH(Fecha)=6 and (Frecuencia not in ('Mensual','Trimestral','Semestral') and Frecuencia is not null))
				OR (MONTH(Fecha)=7 and (Frecuencia not in ('Mensual','Trimestral','Semestral') and Frecuencia is not null))
				OR (MONTH(Fecha)=8 and (Frecuencia not in ('Mensual','Trimestral','Semestral') and Frecuencia is not null))
				OR (MONTH(Fecha)=9 and (Frecuencia not in ('Mensual','Trimestral','Semestral') and Frecuencia is not null))
				OR (MONTH(Fecha)=10 and (Frecuencia not in ('Mensual','Trimestral','Semestral') and Frecuencia is not null))
				OR (MONTH(Fecha)=11 and (Frecuencia not in ('Mensual','Trimestral','Semestral') and Frecuencia is not null))
				OR (MONTH(Fecha)=12 and (Frecuencia not in ('Mensual','Trimestral','Semestral','Anual') and Frecuencia is not null))
				THEN 'Borrar'
			ELSE 'Ok'
		 END AS Borrar
		,isnull(Fecha,CAST('19000101' AS DATE)) AS Fecha_Final
		,CASE 
				WHEN TBG='Si' THEN 'https://image.flaticon.com/icons/png/512/57/57477.png' 
				ELSE 'https://chhattisgarh.mygov.in/sites/default/files/blank_0.jpg'
		 END AS "URL"
		 ,CAST(ISNULL("Secuencia / Orden",'99') AS INT) AS ".CC Secuencia/Orden"
		 ,"Periodo" + "Sigla Área" + CAST("FK Parametrización Indicador" AS VARCHAR) AS 'clave'
		 ,CASE 
				WHEN Mes='Dic' THEN 'https://1.bp.blogspot.com/-NxleHiAeoQo/TkWSkfq3bTI/AAAAAAAAA48/4mO09BcfJ4c/s1600/transparente.png'
				ELSE 'https://ecopetrol.sharepoint.com/:i:/r/sites/gin/Documentos%20compartidos/Cadena%20Suministro/BITACORA/Repositorio%20Imagenes/Toma%20Desiciones/blanco.png?csf=1&e=xhF0vd'
		  END AS "_CC URL Gauge"
		 ,CASE TBG
				WHEN 'Si' THEN 'TBG'
				WHEN 'No' THEN 'Panel'
				ELSE NULL
		  END AS "_CC Panel / TBG"
		 ,CASE 
				WHEN "Real Acumulado" is not null and PlanAcumuladoCalc is not null and "_CC Valor Cump Satisfacción" is not null 
					  and "Valor Límite Inferior Acumulado" IS NULL and "Real Acumulado" < "_CC Valor Cump Satisfacción" * PlanAcumuladoCalc THEN 'No Cumple' 
				WHEN "Real Acumulado" is not null and "Valor Límite Inferior Acumulado" is not null 
					  and "Real Acumulado" < "Valor Límite Inferior Acumulado" THEN 'No Cumple'
				WHEN "Real Acumulado" is not null and "PlanAcumuladoCalc" is not null and "_CC Valor Cump Satisfacción" is not null 
					  and "Valor Límite Superior Acumulado" IS NULL and "Real Acumulado" >= "_CC Valor Cump Satisfacción" * PlanAcumuladoCalc THEN 'Cumple'
				WHEN "Real Acumulado" is not null and "PlanAcumuladoCalc" is not null and "Real Acumulado"=0 and "PlanAcumuladoCalc"=0 THEN 'Cumple'
				WHEN "Real Acumulado" is not null and "_CC Valor Cump Satisfacción" is not null and "PlanAcumuladoCalc" is not null 
					  and "Valor Límite Superior Acumulado" is not null and "Real Acumulado" >="_CC Valor Cump Satisfacción" * PlanAcumuladoCalc 
					  and "Real Acumulado" < "Valor Límite Superior Acumulado" THEN 'Cumple'
				WHEN "Real Acumulado" is not null and "PlanAcumuladoCalc" IS NULL THEN 'Error'
				WHEN "Real Acumulado" is not null and "Valor Límite Inferior Acumulado" is not null and "_CC Valor Cump Satisfacción" is not null 
					  and "PlanAcumuladoCalc" is not null and "Real Acumulado" >= "Valor Límite Inferior Acumulado" 
					  and "Real Acumulado" < "_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc" THEN 'Riesgo'
				WHEN "Real Acumulado" is not null and "Valor Límite Superior Acumulado" is not null 
					  and "Real Acumulado" >= "Valor Límite Superior Acumulado" THEN 'Max'
				ELSE NULL
		   END AS "_CC Positivo"
		  ,CASE 
				WHEN "Real Acumulado" is not null and "_CC Valor Cump Satisfacción" is not null and "PlanAcumuladoCalc" is not null 
					 and "Valor Límite Inferior Acumulado" IS NULL and "Real Acumulado" > "_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc" THEN 'No Cumple'
				WHEN "Real Acumulado" is not null and "Valor Límite Inferior Acumulado" is not null 
					 and "Real Acumulado" > "Valor Límite Inferior Acumulado" THEN 'No Cumple'
				WHEN "Real Acumulado" is not null and "PlanAcumuladoCalc" is not null and "Real Acumulado"=0 and "PlanAcumuladoCalc"=0 THEN 'Cumple'
				WHEN "Real Acumulado" is not null and "_CC Valor Cump Satisfacción" is not null and "PlanAcumuladoCalc" is not null 
					 and "Valor Límite Superior Acumulado" IS NULL and "Real Acumulado" <= "_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc" THEN 'Cumple'
				WHEN "Real Acumulado" is not null and "_CC Valor Cump Satisfacción" is not null and "PlanAcumuladoCalc" is not null 
					 and "Valor Límite Superior Acumulado" is not null and "Real Acumulado" >= "Valor Límite Superior Acumulado" 
					 and "Real Acumulado" <= "_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc" THEN 'Cumple'
				WHEN "Real Acumulado" is not null and "PlanAcumuladoCalc" IS NULL THEN 'Error'
				WHEN "Real Acumulado" is not null and "Valor Límite Superior Acumulado" is not null 
					 and "Real Acumulado" < "Valor Límite Superior Acumulado" THEN 'Max'
				WHEN "Real Acumulado" is not null and "_CC Valor Cump Satisfacción" is not null and "PlanAcumuladoCalc" is not null 
					 and "Valor Límite Inferior Acumulado" is not null and "Real Acumulado" > "_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc" 
					 and "Real Acumulado"<="Valor Límite Inferior Acumulado" THEN 'Riesgo' 
				ELSE NULL
			END AS "_CC Negativo"
		   ,CASE
				WHEN "Real Acumulado" is not null and "_CC Valor Cump Satisfacción" is not null and "PlanAcumuladoCalc" is not null 
					 and "Valor Límite Inferior Acumulado" = null and "Real Acumulado" < "_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc" THEN 'No Cumple'
				WHEN "Real Acumulado" is not null and "Valor Límite Inferior Acumulado" is not null 
					 and "Real Acumulado" < "Valor Límite Inferior Acumulado" THEN 'No Cumple'
				WHEN "Real Acumulado" is not null and "_CC Valor Cump Satisfacción" is not null and "PlanAcumuladoCalc" is not null 
					 and "Valor Límite Superior Acumulado" IS NULL and "Real Acumulado" >= "_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc" THEN 'Cumple'
				WHEN "Real Acumulado" is not null and "PlanAcumuladoCalc" is not null and "Real Acumulado"=0 and "PlanAcumuladoCalc"=0 THEN 'Cumple'
				WHEN "Real Acumulado" is not null and "_CC Valor Cump Satisfacción" is not null and "PlanAcumuladoCalc" is not null 
					 and "Valor Límite Superior Acumulado" is not null and "Real Acumulado" >="_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc" 
					 and "Real Acumulado"<="Valor Límite Superior Acumulado" THEN 'Cumple'
				WHEN "Real Acumulado" is not null and "PlanAcumuladoCalc" IS NULL THEN 'Error'
				WHEN "Real Acumulado" is not null and "_CC Valor Cump Satisfacción" is not null and "PlanAcumuladoCalc" is not null 
					 and "Valor Límite Inferior Acumulado" is not null and "Real Acumulado" >= "Valor Límite Inferior Acumulado" 
					 and "Real Acumulado" < "_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc" THEN 'Riesgo'
				WHEN "Real Acumulado" is not null and "Valor Límite Superior Acumulado" is not null 
					 and "Real Acumulado" > "Valor Límite Superior Acumulado" THEN 'Max'
				ELSE NULL
			END AS "_CC NegativoNeg"		
		FROM 
		(
			SELECT  
				"Acciones de Aseguramiento",
				"Año",
				"Cargo Responsable de Medición",
				"Cargo Responsable de Medición 2",
				"Causas del Desempeño - Acum",
				"Causas del Desempeño - Periodo",
				"Correo Responsable de Medición",
				"Correo Responsable de Medición 2",
				"Corto Plazo / Largo Plazo",
				"Detalle Indicador",
				"Eje o Palanca",
				"Numero Orden Palanca",
	            "Numero Orden Objetivo",
				"Empresa",
				"Fecha de Carga",
				"FK Indicador",
				"FK Parametrización Indicador",
				"FK Tablero",
				"Frecuencia",
				"Gerencia",
				"Grupo",
				"Grupo Segmento",
				UPPER(LEFT("Hito / Indicador", 1)) + LOWER(SUBSTRING("Hito / Indicador", 2, LEN("Hito / Indicador"))) AS "Hito / Indicador",
				"ID Indicador",
				"Indicador Referente",
				"Limite Inferior CVR",
				"Limite Superior CVR",
				"Meta CVR",
				"Meta Normalizada",
				"Nivel",
				"Nombre Indicador",
				"Nombre Responsable de Medición",
				"Nombre Responsable de Medición 2",
				"Número de Decimales para el Cálculo",
				"Objetivo",
				"Periodo",
				"Premisas Esc. Alto",
				"Premisas Esc. Bajo",
				"Premisas Esc. Medio",
				"Rutina",
				REPLACE("Secuencia / Orden",'SIN CLASIFICAR','999') AS "Secuencia / Orden",
				"Segmento",
				"Sentido",
				"Sigla Área",
				"Tablero",
				"TBG",
				"Tiempo",
				"Tipo Tablero",
				"Unidad de Negocio Nivel 2",
				"Unidad de Negocio Nivel 3",
				"Valor Límite Inferior",
				"Valor Límite Superior",
				"Valor Peso Indicador",
				"Versión",
				"VP Ejecutiva",
				"DESC_TABLERO_CVR",
				"% Cumplimiento Acumulado",
				"% Cumplimiento Año Esc Alto",
				"% Cumplimiento Año Esc Bajo",
				"% Cumplimiento Año Esc Medio",
				"% Cumplimiento Periodo",
				"% Desempeño Acumulado",
				"% Desempeño Año Esc Alto",
				"% Desempeño Año Esc Bajo",
				"% Desempeño Año Esc Medio",
				"% Desempeño Periodo",
				CASE WHEN "Real Acumulado" = 0 AND "CVR Año Decimal" IS NULL
  				       THEN 0
					 ELSE "CVR Año Decimal" END AS "CVR Año Decimal",
				"CVR Esc Alto",
				"CVR Esc Bajo",
				"CVR Esc Medio",
				"Meta Año",
				"Meta Año +1",
				"Meta Año +2",
				"Meta Año Final",
				"Meta Año Normalizado",
				"Plan Acumulado",
				"Plan Acumulado Normalizado",
				"Plan Periodo",
				"Plan Periodo Normalizado",
				"Proyección Año Esc Alto",
				"Proyección Año Esc Bajo",
				"Proyección Año Esc Medio",
				"Proyección Periodo +1",
				"Proyección Periodo +2",
				"Proyección Periodo +3",
				"Real Acumulado",
				"Real Periodo",
				"Valor Límite Inferior Acumulado",
				"Valor Límite Inferior Año",
				"Valor Límite Superior Acumulado",
				"Valor Límite Inferior Periodo",
				"Valor Límite Superior Periodo",
				"Valor Límite Superior Año",
				"_CC Valor Cump Satisfacción",
				"PlanPeriodoCalc",
				"PlanAcumuladoCalc"	,
				"MetaCalc",
				DESC_VISUALIZA_PERIODO AS "_CC Reporta Periodo",
				DESC_UNIDAD_MEDIDA AS UnidadMedida,
				CAST(Periodo + '01' AS DATE) Fecha,
				REPLACE(FORMAT(CAST(Periodo + '01' AS DATE),'MMM','es-ES'),'.','') AS Mes,
				"Tablero" AS TituloTablero,
				CASE 
					WHEN UPPER("Hito / Indicador") = 'INDICADOR' THEN 'DetalleKPIPanel'
					ELSE 'DetalleSegHitosPanel'
				END AS ".CC Drill Through Detalle KPI Panel",
				CASE 
					WHEN UPPER("Hito / Indicador") = 'INDICADOR' THEN 'DetalleKPI'
					ELSE 'DetalleSegHitos'
				END AS "_CC Drill Through Detalle KPI",
				CASE 
					WHEN UPPER("Hito / Indicador") = 'INDICADOR' THEN '     I'
					WHEN UPPER("Hito / Indicador") = 'HITO' THEN '     H'
					ELSE "Hito / Indicador"
				END AS "_CC Hito/Ind",
				CASE "Eje o Palanca"
					WHEN 'Excelencia operacional HSE/ASP' THEN 1
					WHEN 'Estricta disciplina de capital' THEN 2
					WHEN 'Competitividad y sostenibilidad' THEN 3
					ELSE NULL
				END AS "_CC Orden Eje/Palanca",
				"Valor Límite Inferior" * "Plan Periodo" AS "Valor num Límite Inferior",
				"Valor Límite Superior" * "Plan Periodo" AS "Valor num Límite Superior",
				FECHA_CARGA_SYNAPSE,
				FECHA_PROXIMA_ACTUALIZA_SYNAPSE,
				CM_RESUMEN,
				DESC_ESTANDAR ,
			
			CASE WHEN "PlanAcumuladoCalc"<0 AND "Sentido"='Negativo' THEN
				CASE WHEN "% Cumplimiento Acumulado" IS NULL THEN 5 
				 WHEN "Valor Límite Inferior Acumulado" IS NULL AND "Real Acumulado"<("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 1
				 WHEN "Valor Límite Superior Acumulado" IS NULL AND "Real Acumulado">=("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 3
				 WHEN "Real Acumulado"<"Valor Límite Inferior Acumulado" THEN 1	    
			 	 WHEN "Real Acumulado">="Valor Límite Inferior Acumulado" AND "Real Acumulado"<("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 2 	 
			 	 WHEN "Real Acumulado"< "Valor Límite Superior Acumulado" AND "Real Acumulado">=("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 3
			 	 WHEN "Real Acumulado">="Valor Límite Superior Acumulado" THEN 4
				END
			 ELSE CASE WHEN "Sentido"='Positivo' THEN
			           CASE WHEN "% Cumplimiento Acumulado" IS NULL THEN 5 
						 WHEN "PlanAcumuladoCalc"=0 AND "Real Acumulado"<0 THEN 1	
						 WHEN "PlanAcumuladoCalc"=0 AND "Real Acumulado">=0 THEN 3
						 WHEN "Valor Límite Inferior Acumulado" IS NULL AND "Real Acumulado"<("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 1
						 WHEN "Valor Límite Superior Acumulado" IS NULL AND "Real Acumulado">=("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 3
						 WHEN "PlanAcumuladoCalc" IS NULL THEN 6
						 WHEN "Real Acumulado"=0 AND "PlanAcumuladoCalc"=0 THEN 3
						 WHEN "Real Acumulado"<"Valor Límite Inferior Acumulado" THEN 1
					 	 WHEN "Real Acumulado">="Valor Límite Inferior Acumulado" AND "Real Acumulado"<("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 2
					 	 WHEN "Real Acumulado"< "Valor Límite Superior Acumulado" AND "Real Acumulado">=("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 3
					 	 WHEN "Real Acumulado">="Valor Límite Superior Acumulado" THEN 4
						END
			 ELSE CASE WHEN "Sentido"='Negativo' THEN
			 			CASE WHEN "% Cumplimiento Acumulado" IS NULL THEN 5 
						 WHEN "PlanAcumuladoCalc"=0 AND "Real Acumulado">0 THEN 1	
						 WHEN "PlanAcumuladoCalc"=0 AND "Real Acumulado"<=0 THEN 3
						 WHEN "Valor Límite Inferior Acumulado" IS NULL AND "Real Acumulado">("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 1
						 WHEN "Valor Límite Superior Acumulado" IS NULL AND "Real Acumulado"<=("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 3
						 WHEN "PlanAcumuladoCalc" IS NULL THEN 6
						 WHEN "Real Acumulado"=0 AND "PlanAcumuladoCalc"=0 THEN 3
						 WHEN "Real Acumulado"<="Valor Límite Superior Acumulado" THEN 4
					 	 WHEN "Real Acumulado">"Valor Límite Superior Acumulado" AND "Real Acumulado"<=("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 3
					 	 WHEN "Real Acumulado"<= "Valor Límite Inferior Acumulado" AND "Real Acumulado">("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 2
					 	 WHEN "Real Acumulado">"Valor Límite Inferior Acumulado" THEN 1
						END
			ELSE CASE WHEN "Sentido" IS NULL AND UPPER("Hito / Indicador")='HITO' THEN			
					 CASE WHEN "% Cumplimiento Acumulado" IS NULL THEN 5 
						 WHEN "PlanAcumuladoCalc"=0 AND "Real Acumulado"<0 THEN 1	
						 WHEN "PlanAcumuladoCalc"=0 AND "Real Acumulado">=0 THEN 3
						 WHEN "Valor Límite Inferior Acumulado" IS NULL AND "Real Acumulado"<("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 1
						 WHEN "Valor Límite Superior Acumulado" IS NULL AND "Real Acumulado">=("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 3
						 WHEN "PlanAcumuladoCalc" IS NULL THEN 6
						 WHEN "Real Acumulado"=0 AND "PlanAcumuladoCalc"=0 THEN 3
						 WHEN "Real Acumulado"<"Valor Límite Inferior Acumulado" THEN 1
					 	 WHEN "Real Acumulado">="Valor Límite Inferior Acumulado" AND "Real Acumulado"<("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 2
					 	 WHEN "Real Acumulado"< "Valor Límite Superior Acumulado" AND "Real Acumulado">=("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 3
					 	 WHEN "Real Acumulado">="Valor Límite Superior Acumulado" THEN 4
					
					END
				ELSE 6 END END END END AS "_CC Semaforo TBG Acum",
			CASE WHEN "PlanAcumuladoCalc"<0 AND "Sentido"='Negativo' THEN
				CASE WHEN "CVR Año Decimal"IS NULL OR "Mes"<>12 THEN 5
				 WHEN "Valor Límite Inferior Acumulado" IS NULL AND "Real Acumulado"<("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 1
				 WHEN "Valor Límite Superior Acumulado" IS NULL AND "Real Acumulado">=("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 3
				 WHEN "Real Acumulado"<"Valor Límite Inferior Acumulado" THEN 1	    
			 	 WHEN "Real Acumulado">="Valor Límite Inferior Acumulado" AND "Real Acumulado"<("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 2 	 
			 	 WHEN "Real Acumulado"< "Valor Límite Superior Acumulado" AND "Real Acumulado">=("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 3
			 	 WHEN "Real Acumulado">="Valor Límite Superior Acumulado" THEN 4
				END
			 ELSE CASE WHEN "Sentido"='Positivo' THEN
			          CASE  WHEN "CVR Año Decimal"IS NULL OR "Mes"<>12 THEN 5
						 WHEN "PlanAcumuladoCalc"=0 AND "Real Acumulado"<0 THEN 1	
						 WHEN "PlanAcumuladoCalc"=0 AND "Real Acumulado">=0 THEN 3
						 WHEN "Valor Límite Inferior Acumulado" IS NULL AND "Real Acumulado"<("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 1
						 WHEN "Valor Límite Superior Acumulado" IS NULL AND "Real Acumulado">=("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 3
						 WHEN "PlanAcumuladoCalc" IS NULL THEN 6
						 WHEN "Real Acumulado"=0 AND "PlanAcumuladoCalc"=0 THEN 3
						 WHEN "Real Acumulado"<"Valor Límite Inferior Acumulado" THEN 1
					 	 WHEN "Real Acumulado">="Valor Límite Inferior Acumulado" AND "Real Acumulado"<("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 2
					 	 WHEN "Real Acumulado"< "Valor Límite Superior Acumulado" AND "Real Acumulado">=("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 3
					 	 WHEN "Real Acumulado">="Valor Límite Superior Acumulado" THEN 4
						END
			 ELSE CASE WHEN "Sentido"='Negativo' THEN
			 			CASE WHEN "CVR Año Decimal"IS NULL OR "Mes"<>12 THEN 5
						 WHEN "PlanAcumuladoCalc"=0 AND "Real Acumulado">0 THEN 1	
						 WHEN "PlanAcumuladoCalc"=0 AND "Real Acumulado"<=0 THEN 3
						 WHEN "Valor Límite Inferior Acumulado" IS NULL AND "Real Acumulado">("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 1
						 WHEN "Valor Límite Superior Acumulado" IS NULL AND "Real Acumulado"<=("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 3
						 WHEN "PlanAcumuladoCalc" IS NULL THEN 6
						 WHEN "Real Acumulado"=0 AND "PlanAcumuladoCalc"=0 THEN 3
						 WHEN "Real Acumulado"<="Valor Límite Superior Acumulado" THEN 4
					 	 WHEN "Real Acumulado">"Valor Límite Superior Acumulado" AND "Real Acumulado"<=("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 3
					 	 WHEN "Real Acumulado"<= "Valor Límite Inferior Acumulado" AND "Real Acumulado">("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 2
					 	 WHEN "Real Acumulado">"Valor Límite Inferior Acumulado" THEN 1
						END
			ELSE CASE WHEN "Sentido" IS NULL AND UPPER("Hito / Indicador")='HITO' THEN			
					 CASE WHEN "CVR Año Decimal"IS NULL OR "Mes"<>12 THEN 5
						 WHEN "PlanAcumuladoCalc"=0 AND "Real Acumulado"<0 THEN 1	
						 WHEN "PlanAcumuladoCalc"=0 AND "Real Acumulado">=0 THEN 3
						 WHEN "Valor Límite Inferior Acumulado" IS NULL AND "Real Acumulado"<("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 1
						 WHEN "Valor Límite Superior Acumulado" IS NULL AND "Real Acumulado">=("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 3
						 WHEN "PlanAcumuladoCalc" IS NULL THEN 6
						 WHEN "Real Acumulado"=0 AND "PlanAcumuladoCalc"=0 THEN 3
						 WHEN "Real Acumulado"<"Valor Límite Inferior Acumulado" THEN 1
					 	 WHEN "Real Acumulado">="Valor Límite Inferior Acumulado" AND "Real Acumulado"<("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 2
					 	 WHEN "Real Acumulado"< "Valor Límite Superior Acumulado" AND "Real Acumulado">=("_CC Valor Cump Satisfacción"*"PlanAcumuladoCalc") THEN 3
					 	 WHEN "Real Acumulado">="Valor Límite Superior Acumulado" THEN 4
					
					END
				ELSE 6 END END END END AS "_CC Semaforo TBG Acum CVR",
			 
    CASE WHEN PlanPeriodoCalc < 0 AND Sentido = 'Negativo'
         THEN
			CASE WHEN "% Cumplimiento Periodo" IS NULL 
					THEN 5  
				 WHEN "Valor Límite Inferior Periodo" IS NULL AND "Real Periodo" < ("_CC Valor Cump Satisfacción" * PlanPeriodoCalc) 
					THEN 1 
				 WHEN "Valor Límite Superior Periodo" IS NULL AND "Real Periodo" >= ("_CC Valor Cump Satisfacción" * PlanPeriodoCalc) 
					THEN 3 
				 WHEN "Real Periodo" < "Valor Límite Inferior Periodo" 		
					THEN 1   
				 WHEN "Real Periodo" >= "Valor Límite Inferior Periodo" AND "Real Periodo" < ("_CC Valor Cump Satisfacción" * PlanPeriodoCalc) 
					THEN 2    
				 WHEN "Real Periodo" <  "Valor Límite Superior Periodo" AND "Real Periodo" >= ("_CC Valor Cump Satisfacción" * PlanPeriodoCalc) 
					THEN 3  
				 WHEN "Real Periodo" >= "Valor Límite Superior Periodo" 
					THEN 4
				 END 
			ELSE 
				CASE WHEN Sentido = 'Positivo' 
						THEN 
				CASE WHEN "% Cumplimiento Periodo" IS NULL 
						THEN 5 
					 WHEN PlanPeriodoCalc = 0 AND "Real Periodo" < 0 
						THEN 1
					 WHEN PlanPeriodoCalc = 0 AND "Real Periodo" >= 0 
						THEN 3
					 WHEN "Valor Límite Inferior Periodo" IS NULL AND "Real Periodo" < ("_CC Valor Cump Satisfacción" * PlanPeriodoCalc) 
						THEN 1
					 WHEN "Valor Límite Superior Periodo" IS NULL AND "Real Periodo" >= ("_CC Valor Cump Satisfacción" * PlanPeriodoCalc) 
						THEN 3
					 WHEN PlanPeriodoCalc IS NULL 
						THEN 6
					 WHEN "Real Periodo" = 0 AND PlanPeriodoCalc = 0 
						THEN 3
					 WHEN "Real Periodo" < "Valor Límite Inferior Periodo" 
						THEN 1  
					 WHEN "Real Periodo" >= "Valor Límite Inferior Periodo" AND "Real Periodo" < ("_CC Valor Cump Satisfacción" * PlanPeriodoCalc) 
						THEN 2  
					 WHEN "Real Periodo" <  "Valor Límite Superior Periodo" AND "Real Periodo" >= ("_CC Valor Cump Satisfacción" * PlanPeriodoCalc) 
						THEN 3  
					 WHEN "Real Periodo" >= "Valor Límite Superior Periodo" 
						THEN 4
					 END 
			ELSE 
				CASE WHEN Sentido = 'Negativo' 
						THEN 
				CASE WHEN "% Cumplimiento Periodo" IS NULL 
						THEN 5 
					 WHEN PlanPeriodoCalc = 0 AND "Real Periodo" > 0 
						THEN 1
					 WHEN PlanPeriodoCalc = 0 AND "Real Periodo" <= 0 
						THEN 3
					 WHEN "Valor Límite Inferior Periodo" IS NULL AND "Real Periodo">("_CC Valor Cump Satisfacción" * PlanPeriodoCalc) 
						THEN 1
					 WHEN "Valor Límite Superior Periodo" IS NULL AND "Real Periodo" < =("_CC Valor Cump Satisfacción" * PlanPeriodoCalc) 
						THEN 3
					 WHEN PlanPeriodoCalc IS NULL 
						THEN 6
					 WHEN "Real Periodo" = 0 AND PlanPeriodoCalc = 0 
						THEN 3
					 WHEN "Real Periodo" <= "Valor Límite Superior Periodo" 
						THEN 4  
					 WHEN "Real Periodo" > "Valor Límite Superior Periodo" AND "Real Periodo" <= ("_CC Valor Cump Satisfacción" * PlanPeriodoCalc) 
						THEN 3  
					 WHEN "Real Periodo" <= "Valor Límite Inferior Periodo" AND "Real Periodo" > ("_CC Valor Cump Satisfacción" * PlanPeriodoCalc) 
						THEN 2  
					 WHEN "Real Periodo" > "Valor Límite Inferior Periodo" 
						THEN 1
					 END
			ELSE 
				CASE WHEN Sentido IS NULL AND UPPER("Hito / Indicador") = 'HITO' 
						THEN 
				CASE WHEN "% Cumplimiento Periodo" IS NULL 
						THEN 5 
					 WHEN PlanPeriodoCalc = 0 AND "Real Periodo" < 0 
						THEN 1
					 WHEN PlanPeriodoCalc = 0 AND "Real Periodo" >= 0 
						THEN 3
					 WHEN "Valor Límite Inferior Periodo" IS NULL AND "Real Periodo" < ("_CC Valor Cump Satisfacción" * PlanPeriodoCalc) 
						THEN 1
					 WHEN "Valor Límite Superior Periodo" IS NULL AND "Real Periodo" >= ("_CC Valor Cump Satisfacción" * PlanPeriodoCalc) 
						THEN 3
					 WHEN PlanPeriodoCalc IS NULL 
						THEN 6
					 WHEN "Real Periodo" = 0 AND PlanPeriodoCalc=0 
						THEN 3
					 WHEN "Real Periodo" < "Valor Límite Inferior Periodo" 
						THEN 1  
					 WHEN "Real Periodo" >= "Valor Límite Inferior Periodo" AND "Real Periodo" < ("_CC Valor Cump Satisfacción" * PlanPeriodoCalc) 
						THEN 2  
					 WHEN "Real Periodo" <  "Valor Límite Superior Periodo" AND "Real Periodo" >= ("_CC Valor Cump Satisfacción" * PlanPeriodoCalc) 
						THEN 3  
					 WHEN "Real Periodo" >= "Valor Límite Superior Periodo" 
						THEN 4
					 END
			ELSE 6 
			END END END END AS "_CC Semaforo TBG Per",
			
			 CASE WHEN "MetaCalc"<0 AND "Sentido"='Negativo' THEN
				CASE WHEN "% Cumplimiento Año Esc Bajo" IS NULL THEN 5 
				 WHEN "Valor Límite Inferior Año" IS NULL AND "Proyección Año Esc Bajo"<("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 1
				 WHEN "Valor Límite Superior Año" IS NULL AND "Proyección Año Esc Bajo">=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
				 WHEN "Proyección Año Esc Bajo"<"Valor Límite Inferior Año" THEN 1	    
			 	 WHEN "Proyección Año Esc Bajo">="Valor Límite Inferior Año" AND "Proyección Año Esc Bajo"<("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 2 	 
			 	 WHEN "Proyección Año Esc Bajo"< "Valor Límite Superior Año" AND "Proyección Año Esc Bajo">=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
			 	 WHEN "Proyección Año Esc Bajo">="Valor Límite Superior Año" THEN 4
				END
			 ELSE CASE WHEN "Sentido"='Positivo' THEN
			           CASE WHEN "% Cumplimiento Año Esc Bajo" IS NULL THEN 5 
						 WHEN "Valor Límite Inferior Año" IS NULL AND "Proyección Año Esc Bajo"<("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 1
						 WHEN "Valor Límite Superior Año" IS NULL AND "Proyección Año Esc Bajo">=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
						 WHEN "Proyección Año Esc Bajo"=0 AND "MetaCalc"=0 THEN 3
						 WHEN "Proyección Año Esc Bajo"<"Valor Límite Inferior Año" THEN 1
					 	 WHEN "Proyección Año Esc Bajo">="Valor Límite Inferior Año" AND "Proyección Año Esc Bajo"<("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 2
					 	 WHEN "Proyección Año Esc Bajo"< "Valor Límite Superior Año" AND "Proyección Año Esc Bajo">=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
					 	 WHEN "Proyección Año Esc Bajo">="Valor Límite Superior Año" THEN 4
						END
			 ELSE CASE WHEN "Sentido"='Negativo' THEN
			 			CASE WHEN "% Cumplimiento Año Esc Bajo" IS NULL THEN 5 
						 WHEN "Valor Límite Inferior Año" IS NULL AND "Proyección Año Esc Bajo">("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 1
						 WHEN "Valor Límite Superior Año" IS NULL AND "Proyección Año Esc Bajo"<=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
						 WHEN "Proyección Año Esc Bajo"=0 AND "MetaCalc"=0 THEN 3
						 WHEN "Proyección Año Esc Bajo"<="Valor Límite Superior Año" THEN 4
					 	 WHEN "Proyección Año Esc Bajo">"Valor Límite Superior Año" AND "Proyección Año Esc Bajo"<=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
					 	 WHEN "Proyección Año Esc Bajo"<= "Valor Límite Inferior Año" AND "Proyección Año Esc Bajo">("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 2
					 	 WHEN "Proyección Año Esc Bajo">"Valor Límite Inferior Año" THEN 1
						END
			ELSE CASE WHEN "Sentido" IS NULL AND UPPER("Hito / Indicador")='HITO' THEN			
					 CASE WHEN "% Cumplimiento Año Esc Bajo" IS NULL THEN 5 
						 WHEN "Valor Límite Inferior Año" IS NULL AND "Proyección Año Esc Bajo"<("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 1
						 WHEN "Valor Límite Superior Año" IS NULL AND "Proyección Año Esc Bajo">=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
						 WHEN "Proyección Año Esc Bajo"=0 AND "MetaCalc"=0 THEN 3
						 WHEN "Proyección Año Esc Bajo"<"Valor Límite Inferior Año" THEN 1
					 	 WHEN "Proyección Año Esc Bajo">="Valor Límite Inferior Año" AND "Proyección Año Esc Bajo"<("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 2
					 	 WHEN "Proyección Año Esc Bajo"< "Valor Límite Superior Año" AND "Proyección Año Esc Bajo">=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
					 	 WHEN "Proyección Año Esc Bajo">="Valor Límite Superior Año" THEN 4
					
					END
				ELSE 6 END END END END as "_CC Semaforo TBG Proy Bajo",
				
				CASE WHEN "MetaCalc"<0 AND "Sentido"='Negativo' THEN
				CASE WHEN "% Cumplimiento Año Esc Medio" IS NULL THEN 5 
				 WHEN "Valor Límite Inferior Año" IS NULL AND "Proyección Año Esc Medio"<("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 1
				 WHEN "Valor Límite Superior Año" IS NULL AND "Proyección Año Esc Medio">=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
				 WHEN "Proyección Año Esc Medio"<"Valor Límite Inferior Año" THEN 1	    
			 	 WHEN "Proyección Año Esc Medio">="Valor Límite Inferior Año" AND "Proyección Año Esc Medio"<("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 2 	 
			 	 WHEN "Proyección Año Esc Medio"< "Valor Límite Superior Año" AND "Proyección Año Esc Medio">=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
			 	 WHEN "Proyección Año Esc Medio">="Valor Límite Superior Año" THEN 4
				END
			 ELSE CASE WHEN "Sentido"='Positivo' THEN
			           CASE WHEN "% Cumplimiento Año Esc Medio" IS NULL THEN 5 
						 WHEN "Valor Límite Inferior Año" IS NULL AND "Proyección Año Esc Medio"<("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 1
						 WHEN "Valor Límite Superior Año" IS NULL AND "Proyección Año Esc Medio">=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
						 WHEN "Proyección Año Esc Medio"=0 AND "MetaCalc"=0 THEN 3
						 WHEN "Proyección Año Esc Medio"<"Valor Límite Inferior Año" THEN 1
					 	 WHEN "Proyección Año Esc Medio">="Valor Límite Inferior Año" AND "Proyección Año Esc Medio"<("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 2
					 	 WHEN "Proyección Año Esc Medio"< "Valor Límite Superior Año" AND "Proyección Año Esc Medio">=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
					 	 WHEN "Proyección Año Esc Medio">="Valor Límite Superior Año" THEN 4
						END
			 ELSE CASE WHEN "Sentido"='Negativo' THEN
			 			CASE WHEN "% Cumplimiento Año Esc Medio" IS NULL THEN 5 
						 WHEN "Valor Límite Inferior Año" IS NULL AND "Proyección Año Esc Medio">("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 1
						 WHEN "Valor Límite Superior Año" IS NULL AND "Proyección Año Esc Medio"<=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
						 WHEN "Proyección Año Esc Medio"=0 AND "MetaCalc"=0 THEN 3
						 WHEN "Proyección Año Esc Medio"<="Valor Límite Superior Año" THEN 4
					 	 WHEN "Proyección Año Esc Medio">"Valor Límite Superior Año" AND "Proyección Año Esc Medio"<=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
					 	 WHEN "Proyección Año Esc Medio"<= "Valor Límite Inferior Año" AND "Proyección Año Esc Medio">("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 2
					 	 WHEN "Proyección Año Esc Medio">"Valor Límite Inferior Año" THEN 1
						END
			ELSE CASE WHEN "Sentido" IS NULL AND UPPER("Hito / Indicador")='HITO' THEN			
					 CASE WHEN "% Cumplimiento Año Esc Medio" IS NULL THEN 5 
						 WHEN "Valor Límite Inferior Año" IS NULL AND "Proyección Año Esc Medio"<("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 1
						 WHEN "Valor Límite Superior Año" IS NULL AND "Proyección Año Esc Medio">=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
						 WHEN "Proyección Año Esc Medio"=0 AND "MetaCalc"=0 THEN 3
						 WHEN "Proyección Año Esc Medio"<"Valor Límite Inferior Año" THEN 1
					 	 WHEN "Proyección Año Esc Medio">="Valor Límite Inferior Año" AND "Proyección Año Esc Medio"<("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 2
					 	 WHEN "Proyección Año Esc Medio"< "Valor Límite Superior Año" AND "Proyección Año Esc Medio">=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
					 	 WHEN "Proyección Año Esc Medio">="Valor Límite Superior Año" THEN 4
					
					END
				ELSE 6 END END END END "_CC Semaforo TBG Proy Medio",
			
			CASE WHEN "MetaCalc"<0 AND "Sentido"='Negativo' THEN
				CASE WHEN "% Cumplimiento Año Esc Alto" IS NULL THEN 5 
				 WHEN "Valor Límite Inferior Año" IS NULL AND "Proyección Año Esc Alto"<("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 1
				 WHEN "Valor Límite Superior Año" IS NULL AND "Proyección Año Esc Alto">=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
				 WHEN "Proyección Año Esc Alto"<"Valor Límite Inferior Año" THEN 1	    
			 	 WHEN "Proyección Año Esc Alto">="Valor Límite Inferior Año" AND "Proyección Año Esc Alto"<("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 2 	 
			 	 WHEN "Proyección Año Esc Alto"< "Valor Límite Superior Año" AND "Proyección Año Esc Alto">=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
			 	 WHEN "Proyección Año Esc Alto">="Valor Límite Superior Año" THEN 4
				END
			 ELSE CASE WHEN "Sentido"='Positivo' THEN
			           CASE WHEN "% Cumplimiento Año Esc Alto" IS NULL THEN 5 
						 WHEN "Valor Límite Inferior Año" IS NULL AND "Proyección Año Esc Alto"<("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 1
						 WHEN "Valor Límite Superior Año" IS NULL AND "Proyección Año Esc Alto">=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
						 WHEN "Proyección Año Esc Alto"=0 AND "MetaCalc"=0 THEN 3
						 WHEN "Proyección Año Esc Alto"<"Valor Límite Inferior Año" THEN 1
					 	 WHEN "Proyección Año Esc Alto">="Valor Límite Inferior Año" AND "Proyección Año Esc Alto"<("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 2
					 	 WHEN "Proyección Año Esc Alto"< "Valor Límite Superior Año" AND "Proyección Año Esc Alto">=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
					 	 WHEN "Proyección Año Esc Alto">="Valor Límite Superior Año" THEN 4
						END
			 ELSE CASE WHEN "Sentido"='Negativo' THEN
			 			CASE WHEN "% Cumplimiento Año Esc Alto" IS NULL THEN 5 
						 WHEN "Valor Límite Inferior Año" IS NULL AND "Proyección Año Esc Alto">("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 1
						 WHEN "Valor Límite Superior Año" IS NULL AND "Proyección Año Esc Alto"<=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
						 WHEN "Proyección Año Esc Alto"=0 AND "MetaCalc"=0 THEN 3
						 WHEN "Proyección Año Esc Alto"<="Valor Límite Superior Año" THEN 4
					 	 WHEN "Proyección Año Esc Alto">"Valor Límite Superior Año" AND "Proyección Año Esc Alto"<=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
					 	 WHEN "Proyección Año Esc Alto"<= "Valor Límite Inferior Año" AND "Proyección Año Esc Alto">("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 2
					 	 WHEN "Proyección Año Esc Alto">"Valor Límite Inferior Año" THEN 1
						END
			ELSE CASE WHEN "Sentido" IS NULL AND UPPER("Hito / Indicador")='HITO' THEN			
					 CASE WHEN "% Cumplimiento Año Esc Alto" IS NULL THEN 5 
						 WHEN "Valor Límite Inferior Año" IS NULL AND "Proyección Año Esc Alto"<("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 1
						 WHEN "Valor Límite Superior Año" IS NULL AND "Proyección Año Esc Alto">=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
						 WHEN "Proyección Año Esc Alto"=0 AND "MetaCalc"=0 THEN 3
						 WHEN "Proyección Año Esc Alto"<"Valor Límite Inferior Año" THEN 1
					 	 WHEN "Proyección Año Esc Alto">="Valor Límite Inferior Año" AND "Proyección Año Esc Alto"<("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 2
					 	 WHEN "Proyección Año Esc Alto"< "Valor Límite Superior Año" AND "Proyección Año Esc Alto">=("_CC Valor Cump Satisfacción"*"MetaCalc") THEN 3
					 	 WHEN "Proyección Año Esc Alto">="Valor Límite Superior Año" THEN 4
					
					END
				ELSE 6 END END END END as "_CC Semaforo TBG Proy Alto"
			
			FROM (SELECT T."DESC_ACCIONES_DE_ASEGURAMIENTO" as "Acciones de Aseguramiento",
			        T."DESC_ANNIO" as "Año",T."MES" as "Mes",
			        T."DESC_CARGO_RESPONSABLE_MEDICION" as "Cargo Responsable de Medición",
			        T."DESC_CARGO_RESPONSABLE_MEDICION_2" as "Cargo Responsable de Medición 2",
			        T."DESC_CAUSAS_DESEMPENO_ACUM" as "Causas del Desempeño - Acum",
			        T."DESC_CAUSAS_DESEMPENO_PERIODO" as "Causas del Desempeño - Periodo",
			        T."DESC_CORREO_RESPONSABLE_MEDICION" as "Correo Responsable de Medición",
			        T."DESC_CORREO_RESPONSABLE_MEDICION_2" as "Correo Responsable de Medición 2",
			        T."DESC_CORTO_LARGO_PLAZO" as "Corto Plazo / Largo Plazo",
			        T."DESC_DETALLE_INDICADOR" as "Detalle Indicador",
			        T."DESC_EJE_PALANCA" as "Eje o Palanca",
					T."NUM_ORDEN_PALANCA" AS "Numero Orden Palanca",
	                T."NUM_ORDEN_OBJETIVO" AS "Numero Orden Objetivo",
			        T."DESC_EMPRESA" as "Empresa",
			    	T."DTM_FECHACARGA" as "Fecha de Carga",
			        T."FK_INDICADOR" as "FK Indicador",
			        T."FK_PARAM_INDICADOR" as "FK Parametrización Indicador",
			        T."FK_TABLERO" as "FK Tablero",
			        T."DESC_FRECUENCIA" as "Frecuencia",
			        T."DESC_GERENCIA" as "Gerencia",
			        T."DESC_GRUPO" as "Grupo",
			        T."DESC_GRUPO_SEGMENTO" as "Grupo Segmento",
			        T."DESC_HITO_INDICADOR" as "Hito / Indicador",
			        T."ID_INDICADOR" as "ID Indicador",
			        T."DESC_REFERENTE" as "Indicador Referente",
			        T."PRC_LIMITE_INFERIOR_CVR" as "Limite Inferior CVR",
			        T."PRC_LIMITE_SUPERIOR_CVR" as "Limite Superior CVR",
			        T."PRC_META_CVR" as "Meta CVR",
			        T."DESC_META_NORMALIZADA" as "Meta Normalizada",
			        T."DESC_NIVEL" as "Nivel",
			        T."DESC_NOMBRE_INDICADOR" as "Nombre Indicador",
			        T."DESC_RESPONSABLE_MEDICION" as "Nombre Responsable de Medición",
			        T."DESC_RESPONSABLE_MEDICION_2" as "Nombre Responsable de Medición 2",
			        T."CANT_DECIMALES_CALCULO" as "Número de Decimales para el Cálculo",
			        T."DESC_OBJETIVO" as "Objetivo",
			        T."DESC_PERIODO" as "Periodo",
			        T."DESC_PREMISAS_ESC_ALTO" as "Premisas Esc. Alto",
			        T."DESC_PREMISAS_ESC_BAJO" as "Premisas Esc. Bajo",
			        T."DESC_PREMISAS_ESC_MEDIO" as "Premisas Esc. Medio",
			        T."DESC_RUTINA" as "Rutina",
			        T."DESC_SECUENCIA_ORDEN" as "Secuencia / Orden",
			        T."DESC_SEGMENTO" as "Segmento",
			        T."DESC_SENTIDO" as "Sentido",
			        T."DESC_SIGLA_AREA" as "Sigla Área",
			        T."DESC_TABLERO" as "Tablero",
			        T."DESC_TBG" as "TBG",
			        T."FK_PERIODO" as "Tiempo",
			        T."DESC_TIPO_TABLERO" as "Tipo Tablero",
			        T."DESC_UNIDAD_NEGOCIO_NVL_2" as "Unidad de Negocio Nivel 2",
			        T."DESC_UNIDAD_NEGOCIO_NVL_3" as "Unidad de Negocio Nivel 3",
			        T."VLR_LIMITE_INFERIOR" as "Valor Límite Inferior",
			        T."VLR_LIMITE_SUPERIOR" as "Valor Límite Superior",
			        T."VLR_PESO_INDICADOR" as "Valor Peso Indicador",
			        T."DESC_VERSION" as "Versión",
			        T."DESC_VP_EJECUTIVA" as "VP Ejecutiva",
			        T."DESC_TABLERO_CVR",
					I.DESC_VISUALIZA_PERIODO,
					I.DESC_UNIDAD_MEDIDA,
					T.FECHA_CARGA_SYNAPSE,
					T.FECHA_PROXIMA_ACTUALIZA_SYNAPSE,
					NULL AS CM_RESUMEN,
					T.DESC_ESTANDAR ,				
			    sum("PRC_CUMP_ACUMULADO") as "% Cumplimiento Acumulado",
			    sum("PRC_CUMP_ANNIO_ESC_ALTO") as "% Cumplimiento Año Esc Alto",
			    sum("PRC_CUMP_ANNIO_ESC_BAJO") as "% Cumplimiento Año Esc Bajo",
			    sum("PRC_CUMP_ANNIO_ESC_MEDIO") as "% Cumplimiento Año Esc Medio",
			    sum("PRC_CUMP_PERIODO") as "% Cumplimiento Periodo",
			    sum("PRC_DESEMPENO_ACUMULADO") as "% Desempeño Acumulado",
			    sum("PRC_DESEMPENO_ANNIO_ESC_ALTO") as "% Desempeño Año Esc Alto",
			    sum("PRC_DESEMPENO_ANNIO_ESC_BAJO") as "% Desempeño Año Esc Bajo",
			    sum("PRC_DESEMPENO_ANNIO_ESC_MEDIO") as "% Desempeño Año Esc Medio",
			    sum("PRC_DESEMPENO_PERIODO") as "% Desempeño Periodo",
			    sum("CVR_ANNIO") as "CVR Año Decimal",
			    sum("CVR_ESC_ALTO") as "CVR Esc Alto",
			    sum("CVR_ESC_BAJO") as "CVR Esc Bajo",
			    sum("CVR_ESC_MEDIO") as "CVR Esc Medio",
			    sum("META_ANNIO") as "Meta Año",
			    sum("META_ANNIO_1") as "Meta Año +1",
			    sum("META_ANNIO_2") as "Meta Año +2",
			    sum("META_ANNIO_FINAL") as "Meta Año Final",
			    sum("META_ANNIO_NORMALIZADO") as "Meta Año Normalizado",
			    sum("PLAN_ACUMULADO") as "Plan Acumulado",
			    sum("PLAN_ACUMULADO_NORMALIZADO") as "Plan Acumulado Normalizado",
			    sum("PLAN_PERIODO") as "Plan Periodo",
			    sum("PLAN_PERIODO_NORMALIZADO") as "Plan Periodo Normalizado",
			    sum("VLR_PROYECCION_ANNIO_ESC_ALTO") as "Proyección Año Esc Alto",
			    sum("VLR_PROYECCION_ANNIO_ESC_BAJO") as "Proyección Año Esc Bajo",
			    sum("VLR_PROYECCION_ANNIO_ESC_MEDIO") as "Proyección Año Esc Medio",
			    sum("PROYECCION_PERIODO_1") as "Proyección Periodo +1",
			    sum("PROYECCION_PERIODO_2") as "Proyección Periodo +2",
			    sum("PROYECCION_PERIODO_3") as "Proyección Periodo +3",
			    sum("REAL_ACUMULADO") as "Real Acumulado",
			    sum("REAL_PERIODO") as "Real Periodo",
			    sum("VLR_LIMITE_INFERIOR_ACUMULADO") as "Valor Límite Inferior Acumulado",
			    sum("VLR_LIMITE_INFERIOR_ANNIO") as "Valor Límite Inferior Año",
			    sum("VLR_LIMITE_SUPERIOR_ACUMULADO") as "Valor Límite Superior Acumulado",
				sum("VLR_LIMITE_INFERIOR_PERIODO") AS "Valor Límite Inferior Periodo",
				sum("VLR_LIMITE_SUPERIOR_PERIODO") AS "Valor Límite Superior Periodo",				
			    sum("VLR_LIMITE_SUPERIOR_ANNIO") as "Valor Límite Superior Año",
			    sum(I."VLR_CUMP_SATISFACCION") as "_CC Valor Cump Satisfacción",
			    sum(isnull("PLAN_PERIODO_NORMALIZADO","PLAN_PERIODO")) as "PlanPeriodoCalc",
			    sum(isnull("PLAN_ACUMULADO_NORMALIZADO","PLAN_ACUMULADO")) as "PlanAcumuladoCalc",
			    sum(isnull("META_ANNIO_NORMALIZADO","META_ANNIO")) as "MetaCalc"
			
			FROM [ATOMO].[CVC_DESEMPENO_TABLERO] as T
			
			INNER JOIN [ATOMO].[CVD_INDICADOR] as I 
			     ON T."FK_INDICADOR"=I."GK_INDICADOR"
			
			group by T."CANT_DECIMALES_CALCULO",
			        T."DESC_ACCIONES_DE_ASEGURAMIENTO",
			        T."DESC_ANNIO",
			        T."MES",
			        T."DESC_CARGO_RESPONSABLE_MEDICION",
			        T."DESC_CARGO_RESPONSABLE_MEDICION_2",
			        T."DESC_CAUSAS_DESEMPENO_ACUM",
			        T."DESC_CAUSAS_DESEMPENO_PERIODO",
			        T."DESC_CORREO_RESPONSABLE_MEDICION",
			        T."DESC_CORREO_RESPONSABLE_MEDICION_2",
			        T."DESC_CORTO_LARGO_PLAZO",
			        T."DESC_DETALLE_INDICADOR",
			        T."DESC_EJE_PALANCA",
					T."NUM_ORDEN_PALANCA",
	                T."NUM_ORDEN_OBJETIVO" ,
			        T."DESC_EMPRESA",
			        T."DESC_FRECUENCIA",
			        T."DESC_GERENCIA",
			        T."DESC_GRUPO",
			        T."DESC_GRUPO_SEGMENTO",
			        T."DESC_HITO_INDICADOR",
			        T."DESC_META_NORMALIZADA",
			        T."DESC_NIVEL",
			        T."DESC_NOMBRE_INDICADOR",
			        T."DESC_OBJETIVO",
			        T."DESC_PERIODO",
			        T."DESC_PREMISAS_ESC_ALTO",
			        T."DESC_PREMISAS_ESC_BAJO",
			        T."DESC_PREMISAS_ESC_MEDIO",
			        T."DESC_REFERENTE",
			        T."DESC_RESPONSABLE_MEDICION",
			        T."DESC_RESPONSABLE_MEDICION_2",
			        T."DESC_RUTINA",
			        T."DESC_SECUENCIA_ORDEN",
			        T."DESC_SEGMENTO",
			        T."DESC_SENTIDO",
			        T."DESC_SIGLA_AREA",
			        T."DESC_TABLERO",
			        T."DESC_TBG",
			        T."DESC_TIPO_TABLERO",
			        T."DESC_UNIDAD_NEGOCIO_NVL_2",
			        T."DESC_UNIDAD_NEGOCIO_NVL_3",
			        T."DESC_VERSION",
			        T."DESC_VP_EJECUTIVA",
			        T."DESC_TABLERO_CVR",
			        T."DTM_FECHACARGA",
			        T."FK_INDICADOR",
			        T."FK_PARAM_INDICADOR",
			        T."FK_PERIODO",
			        T."FK_TABLERO",
			        T."ID_INDICADOR",
			        T."PRC_LIMITE_INFERIOR_CVR",
			        T."PRC_LIMITE_SUPERIOR_CVR",
			        T."PRC_META_CVR",
			        T."VLR_LIMITE_INFERIOR",
			        T."VLR_LIMITE_SUPERIOR",
			        T."VLR_PESO_INDICADOR",
					I.DESC_VISUALIZA_PERIODO,
					I.DESC_UNIDAD_MEDIDA,
					T.FECHA_CARGA_SYNAPSE,
					T.FECHA_PROXIMA_ACTUALIZA_SYNAPSE,
					T.DESC_ESTANDAR 
			        
			    UNION ALL    
			    
			    SELECT T."DESC_ACCIONES_DE_ASEGURAMIENTO" as "Acciones de Aseguramiento",
			        T."DESC_ANNIO" as "Año",T."MES" as "Mes",
			        T."DESC_CARGO_RESPONSABLE_MEDICION" as "Cargo Responsable de Medición",
			        T."DESC_CARGO_RESPONSABLE_MEDICION_2" as "Cargo Responsable de Medición 2",
			        T."DESC_CAUSAS_DESEMPENO_ACUM" as "Causas del Desempeño - Acum",
			        T."DESC_CAUSAS_DESEMPENO_PERIODO" as "Causas del Desempeño - Periodo",
			        T."DESC_CORREO_RESPONSABLE_MEDICION" as "Correo Responsable de Medición",
			        T."DESC_CORREO_RESPONSABLE_MEDICION_2" as "Correo Responsable de Medición 2",
			        T."DESC_CORTO_LARGO_PLAZO" as "Corto Plazo / Largo Plazo",
			        T."DESC_DETALLE_INDICADOR" as "Detalle Indicador",
			        T."DESC_EJE_PALANCA" as "Eje o Palanca",
					T."NUM_ORDEN_PALANCA" AS "Numero Orden Palanca",
	                T."NUM_ORDEN_OBJETIVO" AS "Numero Orden Objetivo",
			        T."DESC_EMPRESA" as "Empresa",
			    	T."DTM_FECHACARGA" as "Fecha de Carga",
			        T."FK_INDICADOR" as "FK Indicador",
			        T."FK_PARAM_INDICADOR" as "FK Parametrización Indicador",
			        T."FK_TABLERO" as "FK Tablero",
			        T."DESC_FRECUENCIA" as "Frecuencia",
			        T."DESC_GERENCIA" as "Gerencia",
			        T."DESC_GRUPO" as "Grupo",
			        T."DESC_GRUPO_SEGMENTO" as "Grupo Segmento",
			        T."DESC_HITO_INDICADOR" as "Hito / Indicador",
			        T."ID_INDICADOR" as "ID Indicador",
			        T."DESC_REFERENTE" as "Indicador Referente",
			        T."PRC_LIMITE_INFERIOR_CVR" as "Limite Inferior CVR",
			        T."PRC_LIMITE_SUPERIOR_CVR" as "Limite Superior CVR",
			        T."PRC_META_CVR" as "Meta CVR",
			        T."DESC_META_NORMALIZADA" as "Meta Normalizada",
			        T."DESC_NIVEL" as "Nivel",
			        T."DESC_NOMBRE_INDICADOR" as "Nombre Indicador",
			        T."DESC_RESPONSABLE_MEDICION" as "Nombre Responsable de Medición",
			        T."DESC_RESPONSABLE_MEDICION_2" as "Nombre Responsable de Medición 2",
			        T."CANT_DECIMALES_CALCULO" as "Número de Decimales para el Cálculo",
			        T."DESC_OBJETIVO" as "Objetivo",
			        T."DESC_PERIODO" as "Periodo",
			        T."DESC_PREMISAS_ESC_ALTO" as "Premisas Esc. Alto",
			        T."DESC_PREMISAS_ESC_BAJO" as "Premisas Esc. Bajo",
			        T."DESC_PREMISAS_ESC_MEDIO" as "Premisas Esc. Medio",
			        T."DESC_RUTINA" as "Rutina",
			        T."DESC_SECUENCIA_ORDEN" as "Secuencia / Orden",
			        T."DESC_SEGMENTO" as "Segmento",
			        T."DESC_SENTIDO" as "Sentido",
			        T."DESC_SIGLA_AREA" as "Sigla Área",
			        T."DESC_TABLERO" as "Tablero",
			        T."DESC_TBG" as "TBG",
			        T."FK_PERIODO" as "Tiempo",
			        T."DESC_TIPO_TABLERO" as "Tipo Tablero",
			        T."DESC_UNIDAD_NEGOCIO_NVL_2" as "Unidad de Negocio Nivel 2",
			        T."DESC_UNIDAD_NEGOCIO_NVL_3" as "Unidad de Negocio Nivel 3",
			        T."VLR_LIMITE_INFERIOR" as "Valor Límite Inferior",
			        T."VLR_LIMITE_SUPERIOR" as "Valor Límite Superior",
			        T."VLR_PESO_INDICADOR" as "Valor Peso Indicador",
			        T."DESC_VERSION" as "Versión",
			        T."DESC_VP_EJECUTIVA" as "VP Ejecutiva",
			        T."DESC_TABLERO_CVR",
					I.DESC_VISUALIZA_PERIODO,
					I.DESC_UNIDAD_MEDIDA,
					T.FECHA_CARGA_SYNAPSE,
					T.FECHA_PROXIMA_ACTUALIZA_SYNAPSE,
					T.[CM_RESUMEN],
					T.DESC_ESTANDAR ,
			    sum("PRC_CUMP_ACUMULADO") as "% Cumplimiento Acumulado",
			    sum("PRC_CUMP_ANNIO_ESC_ALTO") as "% Cumplimiento Año Esc Alto",
			    sum("PRC_CUMP_ANNIO_ESC_BAJO") as "% Cumplimiento Año Esc Bajo",
			    sum("PRC_CUMP_ANNIO_ESC_MEDIO") as "% Cumplimiento Año Esc Medio",
			    sum("PRC_CUMP_PERIODO") as "% Cumplimiento Periodo",
			    sum("PRC_DESEMPENO_ACUMULADO") as "% Desempeño Acumulado",
			    sum("PRC_DESEMPENO_ANNIO_ESC_ALTO") as "% Desempeño Año Esc Alto",
			    sum("PRC_DESEMPENO_ANNIO_ESC_BAJO") as "% Desempeño Año Esc Bajo",
			    sum("PRC_DESEMPENO_ANNIO_ESC_MEDIO") as "% Desempeño Año Esc Medio",
			    sum("PRC_DESEMPENO_PERIODO") as "% Desempeño Periodo",
			    sum("CVR_ANNIO") as "CVR Año Decimal",
			    sum("CVR_ESC_ALTO") as "CVR Esc Alto",
			    sum("CVR_ESC_BAJO") as "CVR Esc Bajo",
			    sum("CVR_ESC_MEDIO") as "CVR Esc Medio",
			    sum("META_ANNIO") as "Meta Año",
			    sum("META_ANNIO_1") as "Meta Año +1",
			    sum("META_ANNIO_2") as "Meta Año +2",
			    sum("META_ANNIO_FINAL") as "Meta Año Final",
			    sum("META_ANNIO_NORMALIZADO") as "Meta Año Normalizado",
			    sum("PLAN_ACUMULADO") as "Plan Acumulado",
			    sum("PLAN_ACUMULADO_NORMALIZADO") as "Plan Acumulado Normalizado",
			    sum("PLAN_PERIODO") as "Plan Periodo",
			    sum("PLAN_PERIODO_NORMALIZADO") as "Plan Periodo Normalizado",
			    sum("VLR_PROYECCION_ANNIO_ESC_ALTO") as "Proyección Año Esc Alto",
			    sum("VLR_PROYECCION_ANNIO_ESC_BAJO") as "Proyección Año Esc Bajo",
			    sum("VLR_PROYECCION_ANNIO_ESC_MEDIO") as "Proyección Año Esc Medio",
			    sum("PROYECCION_PERIODO_1") as "Proyección Periodo +1",
			    sum("PROYECCION_PERIODO_2") as "Proyección Periodo +2",
			    sum("PROYECCION_PERIODO_3") as "Proyección Periodo +3",
			    sum("REAL_ACUMULADO") as "Real Acumulado",
			    sum("REAL_PERIODO") as "Real Periodo",
			    sum("VLR_LIMITE_INFERIOR_ACUMULADO") as "Valor Límite Inferior Acumulado",
			    sum("VLR_LIMITE_INFERIOR_ANNIO") as "Valor Límite Inferior Año",
			    sum("VLR_LIMITE_SUPERIOR_ACUMULADO") as "Valor Límite Superior Acumulado",
				sum("VLR_LIMITE_INFERIOR_PERIODO") AS "Valor Límite Inferior Periodo",
				sum("VLR_LIMITE_SUPERIOR_PERIODO") AS "Valor Límite Superior Periodo",		
			    sum("VLR_LIMITE_SUPERIOR_ANNIO") as "Valor Límite Superior Año",
			    sum(I."VLR_CUMP_SATISFACCION") as "_CC Valor Cump Satisfacción",
			    sum(isnull("PLAN_PERIODO_NORMALIZADO","PLAN_PERIODO")) as "PlanPeriodoCalc",
			    sum(isnull("PLAN_ACUMULADO_NORMALIZADO","PLAN_ACUMULADO")) as "PlanAcumuladoCalc",
			    sum(isnull("META_ANNIO_NORMALIZADO","META_ANNIO")) as "MetaCalc"
			
			from [ATOMO].[CVC_HITO_TABLERO] as T
			
			INNER JOIN [ATOMO].[CVD_INDICADOR] as I ON T."FK_INDICADOR"=I."GK_INDICADOR"
			
			group by T."CANT_DECIMALES_CALCULO",
			        T."DESC_ACCIONES_DE_ASEGURAMIENTO",
			        T."DESC_ANNIO",
			        T."MES",
			        T."DESC_CARGO_RESPONSABLE_MEDICION",
			        T."DESC_CARGO_RESPONSABLE_MEDICION_2",
			        T."DESC_CAUSAS_DESEMPENO_ACUM",
			        T."DESC_CAUSAS_DESEMPENO_PERIODO",
			        T."DESC_CORREO_RESPONSABLE_MEDICION",
			        T."DESC_CORREO_RESPONSABLE_MEDICION_2",
			        T."DESC_CORTO_LARGO_PLAZO",
			        T."DESC_DETALLE_INDICADOR",
			        T."DESC_EJE_PALANCA",
					T."NUM_ORDEN_PALANCA",
	                T."NUM_ORDEN_OBJETIVO" ,
			        T."DESC_EMPRESA",
			        T."DESC_FRECUENCIA",
			        T."DESC_GERENCIA",
			        T."DESC_GRUPO",
			        T."DESC_GRUPO_SEGMENTO",
			        T."DESC_HITO_INDICADOR",
			        T."DESC_META_NORMALIZADA",
			        T."DESC_NIVEL",
			        T."DESC_NOMBRE_INDICADOR",
			        T."DESC_OBJETIVO",
			        T."DESC_PERIODO",
			        T."DESC_PREMISAS_ESC_ALTO",
			        T."DESC_PREMISAS_ESC_BAJO",
			        T."DESC_PREMISAS_ESC_MEDIO",
			        T."DESC_REFERENTE",
			        T."DESC_RESPONSABLE_MEDICION",
			        T."DESC_RESPONSABLE_MEDICION_2",
			        T."DESC_RUTINA",
			        T."DESC_SECUENCIA_ORDEN",
			        T."DESC_SEGMENTO",
			        T."DESC_SENTIDO",
			        T."DESC_SIGLA_AREA",
			        T."DESC_TABLERO",
			        T."DESC_TBG",
			        T."DESC_TIPO_TABLERO",
			        T."DESC_UNIDAD_NEGOCIO_NVL_2",
			        T."DESC_UNIDAD_NEGOCIO_NVL_3",
			        T."DESC_VERSION",
			        T."DESC_VP_EJECUTIVA",
			        T."DESC_TABLERO_CVR",
			        T."DTM_FECHACARGA",
			        T."FK_INDICADOR",
			        T."FK_PARAM_INDICADOR",
			        T."FK_PERIODO",
			        T."FK_TABLERO",
			        T."ID_INDICADOR",
			        T."PRC_LIMITE_INFERIOR_CVR",
			        T."PRC_LIMITE_SUPERIOR_CVR",
			        T."PRC_META_CVR",
			        T."VLR_LIMITE_INFERIOR",
			        T."VLR_LIMITE_SUPERIOR",
			        T."VLR_PESO_INDICADOR",
					I.DESC_VISUALIZA_PERIODO,
					I.DESC_UNIDAD_MEDIDA,
					T.FECHA_CARGA_SYNAPSE,
					T.FECHA_PROXIMA_ACTUALIZA_SYNAPSE,
					T.[CM_RESUMEN],
					T.DESC_ESTANDAR 
			        
			        ) AS V		
		) AS F
)F1
LEFT JOIN [ATOMO].[DWH.DIM_ESCENARIOSANALISIS_UX] as ESC_UX
		ON F1."FK Indicador" = ESC_UX."FK_INDICADOR"
		AND F1.[PERIODO] = ESC_UX.[NUM_PERIODO]
		AND F1."Detalle Indicador" = ESC_UX.DESC_DETALLE_INDICADOR;