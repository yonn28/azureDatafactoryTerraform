
-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-05-16
-- Description: Se crea la vista CVC_TH_ACTIVIDAD_ENTREGABLE_HITO la cual es un insumo para el tablero Paneles y TBG's

-- Update Date: 2022-06-06
-- Author:      Diego Rangel
-- Description: Se crea el campo .LLave Actividad Entregable, con la configuracion necesaria para tablero de Paneles y TBGs
-- =============================================

 CREATE VIEW ATOMO.CVC_TH_ACTIVIDAD_ENTREGABLE_HITO AS 

SELECT FK_HITO,
	   FK_PARAM_INDICADOR,
	   FK_ENTREGABLE,
	   FK_ACTIVIDAD,
	   FK_PERIODO,
	   DESC_CORREO_USUARIO,
	   DTM_FECHA_EVENTO_REGISTRO,
	   DTM_FECHACARGA,
	   SUM(IND_CUMPLIMIENTO) AS IND_CUMPLIMIENTO,
	   CAST(FK_PERIODO AS VARCHAR) + '-' + CAST(FK_ENTREGABLE AS VARCHAR) + '-' + CAST(FK_ACTIVIDAD AS VARCHAR) AS ".LLave Actividad Entregable"

FROM [ATOMO].[DWH.FACT_ACTIVIDAD_ENTREGABLE_HITO]

GROUP BY FK_HITO,
		FK_PARAM_INDICADOR,
		FK_ENTREGABLE,
		FK_ACTIVIDAD,
		FK_PERIODO,
		DESC_CORREO_USUARIO,
		DTM_FECHA_EVENTO_REGISTRO,
		DTM_FECHACARGA
