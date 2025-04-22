-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-07-29
-- Description: Se crea la Fact DWH.FACT_COMPONENTE la cual es un insumo para las vista del tablero Seguimiento a Cargas
-- =============================================

CREATE TABLE [ATOMO].[DWH.FACT_COMPONENTE]
(
     FK_COMPONENTE BIGINT ,
	 FK_PERIODO BIGINT ,
	 VLR_REAL_PERIODO DECIMAL(25,10) ,
	 VLR_REAL_ACUM DECIMAL(25,10) ,
	 DTM_FECHACARGA DATETIME,
	 DESC_ORIGEN VARCHAR(80),
	 FK_TIPOSINCONSISTENCIA VARCHAR(250),
	[FECHA_CARGA_SYNAPSE]  [DATETIME] NULL,
	[FECHA_PROXIMA_ACTUALIZA_SYNAPSE] [DATETIME] NULL
) 