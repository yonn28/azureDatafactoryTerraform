
-- =============================================
-- Author:      Maria Alejandra Delgado
-- Create Date: 202-05-16
-- Description: Se crea la vista CVC_TH_ENTREGABLE_HITO_ILP la cual es un insumo para el tablero de ILP
-- =============================================

CREATE VIEW [ATOMO].[CVC_TH_ENTREGABLE_HITO_ILP]
AS SELECT 	   	
			A."Periodo", 
			A."Año Hito",
		   A."Acciones", 
		   A."Causas", 
		   A."Periodo_Vigencia",
		   	case when "Periodo" >= "Año Hito"	
			then
			A."FERreplica"
			when "Periodo" < "Año Hito"
			then A."FERILP"
			end as "Fecha de ejecución real",
           A."Llave foránea entregable", 
           A."Nombre del tablero", 
           A."LLave foranea del tablero", 
           A."Llave foránea parámetro indicador", 
           A."Premisa escenario alto entregable", 
           A."Premisa escenario bajo entregable", 
           A."Premisa escenario medio entregable", 
		   	case when "Periodo" >= "Año Hito"	
			then
			A."PCEReplica"
			when "Periodo" < "Año Hito"
			then A."PCEILP"
			end as "Porcentaje cumplimiento entregable",
           A."Valor cumplimiento escenario alto entregable", 
           A."Valor cumplimiento escenario bajo entregable",
	       A."Valor proyección escenario alto entregable", 
           A."Valor proyección escenario bajo entregable", 
		   	case when "Periodo" >= "Año Hito"	
			then
			A."VPMEreplica"
			when "Periodo" < "Año Hito"
			then A."VPMEILP"
			end as "Valor proyección escenario medio entregable",
		   	case when "Periodo" >= "Año Hito"	
			then
			A."VREreplica"
			when "Periodo" < "Año Hito"
			then A."VREILP"
			end as "Valor real entregable" ,  
		   	case when "Periodo" >= "Año Hito"	
			then
			A."VRFEReplica"
			when "Periodo" < "Año Hito"
			then A."VRFEILP"
			end as "Valor real final entregable",
		   A."Fecha",
           A."CVC_ENTREGABLES_HITO..Peso Entregable", 
           A."CVC_ENTREGABLES_HITO.Descripción Entregable", 
           A."CVC_ENTREGABLES_HITO.Fecha del Entregable", 
           A."Llave foránea Parametrización Indicador",  
           A."CVC_ENTREGABLES_HITO.Nombre Hito",
           A."CVC_ENTREGABLES_HITO.Unidad de Medida", 
           A."CVC_ENTREGABLES_HITO.Peso del Entregable", 
           A."CVC_ENTREGABLES_HITO.Plan Entregable", 
           A."CVD_ACTIVIDADES_ENTREGABLES_HITO.Descripción Actividad",
           A."CVD_ACTIVIDADES_ENTREGABLES_HITO.Fecha de Actividad", 
           A."CVD_ACTIVIDADES_ENTREGABLES_HITO.GK_ACTIVIDAD_ENTREGABLE_HITO", 
           A."CVD_CONFIGURACION_TABLERO.DESC_TABLERO_CVR", 
           A."CVD_CONFIGURACION_TABLERO.Detalle Indicador", 
           A."CVD_CONFIGURACION_TABLERO.Sigla Área", 
           A."CVD_CONFIGURACION_TABLERO.Tablero", 
           A."CVD_CONFIGURACION_TABLERO.TBG",
           A."CVD_CONFIGURACION_TABLERO.Valor Peso Indicador", 
           A.".Llave Actividad Entregable", 
           A.".CC Nombre Indicador - Detalle",
		   	case when "Periodo" >= "Año Hito"	
			then
			A."CAReplica"
			when "Periodo" < "Año Hito"
			then A."CAILP"
			end as "_CC Cumplimiento Acumulado",
           A."_CC Proy Año Hito Alto", 
           A."_CC Proy Año Hito Bajo",  
		   	case when "Periodo" >= "Año Hito"	
			then
			A."PAHMReplica"
			when "Periodo" < "Año Hito"
			then A."PAHMILP"
			end as "_CC Proy Año Hito Medio",
			case when "Periodo" >= "Año Hito"	
			then
			A."CMRReplica"
			when "Periodo" < "Año Hito"
			then A."CMRILP"
			end as "CM_RESUMEN",
			case when "Periodo" >= "Año Hito"	
			then
			A."EMEReplica"
			when "Periodo" < "Año Hito"
			then A."EMEILP"
			end as "Valor cumplimiento escenario medio entregable"
			from
			(
			SELECT TEH."Valor cumplimiento escenario medio entregable" as EMEILP, 
			TE."Valor cumplimiento escenario medio entregable" as EMEReplica, 
			TEH."Periodo", 
			concat(TEH."Año Hito", '12') AS "Año Hito",
		   TEH."Acciones", 
		   TEH."Causas", 
		   TEH."Periodo_Vigencia",
           TEH."Fecha de ejecución real" as FERILP,
		   TE."Fecha de ejecución real" as FERreplica,
           TEH."Llave foránea entregable", 
           TEH."Nombre del tablero", 
           TEH."LLave foranea del tablero", 
           TEH."Llave foránea parámetro indicador", 
           TEH."Premisa escenario alto entregable", 
           TEH."Premisa escenario bajo entregable", 
           TEH."Premisa escenario medio entregable", 
           TEH."Porcentaje cumplimiento entregable" as PCEILP, 
		   TE."Porcentaje cumplimiento entregable" as PCEreplica, 
           TEH."Valor cumplimiento escenario alto entregable", 
           TEH."Valor cumplimiento escenario bajo entregable",
	       TEH."Valor proyección escenario alto entregable", 
           TEH."Valor proyección escenario bajo entregable", 
           TEH."Valor proyección escenario medio entregable" as VPMEILP,
		   TE."Valor proyección escenario medio entregable" as VPMEreplica,
           TEH."Valor real entregable" as VREILP, 
		   TE."Valor real entregable" as VREreplica, 
           TEH."Valor real final entregable" as VRFEILP,  
		   TE."Valor real final entregable" as VRFEreplica,  
		   TEH."Fecha",
           TEH."CVC_ENTREGABLES_HITO..Peso Entregable", 
           TEH."CVC_ENTREGABLES_HITO.Descripción Entregable", 
           TEH."CVC_ENTREGABLES_HITO.Fecha del Entregable", 
           TEH."Llave foránea Parametrización Indicador",  
           TEH."CVC_ENTREGABLES_HITO.Nombre Hito",
           TEH."CVC_ENTREGABLES_HITO.Unidad de Medida", 
           TEH."CVC_ENTREGABLES_HITO.Peso del Entregable", 
           TEH."CVC_ENTREGABLES_HITO.Plan Entregable", 
           TEH."CVD_ACTIVIDADES_ENTREGABLES_HITO.Descripción Actividad",
           TEH."CVD_ACTIVIDADES_ENTREGABLES_HITO.Fecha de Actividad", 
           TEH."CVD_ACTIVIDADES_ENTREGABLES_HITO.GK_ACTIVIDAD_ENTREGABLE_HITO", 
           TEH."CVD_CONFIGURACION_TABLERO.DESC_TABLERO_CVR", 
           TEH."CVD_CONFIGURACION_TABLERO.Detalle Indicador", 
           TEH."CVD_CONFIGURACION_TABLERO.Sigla Área", 
           TEH."CVD_CONFIGURACION_TABLERO.Tablero", 
           TEH."CVD_CONFIGURACION_TABLERO.TBG",
           TEH."CVD_CONFIGURACION_TABLERO.Valor Peso Indicador", 
           TEH.".Llave Actividad Entregable", 
           TEH.".CC Nombre Indicador - Detalle",
           TEH."_CC Cumplimiento Acumulado" as CAILP, 
		   TE."_CC Cumplimiento Acumulado" as CAreplica, 
           TEH."_CC Proy Año Hito Alto", 
           TEH."_CC Proy Año Hito Bajo", 
           TEH."_CC Proy Año Hito Medio" as PAHMILP, 
		   TE."_CC Proy Año Hito Medio" as PAHMreplica, 
           TEH."CM_RESUMEN" as CMRILP,
		   TE."CM_RESUMEN" as CMRreplica
								 FROM [ATOMO].[TEMPCVC_TH_ENTREGABLE_HITO_ILP_replica] AS TE
								 RIGHT JOIN [ATOMO].[TMP2CVC_TH_ENTREGABLE_HITO_ILP]  AS TEH
								 ON
								     TE."Llave foránea parámetro indicador" = TEH."Llave foránea parámetro indicador" 
									 and TE."LLave foranea del tablero" = TEH."LLave foranea del tablero"
									 and TE."Llave foránea entregable" = TEH."Llave foránea entregable"
			) AS A;
GO
