
-- =============================================
-- Author:      Oscar Angel
-- Create Date: 2022-06-02
-- Description: Se crea el procedimiento para la carga de la DWH.DIM_FECHA la cual es un insumo para las vistas de los tableros de Atomo
-- =============================================

CREATE PROC [ATOMO].[LoadDimFecha] AS 
BEGIN
	
	--Declara variables de fecha de inicio y fin de la secuencia

	DECLARE @FechaDesde DATE = CAST('20150101' AS DATE);
	DECLARE @FechaHasta DATE = CAST('20501231' AS DATE);	
	DECLARE @Año integer = year('20150101')

	IF @Año NOT IN (SELECT DISTINCT AÑO FROM [ATOMO].[DWH.DIM_FECHA])
		BEGIN
			SET LANGUAGE spanish
			WHILE @FechaDesde <= @FechaHasta
				BEGIN
	 
					INSERT INTO [ATOMO].[DWH.DIM_FECHA](
					   GK_TIEMPO
					  ,FECHA
					  ,AÑO
					  ,MES
					  ,DIA
					  ,PERIODO
					  ,NUMERO_SEMANA
					  ,TRIMESTRE
					  ,SEMESTRE
					  ,NOMBRE_MES
					  ,NOMBRE_MES_CORTO
					  ,NOMBRE_DIA)
					SELECT CAST(Convert(CHAR(8),@FechaDesde,112) AS INTEGER) AS GK_TIEMPO,
					  @FechaDesde AS FECHA, 
					  YEAR(@FechaDesde) AS AÑO,
					  MONTH(@FechaDesde) AS MES,
					  DAY(@FechaDesde) AS DIA,
					  CONCAT(YEAR(@FechaDesde),MONTH(@FechaDesde)) AS PERIODO,
					  DATENAME(week, @FechaDesde) AS NUMERO_SEMANA,
					  DATENAME(quarter, @FechaDesde) AS TRIMESTRE,
					  CAST(ROUND(DATENAME(quarter, @FechaDesde)/2.0,0) AS tinyint) AS SEMESTRE,
					  DATENAME(month, @FechaDesde) AS NOMBRE_MES,
					  UPPER(LEFT(DATENAME(month, @FechaDesde),3)) AS NOMBRE_MES_CORTO,
					  DATENAME(WEEKDAY, @FechaDesde) AS NOMBRE_DIA
		
					SET @FechaDesde = dateadd(day,1,@FechaDesde)
				END
			SET LANGUAGE spanish	
		END
END
