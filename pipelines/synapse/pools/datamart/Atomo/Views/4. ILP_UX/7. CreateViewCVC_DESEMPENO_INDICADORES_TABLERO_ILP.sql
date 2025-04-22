
-- =============================================
-- Author:      Maria Alejandra Delgado
-- Create Date: 202-05-16
-- Description: Se crea la vista CVC_DESEMPENO_INDICADORES_TABLERO_ILP la cual es un insumo para el tablero de ILP

-- Author:      Oscar Fabian Angel 
-- Update Date: 2023-10-09
-- Description: Se realiza ajustes para inclusion de los campos ActivoCumplimientoMin, CumplimientoMinimo, ReconocimientoMinimo
-- =============================================

CREATE VIEW [ATOMO].[CVC_DESEMPENO_INDICADORES_TABLERO_ILP] 
AS SELECT		  A."Año",
                  A."Año Hito",
                  A."Cargo Responsable de Medición",
                  A."Cargo Responsable de Medición 2",
                  A."Correo Responsable de Medición",
                  A."Correo Responsable de Medición 2",
                  A."Corto Plazo / Largo Plazo",
                  A."Detalle Indicador",
                  A."Eje o Palanca",
                  A."Empresa",
                  A."Fecha de Carga",
                  A."FK Indicador",
                  A."FK Parametrización Indicador",
                  A."FK Tablero",
                  A."Vigencia Tablero desde",
                  A."Vigencia Tablero hasta",
                  A."Frecuencia",
                  A."Gerencia",
                  A."Grupo",
                  A."Grupo Segmento",
                  A."Hito / Indicador",
                  A."ID Indicador",
                  A."Indicador Referente",
                  A."Nivel",
                  A."Nombre Indicador",
                  A."Nombre Responsable de Medición",
                  A."Nombre Responsable de Medición 2",
                  A."Número de Decimales para el Cálculo",
                  A."Objetivo",
                  A."Periodo",
                  A."Plan Acum Periodos",
                  A."Periodo Año",
                  A."Rutina",
                  A."Secuencia / Orden",
                  A."Segmento",
                  A."Sentido",
                  A."Sigla Área",
                  A."Tablero",
                  A."Tiempo",
                  A."Tipo Tablero",
                  A."Unidad de Negocio Nivel 2",
                  A."Unidad de Negocio Nivel 3",
                  A."Valor Peso Indicador",
                  A."Versión",
                  A."VP Ejecutiva",
                  A."FECHA_CARGA_SYNAPSE",
                  A."FECHA_PROXIMA_ACTUALIZA_SYNAPSE",
                  A."CM_RESUMEN",
				  A.[_CC Drill Through Detalle KPI],	
				  A.[_CC Hito/Ind],
				  A.[_CC Reporta Periodo], 
				  A.[_CC Valor Brecha],
				  A.[_CC % Cumplimiento ILP Val],
				  A.[.CC Drill Through Detalle KPI Panel], 
				  A.[.CC Nombre Indicador - Detalle], 
				  A.[CC Color Brecha], 
				  A.[Hito/Ind Habilitador],
				  A.[ActivoCumplimientoMin],
		          A.[CumplimientoMinimo],
		          A.[ReconocimientoMinimo],
				  A.[Llave],  
				  A.[Mensaje clave indicador], 
				  A.[Mes],
				  A.[Premisas], 
				  A.[UnidadMedida],
				  A.[.CC % Cumplimiento tablero Ban],

---- Valor Meta Año Normalizada
		    case when "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12') AND "Vigencia Tablero desde" = "Año Hito" 
			then
			A."VMNA1Replica"
			else A."VMNA1ILP" end as "Valor Meta Normalizada Año 1",

			  CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12') AND (
					   ( (CONVERT(VARCHAR,YEAR("Vigencia Tablero desde")+1)= "Año Hito" AND (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=2)) )
					   OR
					   (  (CONVERT(VARCHAR,YEAR("Vigencia Tablero desde"))= "Año Hito" and (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=1)) )
					   OR
					   (  (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde"))=0 )
					  )
				         THEN
					A."VMNA2Replica"
					else A."VMNA2ILP" end as "Valor Meta Normalizada Año 2",

				  CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12') AND (
				   ( (CONVERT(VARCHAR,YEAR("Vigencia Tablero hasta"))= "Año Hito" AND (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=2)) )
				   OR
				   (  (CONVERT(VARCHAR,YEAR("Vigencia Tablero hasta"))= "Año Hito" AND (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=1)) )
				   OR
				   ( (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde"))=0 )	 			  
				  )	  
				         THEN 
					A."VMNA3Replica"
					else A."VMNA3ILP" end as "Valor Meta Normalizada Año 3",

				  CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12') AND (
				  (CONVERT(VARCHAR,YEAR("Vigencia Tablero desde"))= "Año Hito")
				  OR
				  ( (CONVERT(VARCHAR,YEAR("Vigencia Tablero desde")+1)= "Año Hito" AND (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=2)) )
				  OR
				  ( (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde"))=0 )
				   )	  
				         THEN 
				A."VMNA12Replica"
				else A."VMNA12ILP" end as "Valor Meta Normalizada Años 1 2",


				  CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12')   
				         THEN 
					A."VMNA123Replica"
					else A."VMNA123ILP" end as "Valor Meta Normalizada Años 1 2 3",

                  A."Valor Real Año 1",
                  A."Valor Real Año 2",
                  A."Valor Real Año 3",
                  A."Valor Real Años 1 2",
                  A."Valor Real Años 1 2 3",

			CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO > concat("Año Hito", '12')
			then
			A."VRAReplica"
			else A."VRAILP" end as "Valor Real Acumulado",

                  A."Valor Real Acumulado_Mes",

			CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO > concat("Año Hito", '12')
			then
			A."VPAReplica"
			else A."VPAILP" end as "Valor Plan Acumulado",

			CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO > concat("Año Hito", '12')
			then
			A."VPANReplica"
			else A."VPANILP" end as "Valor Plan Acumulado Normalizada",

-- Valor metas año
				  CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12') AND "Vigencia Tablero desde" = "Año Hito" 
				         THEN 	
					A."VMA1Replica"
					else A."VMA1ILP" end as "Valor Meta Año 1",

					  CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12') AND (
					   ( (CONVERT(VARCHAR,YEAR("Vigencia Tablero desde")+1)= "Año Hito" AND (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=2)) )
					   OR
					   (  (CONVERT(VARCHAR,YEAR("Vigencia Tablero desde"))= "Año Hito" and (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=1)) )
					   OR
					   (  (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde"))=0 )
					  )
				         THEN 
					A."VMA2Replica"
					else A."VMA2ILP" end as "Valor Meta Año 2",

				  CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12') AND (
				   ( (CONVERT(VARCHAR,YEAR("Vigencia Tablero hasta"))= "Año Hito" AND (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=2)) )
				   OR
				   (  (CONVERT(VARCHAR,YEAR("Vigencia Tablero hasta"))= "Año Hito" AND (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=1)) )
				   OR
				   ( (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde"))=0 )	 			  
				  )	  
				         THEN 
					A."VMA3Replica"
					else A."VMA3ILP" end as "Valor Meta Año 3",

				  CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12') AND (
				  (CONVERT(VARCHAR,YEAR("Vigencia Tablero desde"))= "Año Hito")
				  OR
				  ( (CONVERT(VARCHAR,YEAR("Vigencia Tablero desde")+1)= "Año Hito" AND (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=2)) )
				  OR
				  ( (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde"))=0 )
				   )	  
				         THEN 
					A."VMA12Replica"
					else A."VMA12ILP" end as "Valor Meta Años 1 2",

			CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12')   
			then
			A."VMA123Replica"
			else A."VMA123ILP" end as "Valor Meta Años 1 2 3",

                  A."Valor Reto",
                  A."Valor Proyección Año 1",
                  A."Valor Proyección Año 2",
                  A."Valor Proyección Año 3",
                  A."Valor Proyección Años 1 2",
                  A."Valor Proyección Años 1 2 3",

			CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO > concat("Año Hito", '12')
			then
			A."AAIReplica"
			else A."AAIILP" end as "% Avance Acumulado ILP",

				CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12') AND (
				  (CONVERT(VARCHAR,YEAR("Vigencia Tablero desde"))= "Año Hito")
				  OR
				  ( (CONVERT(VARCHAR,YEAR("Vigencia Tablero desde")+1)= "Año Hito" AND (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=2)) )
				  OR
				  ( (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde"))=0 )
				   )	  
				         THEN 
					A."AIA12Replica"
					else A."AIA12ILP" end as "% Avance ILP Años 1 2",

			CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12') AND "Vigencia Tablero desde" = "Año Hito" 
			then
			A."AIA1Replica"
			else A."AIA1ILP" end as "% Avance ILP Año 1",

-- Cumplimiento Año
			CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12') AND "Vigencia Tablero desde" = "Año Hito" 
			then
			A."CA1Replica"
			else A."CA1ILP" end as "% Cumplimiento Año 1",

					  CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12') AND (
					   ( (CONVERT(VARCHAR,YEAR("Vigencia Tablero desde")+1)= "Año Hito" AND (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=2)) )
					   OR
					   (  (CONVERT(VARCHAR,YEAR("Vigencia Tablero desde"))= "Año Hito" and (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=1)) )
					   OR
					   (  (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde"))=0 )
					  )
				         THEN
					A."CA2Replica"
					else A."CA2ILP" end as "% Cumplimiento Año 2",

				  CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12') AND (
				   ( (CONVERT(VARCHAR,YEAR("Vigencia Tablero hasta"))= "Año Hito" AND (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=2)) )
				   OR
				   (  (CONVERT(VARCHAR,YEAR("Vigencia Tablero hasta"))= "Año Hito" AND (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=1)) )
				   OR
				   ( (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde"))=0 )	 			  
				  )	  
				         THEN
					A."CA3Replica"
					else A."CA3ILP" end as "% Cumplimiento Año 3",

				  CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12') AND (
				  (CONVERT(VARCHAR,YEAR("Vigencia Tablero desde"))= "Año Hito")
				  OR
				  ( (CONVERT(VARCHAR,YEAR("Vigencia Tablero desde")+1)= "Año Hito" AND (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=2)) )
				  OR
				  ( (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde"))=0 )
				   )	  
				         THEN 
					A."CA12Replica"
					else A."CA12ILP" end as "% Cumplimiento Años 1 2",

			CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12')   
			then
			A."CA123Replica"
			else A."CA123ILP" end as "% Cumplimiento Años 1 2 3",

			CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO > concat("Año Hito", '12')
			then
			A."CAReplica" 
			else A."CAILP" end as "% Cumplimiento Acumulado",
---- Valor Real Proyectado
			CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12') AND "Vigencia Tablero desde" = "Año Hito" 
			then
			A."VRPA1Replica"
			else 	A."VRPA1ILP" end as "Valor Real Proyectado Año 1",


					  CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12') AND (
					   ( (CONVERT(VARCHAR,YEAR("Vigencia Tablero desde")+1)= "Año Hito" AND (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=2)) )
					   OR
					   (  (CONVERT(VARCHAR,YEAR("Vigencia Tablero desde"))= "Año Hito" and (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=1)) )
					   OR
					   (  (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde"))=0 )
					  )
				         THEN 
					A."VRPA2Replica"
					else A."VRPA2ILP" end as "Valor Real Proyectado Año 2",

				  CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12') AND (
				   ( (CONVERT(VARCHAR,YEAR("Vigencia Tablero hasta"))= "Año Hito" AND (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=2)) )
				   OR
				   (  (CONVERT(VARCHAR,YEAR("Vigencia Tablero hasta"))= "Año Hito" AND (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=1)) )
				   OR
				   ( (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde"))=0 )	 			  
				  )	  
				         THEN 	
					A."VRPA3Replica"
					else A."VRPA3ILP" end as "Valor Real Proyectado Año 3",

				  CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12') AND (
				  (CONVERT(VARCHAR,YEAR("Vigencia Tablero desde"))= "Año Hito")
				  OR
				  ( (CONVERT(VARCHAR,YEAR("Vigencia Tablero desde")+1)= "Año Hito" AND (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde")=2)) )
				  OR
				  ( (YEAR("Vigencia Tablero hasta")-YEAR("Vigencia Tablero desde"))=0 )
				   )	  
				         THEN 
					A."VRPA12Replica"
					else A."VRPA12ILP" end as "Valor Real Proyectado Años 1 2",

			CASE WHEN "Hito / Indicador" = 'Hito' AND TIEMPO >= concat("Año Hito", '12')
			then
			A."VRPA123Replica"
			else A."VRPA123ILP" end as "Valor Real Proyectado Años 1 2 3"

					FROM
					(SELECT 

				  TI."Año",
                  TI."Año Hito",
                  TI."Cargo Responsable de Medición",
                  TI."Cargo Responsable de Medición 2",
                  TI."Correo Responsable de Medición",
                  TI."Correo Responsable de Medición 2",
                  TI."Corto Plazo / Largo Plazo",
                  TI."Detalle Indicador",
                  TI."Eje o Palanca",
                  TI."Empresa",
                  TI."Fecha de Carga",
                  TI."FK Indicador",
                  TI."FK Parametrización Indicador",
                  TI."FK Tablero",
                  TI."Vigencia Tablero desde",
                  TI."Vigencia Tablero hasta",
                  TI."Frecuencia",
                  TI."Gerencia",
                  TI."Grupo",
                  TI."Grupo Segmento",
                  TI."Hito / Indicador",
                  TI."ID Indicador",
                  TI."Indicador Referente",
                  TI."Nivel",
                  TI."Nombre Indicador",
                  TI."Nombre Responsable de Medición",
                  TI."Nombre Responsable de Medición 2",
                  TI."Número de Decimales para el Cálculo",
                  TI."Objetivo",
                  TI."Periodo",
                  TI."Plan Acum Periodos",
                  TI."Periodo Año",
                  TI."Rutina",
                  TI."Secuencia / Orden",
                  TI."Segmento",
                  TI."Sentido",
                  TI."Sigla Área",
                  TI."Tablero",
                  TI."Tiempo",
                  TI."Tipo Tablero",
                  TI."Unidad de Negocio Nivel 2",
                  TI."Unidad de Negocio Nivel 3",
                  TI."Valor Peso Indicador",
                  TI."Versión",
                  TI."VP Ejecutiva",
                  TI."FECHA_CARGA_SYNAPSE",
                  TI."FECHA_PROXIMA_ACTUALIZA_SYNAPSE",
                  TI."CM_RESUMEN",
				  TI.[_CC Drill Through Detalle KPI],	
				  TI.[_CC Hito/Ind],
				  TI.[_CC Reporta Periodo], 
				  TI.[_CC Valor Brecha],
				  TI.[_CC % Cumplimiento ILP Val],
				  TI.[.CC Drill Through Detalle KPI Panel], 
				  TI.[.CC Nombre Indicador - Detalle], 
				  TI.[CC Color Brecha], 
				  TI.[Hito/Ind Habilitador],
				  TI.[ActivoCumplimientoMin],
		          TI.[CumplimientoMinimo],
		          TI.[ReconocimientoMinimo],
				  TI.[Llave],  
				  TI.[Mensaje clave indicador], 
				  TI.[Mes],
				  TI.[Premisas], 
				  TI.[UnidadMedida],
				  TI.[.CC % Cumplimiento tablero Ban],
---- Valor Meta Año Normalizada
				  I."Valor Meta Normalizada Año 1" AS VMNA1replica,
				  TI."Valor Meta Normalizada Año 1" AS VMNA1ILP,
				  I."Valor Meta Normalizada Año 2" AS VMNA2replica,
				  TI."Valor Meta Normalizada Año 2" AS VMNA2ILP,
				  I."Valor Meta Normalizada Año 3" AS VMNA3replica,
				  TI."Valor Meta Normalizada Año 3" AS VMNA3ILP,
				  I."Valor Meta Normalizada Años 1 2" AS VMNA12replica,
				  TI."Valor Meta Normalizada Años 1 2" AS VMNA12ILP,
				  I."Valor Meta Normalizada Años 1 2 3" AS VMNA123replica,
				  TI."Valor Meta Normalizada Años 1 2 3" AS VMNA123ILP,
                  TI."Valor Real Año 1",
                  TI."Valor Real Año 2",
                  TI."Valor Real Año 3",
                  TI."Valor Real Años 1 2",
                  TI."Valor Real Años 1 2 3",
				  I."Valor Real Acumulado" AS VRAReplica,
				  TI."Valor Real Acumulado" AS VRAILP,
                  TI."Valor Real Acumulado_Mes",
				  I."Valor Plan Acumulado" AS VPAReplica,
				  TI."Valor Plan Acumulado" AS VPAILP,
				  I."Valor Plan Acumulado Normalizada" AS VPANReplica,
				  TI."Valor Plan Acumulado Normalizada" AS VPANILP,
---- Valor metas año
				  I."Valor Meta Año 1" AS VMA1replica,
				  TI."Valor Meta Año 1" AS VMA1ILP,
				  I."Valor Meta Año 2" AS VMA2replica,
				  TI."Valor Meta Año 2" AS VMA2ILP,
				  I."Valor Meta Año 3" AS VMA3replica,
				  TI."Valor Meta Año 3" AS VMA3ILP,
				  I."Valor Meta Años 1 2" AS VMA12replica,
				  TI."Valor Meta Años 1 2" AS VMA12ILP,
				  I."Valor Meta Años 1 2 3" AS VMA123replica,
				  TI."Valor Meta Años 1 2 3" AS VMA123ILP,
                  TI."Valor Reto",
                  TI."Valor Proyección Año 1",
                  TI."Valor Proyección Año 2",
                  TI."Valor Proyección Año 3",
                  TI."Valor Proyección Años 1 2",
                  TI."Valor Proyección Años 1 2 3",
				  I."% Avance Acumulado ILP" AS AAIreplica,
				  TI."% Avance Acumulado ILP" AS AAIILP,
				  I."% Avance ILP Años 1 2" AS AIA12replica,
				  TI."% Avance ILP Años 1 2" AS AIA12ILP,
				  I."% Avance ILP Año 1" AS AIA1replica,
				  TI."% Avance ILP Año 1" AS AIA1ILP,

---- Cumplimiento Año
				  I."% Cumplimiento Año 1" AS CA1replica,
				  TI."% Cumplimiento Año 1" AS CA1ILP,
				  I."% Cumplimiento Año 2" AS CA2replica,
				  TI."% Cumplimiento Año 2" AS CA2ILP,
				  I."% Cumplimiento Año 3" AS CA3replica,
				  TI."% Cumplimiento Año 3" AS CA3ILP,
				  I."% Cumplimiento Años 1 2" AS CA12replica,
				  TI."% Cumplimiento Años 1 2" AS CA12ILP,
				  I."% Cumplimiento Años 1 2 3" AS CA123replica,
				  TI."% Cumplimiento Años 1 2 3" AS CA123ILP,
				  I."% Cumplimiento Acumulado" AS CAreplica,
				  TI."% Cumplimiento Acumulado" AS CAILP,
---- Valor Real Proyectado
				   
				  I."Valor Real Proyectado Año 1" AS VRPA1replica,
				  TI."Valor Real Proyectado Año 1" AS VRPA1ILP,
				  I."Valor Real Proyectado Año 2" AS VRPA2replica,
				  TI."Valor Real Proyectado Año 2" AS VRPA2ILP,
				  I."Valor Real Proyectado Año 3" AS VRPA3replica,
				  TI."Valor Real Proyectado Año 3" AS VRPA3ILP,
				  I."Valor Real Proyectado Años 1 2" AS VRPA12replica,
				  TI."Valor Real Proyectado Años 1 2" AS VRPA12ILP,
				  I."Valor Real Proyectado Años 1 2 3" AS VRPA123replica,
				  TI."Valor Real Proyectado Años 1 2 3" AS VRPA123ILP

					FROM [ATOMO].[TEMPCVC_INDICADORES_ILP_replica] AS I
					RIGHT JOIN [ATOMO].[TMP2CVC_INDICADORES_ILP] AS  TI
					ON I."FK Tablero" = TI."FK Tablero"
					AND I."FK Indicador" = TI."FK Indicador"	
					AND I."FK Parametrización Indicador" = TI."FK Parametrización Indicador"
				  ) AS A;
GO