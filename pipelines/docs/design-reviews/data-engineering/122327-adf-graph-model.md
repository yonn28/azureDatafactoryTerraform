# [Exploring Data Factory Graph](https://dev.azure.com/ecopetrolad/BI/_workitems/edit/122327/)

## Overview/Problem Statement

Ecopetrol currently manages all Data Factory pipelines within a single Data Factory instance. While this is a functional approach, there are a large number of resources being managed in a single place. Based on an object count across several branches, there are approximately (based on combined count across several branches):
 - Around 400 pipelines
 - Around 1100 datasets
 - Around 250 dataflows
 - Around 100 linked services
 - Around 15 top-level folders

Navigating all of these resources can be a bit challenging. Resources are divided into folders and subfolders, which immensely helps with organization, but the sheer size of this Data Factory adds a maintenance challenge to software developers, especially when managing code branches and merges.

This document attempts to break down the Data Factory's structure with help from the [Neo4j](https://neo4j.com/) graph database and its built-in visualizations. This breakdown will be the basis for a proposed update to Ecopetrol's Data Factory organization.

The following assumptions apply:
 - All data for this analysis (and recommendations) is obtained from the [DF-AEU-ECP-DEV-DATAPLATFORMDEV](https://portal.azure.com/#@ecopetrol.onmicrosoft.com/resource/subscriptions/c818ac3b-d6f3-4229-a359-0d5ac47a4317/resourceGroups/RG-AEU-ECP-DEV-BigDataFactory/providers/Microsoft.DataFactory/factories/DF-AEU-ECP-DEV-DATAPLATFORMDEV/overview) Data Factory instance



## Goals/In-Scope

- Discover which resources are required for each top-level domain (*ADF folder*)
- Discover which resources are shared across domains
- Discover which resources are currently not in use
- Propose an alternative organizational approach based on splitting this Data Factory instance into multiple instances

## Non-goals / Out-of-Scope

* No new pipelines or dataflows are being proposed; this analysis and design proposal is stricty based on existing pipelines and flows

## Proposed Design

Ecopetrol's Azure Data Factory can be split into multiple instances, to help reduce complexity (number of resources managed within a single pipeline).

Very few Data Factory resources are shared. Those Data Factory resources that *are* shared across instances (currently shared across *Domains*, represented as Folders) should be added to a Azure Data Factory template.

There is no need to share the hundreds of additional Data Factory resources amongst every Data Factory instance, as this will only add complexity and *technical debt*.

All unused resources should be removed from all Data Factory instances. Given that all configurations are stored in Azure DevOps (git), nothing will actually be lost; all content is retrievable from prior commits.



## Analysis

The following is a deeper analysis that this set of recommendations is based off.
### Discovery: In-use Resources

Based on Ecopetrol's partitioning of pipelines across folders, there is very little sharing taking place across these folders. After careful analysis, the following resources are shared:

#### Shared Integration Runtimes

To discover shared Integration Runtimes:

```sql
match path=(ls:LinkedService)-[:USES_IR]->(ir:IntegrationRuntime)
return path
```

 - `IrOnpremiseECP` (used by approximately 41 Linked Services)

#### Shared LinkedServices across folders

To discover which Integration Runtimes are seen across multiple folders:

```sql
match path=(d:Domain)-[*]->(ds:Dataset)-[hls:HAS_LINKED_SERVICE]->(ls:LinkedService )
with ls.Name as Name, count(distinct d) as DomainCount, collect(distinct d.Name) as DomainNames
where DomainCount > 1
return Name, DomainCount, DomainNames
order by DomainCount desc
```

|Name|Count|Domains|
|---|---|---|
|`Synapse_DWAEUECPDEVMAIN`|10|`GRB, GRC, ENERGIA, PERFORACION, CADENA_SUMINISTROS, DM_Cadena_Suministro, FAT, EXPLORACION, INVERSIONES, REFINACION`|
|`Synapse_DW`|4|`GRB, ENERGIA, PERFORACION, REFINACION`|
|`dlaeuecpdevcadenasum`|3|`ERERGIA, CADENA_SUMINISTROS, DM_Cadena_Suministro`|
|`LS_DMTOMADEDECISIONES_DEV`|3|`APP_ATOMO_UAT, APP_ATOMO_PROD, APP_ATOMO_TEST`|
|`dbaeuecpdevatomotd` |3|`APP_ATOMO_UAT, APP_ATOMO_PROD, APP_ATOMO_TEST`|
|`Oracle_RISGRB`|2|`GRB, REFINACION`|
|`dlaeuecpdevenergia`|2|`ENERGIA, REFINACION`|
|`SapHana_BW4`|2|`ENERGIA, DM_Cadena_Suministro`|
|`Dlaeuecpdevrefinacion`|2|`ENERGIA, REFINACION`|
|`Oracle_SIO_GRC`|2|`ENERGIA, REFINACION`|
|`dlaeuecpdevexploracion`|2|`ENERGIA, EXPLORACION`|
|`dbaeuecpuatatomotd`|2|`APP_ATOMO_UAT, APP_ATOMO_PROD`|
|`saaeuecpuatatomo`|2|`APP_ATOMO_UAT, APP_ATOMO_PROD`|
|`saaeuecpdevatomo`|2|`APP_ATOMO_UAT, APP_ATOMO_PROD`|
|`SapHana_ConsultaDMInventarios`|2|`CADENA_SUMINISTROS, DM_Cadena_Suministro`|
|`SapHana_ConsultaDMProduccion`|2|`CADENA_SUMINISTROS, DM_Cadena_Suministro`|

### Discovery: Unused Resources
There are many unused resources, and these should be safe to remove from the current Data Factory instances, until they are needed in the future.

#### Unused Linked Services:

Linked Services are used by Datasets. This query shows all Linked Services that aren't connected to a Dataset:

```sql
// Unused Linked Services
match (ls:LinkedService)
where not ((:Dataset)-[:HAS_LINKED_SERVICE]->(ls))
and not ((:Activity)-[:HAS_LINKED_SERVICE]->(ls))
return ls.Name
```


|Linked Service |
|--- |
|`AzureSynapseAnalytics1`|
|`CGM_WebServices`|
|`CGM_WebServices1`|
|`FTP_ENERGIA`|
|`KV_AEU_ECP_DEV_Password`|
|`KV_AEU_ECP_QAS_SHARED`|
|`KV_AEU_ECP_SHARED`|
|`KV_AEU_ECP_Shared`|
|`LS_DMTOMADEDECISIONES_PRD`|
|`LS_DM_RECURSOS_DEV`|
|`LS_KVAEUECPUATPassword`|
|`Oracle GRB`|
|`Oracle GRC`|
|`Oracle1_SILAB_GRB_Produccion`|
|`Oracle1_SILAB_GRC_Produccion`|
|`Oracle_SIOGRB`|
|`Oracle_SIO_GRB`|
|`SQLMI_ASC_ECP`|
|`SapHana1`|
|`SapHana_ATOMO_DEV`|
|`SapHana_ATOMO_PRD`|
|`SapHana_ConsultaCostos`|
|`SapHana_ConsultaInventarios`|
|`SapHana_projecppm_Productivo`|
|`SapOpenHub1`|
|`SapTableECCInversiones`|
|`SqlServer_AOXT_GRC`|
|`SqlServer_GateTecnico_Calidad`|
|`SqlServer_GateTecnico_Desarrollo`|
|`XM_WebServices_Dia`|
|`XM_WebServices_Hora`|
|`XM_WebServices_Mensual`|
|`databricks_CAE`|
|`dbaeuecpprdatomotd`|
|`dlaeuecpdevdatafabric`|
|`dsaeuecpdevbigdatafab`|



#### Unused Datasets

Datasets may be used directly by an Activity, or from a Dataflow that is connected to an Activity. More simply, Datasets must be used by *something*. This query returns the collection of Datasets that have nothing using them:

```sql
match (ds:Dataset)
where not (()-->(ds))
return ds.Name as Name
order by ds.Name
```

This query returns 235 unused datasets:

|Name|
|----|
|`Avro1`|
|`Borrar_Dvelasquez`|
|`DS_SINK_ATOMOPROD_HANA_DimActividadesEntregableHito`|
|`DS_SINK_ATOMOPROD_HANA_DimComponente`|
|`DS_SINK_ATOMOPROD_HANA_DimComponenteVista`|
|`DS_SINK_ATOMOPROD_HANA_DimConfiguracionTablero`|
|`DS_SINK_ATOMOPROD_HANA_DimConfiguracion_CVR`|
|`DS_SINK_ATOMOPROD_HANA_DimContextoHito`|
|`DS_SINK_ATOMOPROD_HANA_DimEjePalanca`|
|`DS_SINK_ATOMOPROD_HANA_DimEntregablesHito`|
|`DS_SINK_ATOMOPROD_HANA_DimObjetivo`|
|`DS_SINK_ATOMOPROD_HANA_DimSegmento`|
|`DS_SINK_ATOMOPROD_HANA_DimTablero`|
|`DS_SINK_ATOMOPROD_HANA_THDesempenoIndicador`|
|`DS_SINK_ATOMOPROD_Hana_DIMEstructuraDespliegue`|
|`DS_SINK_ATOMOPROD_Hana_DimEntregableHito`|
|`DS_SINK_ATOMOPROD_Hana_THActividadEntregableHito`|
|`DS_SINK_ATOMOPROD_Hana_THEntregableHito`|
|`DS_SINK_ATOMOPROD_Hana_THHito`|
|`DS_SINK_ATOMOPROD_Hana_TMP_FECHA_CORTE`|
|`DS_SINK_ATOMOPROD_SQL_ConfiguracionCvr`|
|`DS_SINK_ATOMOPROD_SQL_DimActividadesEntregableHito`|
|`DS_SINK_ATOMOPROD_SQL_DimComponente`|
|`DS_SINK_ATOMOPROD_SQL_DimConfiguracionTablero`|
|`DS_SINK_ATOMOPROD_SQL_DimContextoHito`|
|`DS_SINK_ATOMOPROD_SQL_DimEjePalanca`|
|`DS_SINK_ATOMOPROD_SQL_DimEntregablesHito`|
|`DS_SINK_ATOMOPROD_SQL_DimIndicador`|
|`DS_SINK_ATOMOPROD_SQL_DimObjetivo`|
|`DS_SINK_ATOMOPROD_SQL_DimParamIndicador`|
|`DS_SINK_ATOMOPROD_SQL_DimSegmento`|
|`DS_SINK_ATOMOPROD_SQL_DimTablero`|
|`DS_SINK_ATOMOPROD_SQL_EstructuraDespliegue`|
|`DS_SINK_ATOMOPROD_SQL_THComponente`|
|`DS_SINK_ATOMOPROD_SQL_staging_THComponente_Automatizado`|
|`DS_SINK_ATOMOPROD_SQL_tmpFechaCorte`|
|`DS_SINK_ATOMOUAT_SQL_THComponente`|
|`DS_SINK_RISGRB_SYNAPSE_CARGASPRODUCCIONES_UNIDADES`|
|`DS_SINK_SQL_THComponente`|
|`DS_SOURCE_ATOMOPROD_Dimobjetivo`|
|`DS_SOURCE_ATOMOPROD_ExcelMaestro_ConfiguracionCvr`|
|`DS_SOURCE_ATOMOPROD_ExcelMaestro_ContextoHito`|
|`DS_SOURCE_ATOMOPROD_ExcelMaestro_EjePalanca`|
|`DS_SOURCE_ATOMOPROD_ExcelMaestro_EstructuraDespliegue`|
|`DS_SOURCE_ATOMOPROD_ExcelMaestro_Instrucciones`|
|`DS_SOURCE_ATOMOPROD_ExcelMaestro_Objetivo`|
|`DS_SOURCE_ATOMOPROD_ExcelMaestro_Segmento`|
|`DS_SOURCE_ATOMOPROD_ExcelMaestro_Tablero`|
|`DS_SOURCE_ATOMOPROD_Excel_Actividades_Entregables`|
|`DS_SOURCE_ATOMOPROD_Excel_Configuracion_Tablero`|
|`DS_SOURCE_ATOMOPROD_Excel_Entregables_Hito`|
|`DS_SOURCE_ATOMOPROD_HANA_ComponentesAutomatizados`|
|`DS_SOURCE_ATOMOPROD_HANA_DimTiempoCarga`|
|`DS_SOURCE_ATOMOPROD_SQL_DIMEstructuraDespliegue`|
|`DS_SOURCE_ATOMOPROD_SQL_DIM_ESTRUCTURA_DESPLIEGUE`|
|`DS_SOURCE_ATOMOPROD_SQL_DimActividadesEntregableHito`|
|`DS_SOURCE_ATOMOPROD_SQL_DimComponente`|
|`DS_SOURCE_ATOMOPROD_SQL_DimComponenteVista`|
|`DS_SOURCE_ATOMOPROD_SQL_DimConfiguracionTablero`|
|`DS_SOURCE_ATOMOPROD_SQL_DimConfiguracion_CVR`|
|`DS_SOURCE_ATOMOPROD_SQL_DimContextoHito`|
|`DS_SOURCE_ATOMOPROD_SQL_DimEjePalanca`|
|`DS_SOURCE_ATOMOPROD_SQL_DimEntregablesHito`|
|`DS_SOURCE_ATOMOPROD_SQL_DimObjetivo`|
|`DS_SOURCE_ATOMOPROD_SQL_DimParamIndicador`|
|`DS_SOURCE_ATOMOPROD_SQL_DimParamIndicador_V2`|
|`DS_SOURCE_ATOMOPROD_SQL_DimParametrizacion`|
|`DS_SOURCE_ATOMOPROD_SQL_DimSegmento`|
|`DS_SOURCE_ATOMOPROD_SQL_DimTablero`|
|`DS_SOURCE_ATOMOPROD_SQL_THActividadEntregableHito`|
|`DS_SOURCE_ATOMOPROD_SQL_THDesempenoIndicador`|
|`DS_SOURCE_ATOMOPROD_SQL_THEntregableHito`|
|`DS_SOURCE_ATOMOPROD_SQL_THHito`|
|`DS_SOURCE_ATOMOUAT_Dimobjetivo`|
|`DS_SOURCE_ATOMOUAT_HANA_DimTiempoCarga`|
|`DS_SOURCE_ATOMOUAT_SQL_DIM_ESTRUCTURA_DESPLIEGUE`|
|`DS_SOURCE_ATOMOUAT_SQL_DimParamIndicador_V2`|
|`DS_SOURCE_RISGRB_SQL_CARGASPRODUCCIONES_UNIDADES`|
|`DS_SOURCE_SQL_DIM_ESTRUCTURA_DESPLIEGUE`|
|`DS_SOURCE_SQL_DimComponente`|
|`DS_SOURCE_SQL_DimComponenteVista`|
|`DS_SOURCE_SQL_DimConfiguracionTablero`|
|`DS_SOURCE_SQL_DimConfiguracion_CVR`|
|`DS_SOURCE_SQL_DimContextoHito`|
|`DS_SOURCE_SQL_DimFormulaComponente`|
|`DS_SOURCE_SQL_DimParamIndicador`|
|`DS_SOURCE_SQL_DimSegmento`|
|`DS_SOURCE_SQL_THActividadEntregableHito`|
|`DS_SOURCE_SQL_THEntregableHito`|
|`DS_Sink_DIM_EVENTO_PRUEBA`|
|`DS_Sink_DIM_FILIAL_GERENCIA_Pruebas_asa`|
|`DS_Sink_DIM_GEOGRAFIA_GT_asa`|
|`DS_Sink_DIM_MALLA_asa_copy1`|
|`DS_Sink_SQL_tmpFechaCorteHana`|
|`DS_Sink_TH_ABAND_RECAM_MONIT_DETALLE_COSTO_asa`|
|`DS_Sink_tmp_Roadmap`|
|`DS_Sorce_SQL_THHito`|
|`DS_Source_ATOMO_SQL_THComponente`|
|`DS_Source_Dimobjetivo`|
|`DS_Source_HANA_DimTiempoCarga`|
|`DS_Source_SQL_DIMEstructuraDespliegue`|
|`DS_Source_SQL_DimActividadesEntregableHito`|
|`DS_Source_SQL_DimTiempoCarga`|
|`DS_Source_stgexploracion_BD_Control_Opex`|
|`DS_Source_stgexploracion_Base_PBC`|
|`DS_Source_stgexploracion_CAPEX`|
|`DS_Source_stgexploracion_DIS_LICENSEE`|
|`DS_Source_stgexploracion_FC_ANA`|
|`DS_Source_stgexploracion_FC_PRICE`|
|`DS_Source_stgexploracion_Homologa_Costos_VEX`|
|`DS_Source_stgexploracion_Homologa_Oportunidad_Bloque`|
|`DS_Source_stgexploracion_IndicadoresVEX`|
|`DS_Source_stgexploracion_Indicadores_Proyectos_PBC`|
|`DS_Source_stgexploracion_PozosIntegridad`|
|`DS_Source_stgexploracion_PozosVisitas`|
|`DS_Source_stgexploracion_ProyVEX_MonitoreoCosto`|
|`DS_Source_stgexploracion_Proy_VEX_Alertas`|
|`DS_Source_stgexploracion_Proy_VEX_Riesgos`|
|`DS_Source_stgexploracion_Proyectos_por_PBC`|
|`DS_Source_stgexploracion_REP_FC_PI_WI_NOM_IRR`|
|`DS_Source_stgexploracion_REP_FC_PI_WI_NOM_NPV`|
|`DS_Source_stgexploracion_REP_FC_PI_WI_NOM_PI`|
|`DS_Source_stgexploracion_REP_FC_PI_WI_SC_IRR`|
|`DS_Source_stgexploracion_REP_FC_PI_WI_SC_NPV`|
|`DS_Source_stgexploracion_REP_FC_PI_WI_SC_PI`|
|`DS_Source_stgexploracion_REP_FC_PROP`|
|`DS_Source_stgexploracion_REP_FC_P_P_INDICS_CPX_PR`|
|`DS_Source_stgexploracion_REP_FC_P_P_INDICS_OPX_PR`|
|`DS_Source_stgexploracion_REP_FC_SETTINGS`|
|`DS_Source_stgexploracion_REP_FC_WRK_RES_TP_OE_FI`|
|`DS_Source_stgexploracion_REP_SEG_ANA`|
|`DS_Source_stgexploracion_REP_SEG_NET_RES_ACC_OE_FI`|
|`DS_Source_stgexploracion_REP_SEG_PROP`|
|`DS_Source_stgexploracion_REP_SEG_REC_RES_ACC_OE_FI`|
|`DS_Source_stgexploracion_REP_SEG_RISK`|
|`DS_Source_stgexploracion_REP_SEG_WI_RES_UNCS_OE_FI`|
|`DS_Source_stgexploracion_SEGUIMIENTOEJECPPTO`|
|`DS_Source_stgexploracion_SEG_BLOCK`|
|`DS_Source_stgexploracion_SEG_PROP`|
|`DS_Source_stginversiones_Departamento`|
|`DS_Source_stginversiones_Municipio`|
|`DS_Source_stginversiones_Pais`|
|`DS_Source_stgperforacion_CD_HOLE_SECT`|
|`DS_Source_stgperforacion_CD_LESSON_ACTION`|
|`DestinationDataset_0nr`|
|`DestinationDataset_0tl`|
|`DestinationDataset_6r3`|
|`DestinationDataset_ahi`|
|`DestinationDataset_ef4`|
|`DestinationDataset_iz6`|
|`DestinationDataset_pwh`|
|`DestinationDataset_uxh`|
|`DestinationDataset_v3b`|
|`DestinationDataset_vg2`|
|`DestinationDataset_yrf`|
|`DestinationDataset_yz5`|
|`ENERGIA_XM_FILES`|
|`Json1`|
|`OracleTable1`|
|`OrigenTestHANADMHUB`|
|`Parquet1_cgm_json`|
|`Parquet3`|
|`QAS_TH_CGM_MATRIZ_CONSUMO`|
|`QAS_TH_COSTO_CONTABLE_DOWN`|
|`QAS_TH_COSTO_CONTABLE_UP`|
|`QAS_TH_COSTO_FINANCIERO_DOWN`|
|`SIN_DIM_POZO_TEST`|
|`SIN_DIM_POZO_curated`|
|`SOUPROYECTADMRecursos`|
|`SYNDIMESTRUCTURAGT`|
|`SYN_PERFORACION_DIM_DERRAMES_asa`|
|`SYN_PERFORACION_DIM_POZO_asa`|
|`SourceDataset_0nr`|
|`SourceDataset_0tl`|
|`SourceDataset_6r3`|
|`SourceDataset_ahi`|
|`SourceDataset_ef4`|
|`SourceDataset_hir`|
|`SourceDataset_iz6`|
|`SourceDataset_pwh`|
|`SourceDataset_qev`|
|`SourceDataset_uxh`|
|`SourceDataset_v3b`|
|`SourceDataset_vg2`|
|`SourceDataset_yrf`|
|`SourceDataset_yz5`|
|`dsSynapseResumenTagPI`|
|`dsSynapseResumenTagPI_Destino`|
|`ds_DestinoCostos`|
|`ds_Synapse_TH_PRU_DESPACHO_AGG`|
|`ds_Synapse_TH_PRU_DESPACHO_G`|
|`ds_adl_ad09client`|
|`ds_adl_crd_balanceblancos_gas_parquet`|
|`ds_adl_indicadorperdidas_HomologacionNivel4_3_xlsx`|
|`ds_adl_indicadorperdidas_Homologacion_Gerencia_Vicepresidencia_xlsx`|
|`ds_adl_indicadorperdidas_centro_almacen_xlsx`|
|`ds_adl_indicadorperdidas_datosentradas_xlsx`|
|`ds_adl_indicadorperdidas_datosperdidas_xlsx`|
|`ds_adl_maestro_balance_producto_parquet`|
|`ds_adl_maestro_balance_producto_xlsx`|
|`ds_adl_maestro_balance_tipo_parquet`|
|`ds_adl_maestro_balance_tipo_xlsx`|
|`ds_adl_maestro_balance_variable_parquet`|
|`ds_adl_maestro_balance_variable_xlsx`|
|`ds_adl_maestro_macro_parquet`|
|`ds_adl_maestro_movimiento_parquet`|
|`ds_adl_maestro_movimientos_xlsx`|
|`ds_adl_str_indicadorperdidas_centro_almacen_parquet`|
|`ds_adl_str_indicadorperdidas_datosentradas_parquet`|
|`ds_adl_str_indicadorperdidas_homologacion_gerencia_vicepresidencia_parquet`|
|`ds_adl_str_indicadorperdidas_homologacion_nivel4_nivel3_parquet`|
|`ds_adl_str_movimiento_material_parquet`|
|`ds_adls_rest_serv_api_xm`|
|`ds_adls_rest_telmetergy`|
|`ds_adls_serv_api_xm_xml`|
|`ds_adls_xls_energia_Iniciativa_PropuestaCodIniciativa`|
|`ds_adls_xls_energia_Margen_PropuestaCodIniciiativa`|
|`ds_adls_xm_ademin`|
|`ds_adls_xm_files`|
|`ds_adls_xm_folder`|
|`ds_adls_xm_folder_bin`|
|`ds_adls_xm_grip`|
|`ds_adls_xm_tgrl_Synapse`|
|`ds_ftp_xm_ademin`|
|`ds_ftp_xm_files`|
|`ds_ftp_xm_files_publicok`|
|`ds_ftp_xm_files_usuariok`|
|`ds_ftp_xm_grip_afac`|
|`ds_rest_telmetergy`|
|`ds_sdls_ad09client`|
|`ds_shana_sys_bic_movimiento_material_core`|
|`ds_syn_eventos_calidad_impactos_economicos`|
|`ds_syn_eventos_calidad_indicador_calidad`|
|`ds_syn_th_resumen_perdidas`|
|`ls_adls_telmetergy_xml`|

#### Unused Dataflows

Dataflows are connected to Activities. It's possible to view all dataflows not used by an Activity. More simply, a dataflow must be used by *something*. This query shows all Dataflows that have nothing using them:

```sql
match (df:Dataflow)
where not (()-->(df))
return df.Name as Name
order by df.Name
```

|Name|
|----|
|`DF_ATOMOPROD_ComponentesAutomatizados`|
|`DF_ATOMOPROD_DimActividadesEntregableHito`|
|`DF_ATOMOPROD_DimConfiguracionCvr`|
|`DF_ATOMOPROD_DimConfiguracionTablero`|
|`DF_ATOMOPROD_DimContextoHito`|
|`DF_ATOMOPROD_DimEjePalanca`|
|`DF_ATOMOPROD_DimEntregablesHito`|
|`DF_ATOMOPROD_DimEstructuraDespliegue`|
|`DF_ATOMOPROD_DimObjetivo`|
|`DF_ATOMOPROD_DimSegmento`|
|`DF_ATOMOPROD_DimTablero`|
|`DF_ATOMOPROD_tmpFechaCorteHana`|
|`DF_ATOMOUAT_ComponentesAutomatizados`|
|`DF_ATOMO_DimContextoHito`|
|`DF_ATOMO_DimEjePalanca`|
|`DF_ATOMO_DimEntregablesHito`|
|`DF_ATOMO_DimSegmento`|
|`DF_ATOMO_DimTablero`|
|`DF_ATOMO_tmpFechaCorteHana`|
|`DF_ATRIBUTOS_FRONTERAS_BK`|
|`DF_Atomo_ComponentesAutomatizados`|
|`DF_DIM_BUCKET_JERARQUIA_PORTAFOLIO_TMP_asa`|
|`DF_DIM_DISCIPLINA_FLUJO_TRABAJO_asa`|
|`DF_DIM_ESTRUCTURA_GT_asa`|
|`DF_DIM_INVERSION_ELEMENTO_PPM_asa`|
|`DF_DIM_INVERSION_FASES_asa`|
|`DF_DIM_LOGICA_CLASIFICACION_asa`|
|`DF_DIM_TAREA_FLUJO_TRABAJO_asa`|
|`DF_DIM_USUARIO_GT_asa`|
|`DF_EXPLORACION_DIM_ABANDONO_RECAM_asa`|
|`DF_EXPLORACION_DIM_CUENCA_asa`|
|`DF_EXPLORACION_DIM_HOMOLOGA_ESTADO_POZO_asa`|
|`DF_EXPLORACION_DIM_HOMOL_BLOQ_GEOX_SIGPE`|
|`DF_EXPLORACION_DIM_PROYECTO_VEX_SISMICA_asa`|
|`DF_EXPLORACION_TH_ABAND_RECAM_MONIT_ABAND_RECAM_asa`|
|`DF_EXPLORACION_TH_INDICADORES_HSE_asa`|
|`DF_EXPLORACION_TH_POZO_EXPLORATORIO_PRUEBAS_asa`|
|`DF_EXPLORACION_TH_PROY_VEX_MONITOREO_SISMICA_asa`|
|`DF_EXPLORACION_TH_PROY_VEX_MONIT_POZO_EXPLORATORIO_asa`|
|`DF_FLUJO_TRABAJO_asa`|
|`DF_PERFORACION_DIM_COSTO_asa_PRUEBA`|
|`DF_PERFORACION_DIM_DETALLE_DIARIO_asa_PRUEBA`|
|`DF_TH_PLANEACION_EJECUCION_FINANCIERA_asa`|
|`QAS_DF_COSTOS_CGM`|
|`QAS_DF_EMPSII`|
|`QAS_DF_MEM_AUTO`|
|`TH_FACT_PLAN_DESPACHO_CP`|
|`TH_INDICADORES_EFICIENCIAS_prueba_inicial`|
|`dataflow1_copy2`|
|`dataflow2`|
|`dataflow5`|
|`dataflow6_copy1`|
|`dataflow_fur_grb`|
|`df_Eventos_GestionCalidadImpactos`|
|`df_balance_productos`|
|`df_crt_indicador_perdidas_centro_logistico`|
|`df_crt_indicador_perdidas_factores_conversion`|
|`df_crt_indicador_perdidas_material_tipo_producto`|
|`df_crt_indicador_perdidas_tipo_movimiento_perdida`|
|`df_dim_centro_almacen`|
|`df_dim_fur_ee`|
|`df_dim_movimientos`|
|`df_indicador_perdidas_centroalmacen`|
|`df_indicador_perdidas_unides_medida`|
|`df_lookback`|
|`df_produccion`|
|`df_th_produccion`|


#### Pipelines not in folders

There is only one type of object that has a Pipeline: a Domain (known in ADF as a *Folder*). To determine if there are any Pipelines not arranged into a folder, run this query:

```sql
match (p:Pipeline)
where not (()-[:HAS_PIPELINE]->(p))
return p.Name
```
More simply, a pipeline must be used by *something*. This query shows all pipelines that have nothing using them (meaning, they are not associated with a Folder / Domain):

```sql
match (p:Pipeline)
where not (()-->(p))
return p.Name
```

|Name|
|----|
|`Borrar_Data_PSONLINE_DMPROYECTOS`|
|`COPY_SPO_Synapse`|
|`CopyPipeline_6k8`|
|`CopyPipeline_borrar_energ`|
|`CopyPipeline_cyl`|
|`CopyPipeline_prueba_polybase`|
|`CopyPipeline_whk`|
|`Copy_CriteriosUnidades_VW_PolyBase`|
|`Copy_CriteriosUnidades_Vw`|
|`Copy_FTP_Reserva`|
|`Copy_PI_System_to_synapse`|
|`Copy_ProduccionVol_Vw`|
|`Copy_ProyectosEDP_Vw`|
|`Copy_RISGRB_LimitesUnidades_To_Synapse`|
|`Copy_RISGRB_TagPI_to_Synapse`|
|`Copy_RISGRB_Unidades_To_Synapse`|
|`Copy_RIS_LimUnidades_To_Synapse`|
|`Copy_RIS_to_synapse`|
|`CopyfilefromSharePointOnline`|
|`borrar_testIRperfo`|
|`cosmosdb`|
|`pipeline2`|

### About diagrams

Every Neo4j query may be run interactively within a browser window. For queries that return nodes (full objects, like an Activity) or paths (subgraphs between nodes, connected via relationships), a resulting graph my be viewed.

For example, this query, showing shared Integration Runtimes, may be viewed as a graph in the Neo4j browser:


```sql
match path=(ls:LinkedService)-[:USES_IR]->(ir:IntegrationRuntime)
return path
```

## Technology

Discovery was done through use of Neo4j, a graph database.


## Non-Functional Requirements

n/a

## Dependencies

This analysis is dependent on having access to the Ecopetrol Azure Data Factory instance, and requires the use of Docker and Neo4j.

## Risks & Mitigation

This analyis is based on a known list of deveopment and production branches. Should branches be added or removed, the analysis results will change.

## Open Questions

- Are any of the identified unused resources used somewhere else?
- Are there any mis-identified resources?

## Additional References

n/a
