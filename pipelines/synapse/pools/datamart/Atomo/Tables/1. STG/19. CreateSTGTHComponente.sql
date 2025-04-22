-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-07-29
-- Description: Se crea la tabla STG.TH_COMPONENTE la cual es un insumo para las cargas DWH
-- =============================================

CREATE TABLE [ATOMO].[STG.TH_COMPONENTE]
(
     FK_COMPONENTE BIGINT ,
	 FK_PERIODO BIGINT ,
	 VLR_REAL_PERIODO DECIMAL(25,10) ,
	 VLR_REAL_ACUM DECIMAL(25,10) ,
	 DTM_FECHACARGA DATETIME,
	 DESC_ORIGEN VARCHAR(80),
	 FK_TIPOSINCONSISTENCIA VARCHAR(250)
)