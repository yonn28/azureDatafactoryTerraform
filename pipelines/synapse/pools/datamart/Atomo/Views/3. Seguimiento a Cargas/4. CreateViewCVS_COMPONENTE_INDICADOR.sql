-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-08-13
-- Description: Se crea la vista CVS_COMPONENTE_INDICADOR la cual es un insumo para el tablero Seguimiento a Cargas.
-- =============================================

CREATE VIEW ATOMO.CVS_COMPONENTE_INDICADOR
AS SELECT dpi."GK_PARAM_INDICADOR" AS "FK_PARAM_INDICADOR",
	   dcv."ID_COMPONENTE" AS "ID_COMPONENTE",
	   dc."GK_COMPONENTE" AS "FK_COMPONENTE",
	   dcv."DESC_FORMULA"
							
FROM [ATOMO].[DWH.DIM_COMPONENTE_VISTA] dcv
     INNER JOIN [ATOMO].[DWH.DIM_INDICADOR] di
        ON dcv."FK_INDICADOR" = di."GK_INDICADOR"
     INNER JOIN [ATOMO].[DWH.DIM_PARAM_INDICADOR] dpi 
        ON dpi."FK_INDICADOR" = di."GK_INDICADOR" 
        AND dpi."DESC_DETALLE_INDICADOR" = dcv."DESC_DETALLE_INDICADOR"
     INNER JOIN [ATOMO].[DWH.DIM_COMPONENTE] dc 
        ON dc."ID_COMPONENTE" = dcv.ID_COMPONENTE