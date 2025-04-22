-- =============================================
-- Author:      Harold Lopez - Santiago Guzman
-- Create Date: 2022-08-18
-- Description: Se crea la vista CVC_HITO_TABLERO_ILP la cual es un insumo para la iniciativba de ILP 

-- Author:      Oscar Fabian Angel 
-- Update Date: 2023-03-07
-- Description: Se realiza adicion del campo CM_Resumen

-- Author:      Alejandro Vargas
-- Update Date: 2023-04-04
-- Description: Se realiza modificacion de los valores reales de proyeccion para todos los años y los valores de meta y meta normalizada

-- Author:      Alejandro Vargas
-- Update Date: 2023-04-11
-- Description: Se realiza modificacion de los campos Acumulado ILP, Acumulado ILP 1, Acumulado ILP 1 2

-- Author:      Alejandro Vargas
-- Update Date: 2023-04-12
-- Description: Se realiza modificacion en todos los campos de %Cumplimiento cruce con DWH.FACT_ENTREGABLE_HITO por FK_PERIODO y cambio de los Valores Real Proyectado

-- Author:      Alejandro Vargas
-- Update Date: 2023-04-13
-- Description: Se realiza modificacion en todos los campos de Valores Real Proyectados

-- Author:      Oscar Angel
-- Update Date: 2023-04-26
-- Description: Se realiza modificacion a MAX para el campo "Valor Real Acumulado"

-- Author:      Oscar Fabian Angel 
-- Update Date: 2023-10-06
-- Description: Se realiza ajustes para inclusion de los campos ACTIVOCUMPLIMIENTOMIN, CUMPLIMIENTOMINIMO, RECONOCIMIENTOMINIMO
-- =============================================

CREATE VIEW [ATOMO].[CVC_HITO_TABLERO_ILP] AS 
SELECT *,
/*Case % Cumplimiento Acumulado*/
CASE WHEN C."Valor Real Acumulado" IS NULL 
					THEN NULL 
				 WHEN (ISNULL(C."Valor Plan Acumulado Normalizada",C."Valor Plan Acumulado")<0 ) 
					THEN ((ISNULL(C."Valor Plan Acumulado Normalizada",C."Valor Plan Acumulado")- C."Valor Real Acumulado") / ISNULL(C."Valor Plan Acumulado Normalizada",C."Valor Plan Acumulado")) + 1 
				 WHEN ((C."Valor Plan Acumulado" = 0 AND C."Valor Plan Acumulado Normalizada" = 0) OR (C."Valor Plan Acumulado" IS NULL AND C."Valor Plan Acumulado Normalizada" = 0) OR (C."Valor Plan Acumulado" = 0 AND C."Valor Plan Acumulado Normalizada" IS NULL)) AND C."Valor Real Acumulado" = 0 
					THEN 1 
				 WHEN (C."Valor Plan Acumulado" = 0 AND C."Valor Real Acumulado" = 0 AND (C."Valor Plan Acumulado Normalizada" IS NULL OR C."Valor Plan Acumulado Normalizada" = 0 )) OR (C."Valor Plan Acumulado Normalizada" = 0 AND C."Valor Real Acumulado" = 0)
					THEN 1
                 WHEN (((C."Valor Plan Acumulado" = 0 AND C."Valor Plan Acumulado Normalizada" = 0) OR (C."Valor Plan Acumulado" IS NULL AND C."Valor Plan Acumulado Normalizada" = 0) OR (C."Valor Plan Acumulado" = 0 AND C."Valor Plan Acumulado Normalizada" IS NULL) OR (ISNULL(C."Valor Plan Acumulado Normalizada",C."Valor Plan Acumulado")=0)) AND C."Valor Real Acumulado" < 0) 
					THEN 0 
				 WHEN (((C."Valor Plan Acumulado" = 0 AND C."Valor Plan Acumulado Normalizada" = 0) OR (C."Valor Plan Acumulado" IS NULL AND 
						C."Valor Plan Acumulado Normalizada" = 0) OR (C."Valor Plan Acumulado" = 0 AND C."Valor Plan Acumulado Normalizada" IS NULL) OR (ISNULL(C."Valor Plan Acumulado Normalizada",C."Valor Plan Acumulado")=0)) 
						AND C."Valor Real Acumulado" > 0) 
					THEN 1 
				 WHEN C."Valor Plan Acumulado" < 0 AND C."Valor Plan Acumulado Normalizada" is null
					THEN CASE WHEN C."Valor Plan Acumulado" = 0 
								 THEN 0 
							  ELSE ((C."Valor Plan Acumulado" - C."Valor Real Acumulado") / C."Valor Plan Acumulado") + 1 END 
				 WHEN C."Valor Plan Acumulado Normalizada" < 0 AND C."Valor Plan Acumulado Normalizada" is not null 
					THEN CASE WHEN C."Valor Plan Acumulado Normalizada" = 0 
								THEN 0 
							  ELSE CASE WHEN C."Valor Plan Acumulado Normalizada" IS NULL AND C."Valor Plan Acumulado" <> 0 
										   THEN ((C."Valor Plan Acumulado"-C."Valor Real Acumulado") / C."Valor Plan Acumulado") + 1 
										ELSE ((C."Valor Plan Acumulado Normalizada"-C."Valor Real Acumulado") / C."Valor Plan Acumulado Normalizada") + 1 
									END 
						 END 
                 WHEN C."Valor Plan Acumulado Normalizada" is null 
					THEN CASE WHEN C."Valor Plan Acumulado" = 0 
								 THEN 0 
						 ELSE (C."Valor Real Acumulado" / C."Valor Plan Acumulado") END
				 WHEN C."Valor Plan Acumulado Normalizada" is not null 
					THEN CASE WHEN C."Valor Plan Acumulado Normalizada" = 0 
								 THEN 0 
							  ELSE CASE WHEN C."Valor Plan Acumulado Normalizada" IS NULL AND C."Valor Plan Acumulado" <> 0 
										   THEN (C."Valor Real Acumulado" / C."Valor Plan Acumulado") 
										ELSE CASE WHEN C."Valor Plan Acumulado Normalizada" = 0 
													THEN 0 
											      ELSE (C."Valor Real Acumulado" / C."Valor Plan Acumulado Normalizada") 
											 END 
								   END
                         END 
				 ELSE NULL END AS "% Cumplimiento Acumulado",
/*Case % Cumplimiento Año 1*/
CASE WHEN C."Valor Real Proyectado Año 1" IS NULL 
					THEN NULL 
				 WHEN (ISNULL(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1")<0 ) 
					THEN ((ISNULL(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1")- C."Valor Real Proyectado Año 1") / ISNULL(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1")) + 1 
				 WHEN ((C."Valor Meta Año 1" = 0 AND C."Valor Meta Normalizada Año 1" = 0) OR (C."Valor Meta Año 1" IS NULL AND C."Valor Meta Normalizada Año 1" = 0) OR (C."Valor Meta Año 1" = 0 AND C."Valor Meta Normalizada Año 1" IS NULL)) AND C."Valor Real Proyectado Año 1" = 0 
					THEN 1 
				 WHEN (C."Valor Meta Año 1" = 0 AND C."Valor Real Proyectado Año 1" = 0 AND (C."Valor Meta Normalizada Año 1" IS NULL OR C."Valor Meta Normalizada Año 1" = 0 )) OR (C."Valor Meta Normalizada Año 1" = 0 AND C."Valor Real Proyectado Año 1" = 0)
					THEN 1
                 WHEN (((C."Valor Meta Año 1" = 0 AND C."Valor Meta Normalizada Año 1" = 0) OR (C."Valor Meta Año 1" IS NULL AND C."Valor Meta Normalizada Año 1" = 0) OR (C."Valor Meta Año 1" = 0 AND C."Valor Meta Normalizada Año 1" IS NULL) OR (ISNULL(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1")=0)) AND C."Valor Real Proyectado Año 1" < 0) 
					THEN 0 
				 WHEN (((C."Valor Meta Año 1" = 0 AND C."Valor Meta Normalizada Año 1" = 0) OR (C."Valor Meta Año 1" IS NULL AND 
						C."Valor Meta Normalizada Año 1" = 0) OR (C."Valor Meta Año 1" = 0 AND C."Valor Meta Normalizada Año 1" IS NULL) OR (ISNULL(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1")=0)) 
						AND C."Valor Real Proyectado Año 1" > 0) 
					THEN 1 
				 WHEN C."Valor Meta Año 1" < 0 AND C."Valor Meta Normalizada Año 1" is null
					THEN CASE WHEN C."Valor Meta Año 1" = 0 
								 THEN 0 
							  ELSE ((C."Valor Meta Año 1" - C."Valor Real Proyectado Año 1") / C."Valor Meta Año 1") + 1 END 
				 WHEN C."Valor Meta Normalizada Año 1" < 0 AND C."Valor Meta Normalizada Año 1" is not null 
					THEN CASE WHEN C."Valor Meta Normalizada Año 1" = 0 
								THEN 0 
							  ELSE CASE WHEN C."Valor Meta Normalizada Año 1" IS NULL AND C."Valor Meta Año 1" <> 0 
										   THEN ((C."Valor Meta Año 1"-C."Valor Real Proyectado Año 1") / C."Valor Meta Año 1") + 1 
										ELSE ((C."Valor Meta Normalizada Año 1"-C."Valor Real Proyectado Año 1") / C."Valor Meta Normalizada Año 1") + 1 
									END 
						 END 
                 WHEN C."Valor Meta Normalizada Año 1" is null 
					THEN CASE WHEN C."Valor Meta Año 1" = 0 
								 THEN 0 
						 ELSE (C."Valor Real Proyectado Año 1" / C."Valor Meta Año 1") END
				 WHEN C."Valor Meta Normalizada Año 1" is not null 
					THEN CASE WHEN C."Valor Meta Normalizada Año 1" = 0 
								 THEN 0 
							  ELSE CASE WHEN C."Valor Meta Normalizada Año 1" IS NULL AND C."Valor Meta Año 1" <> 0 
										   THEN (C."Valor Real Proyectado Año 1" / C."Valor Meta Año 1") 
										ELSE CASE WHEN C."Valor Meta Normalizada Año 1" = 0 
													THEN 0 
											      ELSE (C."Valor Real Proyectado Año 1" / C."Valor Meta Normalizada Año 1") 
											 END 
								   END
                         END 
				 ELSE NULL END AS "% Cumplimiento Año 1",
/*Case % Cumplimiento Año 2*/
CASE WHEN C."Valor Real Proyectado Año 2" IS NULL 
					THEN NULL 
				 WHEN (ISNULL(C."Valor Meta Normalizada Año 2",C."Valor Meta Año 2")<0 ) 
					THEN ((ISNULL(C."Valor Meta Normalizada Año 2",C."Valor Meta Año 2")- C."Valor Real Proyectado Año 2") / ISNULL(C."Valor Meta Normalizada Año 2",C."Valor Meta Año 2")) + 1 
				 WHEN ((C."Valor Meta Año 2" = 0 AND C."Valor Meta Normalizada Año 2" = 0) OR (C."Valor Meta Año 2" IS NULL AND C."Valor Meta Normalizada Año 2" = 0) OR (C."Valor Meta Año 2" = 0 AND C."Valor Meta Normalizada Año 2" IS NULL)) AND C."Valor Real Proyectado Año 2" = 0 
					THEN 1 
				 WHEN (C."Valor Meta Año 2" = 0 AND C."Valor Real Proyectado Año 2" = 0 AND (C."Valor Meta Normalizada Año 2" IS NULL OR C."Valor Meta Normalizada Año 2" = 0 )) OR (C."Valor Meta Normalizada Año 2" = 0 AND C."Valor Real Proyectado Año 2" = 0)
					THEN 1
                 WHEN (((C."Valor Meta Año 2" = 0 AND C."Valor Meta Normalizada Año 2" = 0) OR (C."Valor Meta Año 2" IS NULL AND C."Valor Meta Normalizada Año 2" = 0) OR (C."Valor Meta Año 2" = 0 AND C."Valor Meta Normalizada Año 2" IS NULL) OR (ISNULL(C."Valor Meta Normalizada Año 2",C."Valor Meta Año 2")=0)) AND C."Valor Real Proyectado Año 2" < 0) 
					THEN 0 
				 WHEN (((C."Valor Meta Año 2" = 0 AND C."Valor Meta Normalizada Año 2" = 0) OR (C."Valor Meta Año 2" IS NULL AND 
						C."Valor Meta Normalizada Año 2" = 0) OR (C."Valor Meta Año 2" = 0 AND C."Valor Meta Normalizada Año 2" IS NULL) OR (ISNULL(C."Valor Meta Normalizada Año 2",C."Valor Meta Año 2")=0)) 
						AND C."Valor Real Proyectado Año 2" > 0) 
					THEN 1 
				 WHEN C."Valor Meta Año 2" < 0 AND C."Valor Meta Normalizada Año 2" is null
					THEN CASE WHEN C."Valor Meta Año 2" = 0 
								 THEN 0 
							  ELSE ((C."Valor Meta Año 2" - C."Valor Real Proyectado Año 2") / C."Valor Meta Año 2") + 1 END 
				 WHEN C."Valor Meta Normalizada Año 2" < 0 AND C."Valor Meta Normalizada Año 2" is not null 
					THEN CASE WHEN C."Valor Meta Normalizada Año 2" = 0 
								THEN 0 
							  ELSE CASE WHEN C."Valor Meta Normalizada Año 2" IS NULL AND C."Valor Meta Año 2" <> 0 
										   THEN ((C."Valor Meta Año 2"-C."Valor Real Proyectado Año 2") / C."Valor Meta Año 2") + 1 
										ELSE ((C."Valor Meta Normalizada Año 2"-C."Valor Real Proyectado Año 2") / C."Valor Meta Normalizada Año 2") + 1 
									END 
						 END 
                 WHEN C."Valor Meta Normalizada Año 2" is null 
					THEN CASE WHEN C."Valor Meta Año 2" = 0 
								 THEN 0 
						 ELSE (C."Valor Real Proyectado Año 2" / C."Valor Meta Año 2") END
				 WHEN C."Valor Meta Normalizada Año 2" is not null 
					THEN CASE WHEN C."Valor Meta Normalizada Año 2" = 0 
								 THEN 0 
							  ELSE CASE WHEN C."Valor Meta Normalizada Año 2" IS NULL AND C."Valor Meta Año 2" <> 0 
										   THEN (C."Valor Real Proyectado Año 2" / C."Valor Meta Año 2") 
										ELSE CASE WHEN C."Valor Meta Normalizada Año 2" = 0 
													THEN 0 
											      ELSE (C."Valor Real Proyectado Año 2" / C."Valor Meta Normalizada Año 2") 
											 END 
								   END
                         END 
				 ELSE NULL END AS "% Cumplimiento Año 2",
/*Case % Cumplimiento Año 3*/
CASE WHEN C."Valor Real Proyectado Año 3" IS NULL 
					THEN NULL 
				 WHEN (ISNULL(C."Valor Meta Normalizada Año 3",C."Valor Meta Año 3")<0 ) 
					THEN ((ISNULL(C."Valor Meta Normalizada Año 3",C."Valor Meta Año 3")- C."Valor Real Proyectado Año 3") / ISNULL(C."Valor Meta Normalizada Año 3",C."Valor Meta Año 3")) + 1 
				 WHEN ((C."Valor Meta Año 3" = 0 AND C."Valor Meta Normalizada Año 3" = 0) OR (C."Valor Meta Año 3" IS NULL AND C."Valor Meta Normalizada Año 3" = 0) OR (C."Valor Meta Año 3" = 0 AND C."Valor Meta Normalizada Año 3" IS NULL)) AND C."Valor Real Proyectado Año 3" = 0 
					THEN 1 
				 WHEN (C."Valor Meta Año 3" = 0 AND C."Valor Real Proyectado Año 3" = 0 AND (C."Valor Meta Normalizada Año 3" IS NULL OR C."Valor Meta Normalizada Año 3" = 0 )) OR (C."Valor Meta Normalizada Año 3" = 0 AND C."Valor Real Proyectado Año 3" = 0)
					THEN 1
                 WHEN (((C."Valor Meta Año 3" = 0 AND C."Valor Meta Normalizada Año 3" = 0) OR (C."Valor Meta Año 3" IS NULL AND C."Valor Meta Normalizada Año 3" = 0) OR (C."Valor Meta Año 3" = 0 AND C."Valor Meta Normalizada Año 3" IS NULL) OR (ISNULL(C."Valor Meta Normalizada Año 3",C."Valor Meta Año 3")=0)) AND C."Valor Real Proyectado Año 3" < 0) 
					THEN 0 
				 WHEN (((C."Valor Meta Año 3" = 0 AND C."Valor Meta Normalizada Año 3" = 0) OR (C."Valor Meta Año 3" IS NULL AND 
						C."Valor Meta Normalizada Año 3" = 0) OR (C."Valor Meta Año 3" = 0 AND C."Valor Meta Normalizada Año 3" IS NULL) OR (ISNULL(C."Valor Meta Normalizada Año 3",C."Valor Meta Año 3")=0)) 
						AND C."Valor Real Proyectado Año 3" > 0) 
					THEN 1 
				 WHEN C."Valor Meta Año 3" < 0 AND C."Valor Meta Normalizada Año 3" is null
					THEN CASE WHEN C."Valor Meta Año 3" = 0 
								 THEN 0 
							  ELSE ((C."Valor Meta Año 3" - C."Valor Real Proyectado Año 3") / C."Valor Meta Año 3") + 1 END 
				 WHEN C."Valor Meta Normalizada Año 3" < 0 AND C."Valor Meta Normalizada Año 3" is not null 
					THEN CASE WHEN C."Valor Meta Normalizada Año 3" = 0 
								THEN 0 
							  ELSE CASE WHEN C."Valor Meta Normalizada Año 3" IS NULL AND C."Valor Meta Año 3" <> 0 
										   THEN ((C."Valor Meta Año 3"-C."Valor Real Proyectado Año 3") / C."Valor Meta Año 3") + 1 
										ELSE ((C."Valor Meta Normalizada Año 3"-C."Valor Real Proyectado Año 3") / C."Valor Meta Normalizada Año 3") + 1 
									END 
						 END 
                 WHEN C."Valor Meta Normalizada Año 3" is null 
					THEN CASE WHEN C."Valor Meta Año 3" = 0 
								 THEN 0 
						 ELSE (C."Valor Real Proyectado Año 3" / C."Valor Meta Año 3") END
				 WHEN C."Valor Meta Normalizada Año 3" is not null 
					THEN CASE WHEN C."Valor Meta Normalizada Año 3" = 0 
								 THEN 0 
							  ELSE CASE WHEN C."Valor Meta Normalizada Año 3" IS NULL AND C."Valor Meta Año 3" <> 0 
										   THEN (C."Valor Real Proyectado Año 3" / C."Valor Meta Año 3") 
										ELSE CASE WHEN C."Valor Meta Normalizada Año 3" = 0 
													THEN 0 
											      ELSE (C."Valor Real Proyectado Año 3" / C."Valor Meta Normalizada Año 3") 
											 END 
								   END
                         END 
				 ELSE NULL END AS "% Cumplimiento Año 3",
/*Case % Cumplimiento Año 1 2*/
CASE WHEN C."Valor Real Proyectado Años 1 2" IS NULL 
					THEN NULL 
				 WHEN (ISNULL(C."Valor Meta Normalizada Años 1 2",C."Valor Meta Años 1 2")<0 ) 
					THEN ((ISNULL(C."Valor Meta Normalizada Años 1 2",C."Valor Meta Años 1 2")- C."Valor Real Proyectado Años 1 2") / ISNULL(C."Valor Meta Normalizada Años 1 2",C."Valor Meta Años 1 2")) + 1 
				 WHEN ((C."Valor Meta Años 1 2" = 0 AND C."Valor Meta Normalizada Años 1 2" = 0) OR (C."Valor Meta Años 1 2" IS NULL AND C."Valor Meta Normalizada Años 1 2" = 0) OR (C."Valor Meta Años 1 2" = 0 AND C."Valor Meta Normalizada Años 1 2" IS NULL)) AND C."Valor Real Proyectado Años 1 2" = 0 
					THEN 1 
				 WHEN (C."Valor Meta Años 1 2" = 0 AND C."Valor Real Proyectado Años 1 2" = 0 AND (C."Valor Meta Normalizada Años 1 2" IS NULL OR C."Valor Meta Normalizada Años 1 2" = 0 )) OR (C."Valor Meta Normalizada Años 1 2" = 0 AND C."Valor Real Proyectado Años 1 2" = 0)
					THEN 1
                 WHEN (((C."Valor Meta Años 1 2" = 0 AND C."Valor Meta Normalizada Años 1 2" = 0) OR (C."Valor Meta Años 1 2" IS NULL AND C."Valor Meta Normalizada Años 1 2" = 0) OR (C."Valor Meta Años 1 2" = 0 AND C."Valor Meta Normalizada Años 1 2" IS NULL) OR (ISNULL(C."Valor Meta Normalizada Años 1 2",C."Valor Meta Años 1 2")=0)) AND C."Valor Real Proyectado Años 1 2" < 0) 
					THEN 0 
				 WHEN (((C."Valor Meta Años 1 2" = 0 AND C."Valor Meta Normalizada Años 1 2" = 0) OR (C."Valor Meta Años 1 2" IS NULL AND 
						C."Valor Meta Normalizada Años 1 2" = 0) OR (C."Valor Meta Años 1 2" = 0 AND C."Valor Meta Normalizada Años 1 2" IS NULL) OR (ISNULL(C."Valor Meta Normalizada Años 1 2",C."Valor Meta Años 1 2")=0)) 
						AND C."Valor Real Proyectado Años 1 2" > 0) 
					THEN 1 
				 WHEN C."Valor Meta Años 1 2" < 0 AND C."Valor Meta Normalizada Años 1 2" is null
					THEN CASE WHEN C."Valor Meta Años 1 2" = 0 
								 THEN 0 
							  ELSE ((C."Valor Meta Años 1 2" - C."Valor Real Proyectado Años 1 2") / C."Valor Meta Años 1 2") + 1 END 
				 WHEN C."Valor Meta Normalizada Años 1 2" < 0 AND C."Valor Meta Normalizada Años 1 2" is not null 
					THEN CASE WHEN C."Valor Meta Normalizada Años 1 2" = 0 
								THEN 0 
							  ELSE CASE WHEN C."Valor Meta Normalizada Años 1 2" IS NULL AND C."Valor Meta Años 1 2" <> 0 
										   THEN ((C."Valor Meta Años 1 2"-C."Valor Real Proyectado Años 1 2") / C."Valor Meta Años 1 2") + 1 
										ELSE ((C."Valor Meta Normalizada Años 1 2"-C."Valor Real Proyectado Años 1 2") / C."Valor Meta Normalizada Años 1 2") + 1 
									END 
						 END 
                 WHEN C."Valor Meta Normalizada Años 1 2" is null 
					THEN CASE WHEN C."Valor Meta Años 1 2" = 0 
								 THEN 0 
						 ELSE (C."Valor Real Proyectado Años 1 2" / C."Valor Meta Años 1 2") END
				 WHEN C."Valor Meta Normalizada Años 1 2" is not null 
					THEN CASE WHEN C."Valor Meta Normalizada Años 1 2" = 0 
								 THEN 0 
							  ELSE CASE WHEN C."Valor Meta Normalizada Años 1 2" IS NULL AND C."Valor Meta Años 1 2" <> 0 
										   THEN (C."Valor Real Proyectado Años 1 2" / C."Valor Meta Años 1 2") 
										ELSE CASE WHEN C."Valor Meta Normalizada Años 1 2" = 0 
													THEN 0 
											      ELSE (C."Valor Real Proyectado Años 1 2" / C."Valor Meta Normalizada Años 1 2") 
											 END 
								   END
                         END 
				 ELSE NULL END AS "% Cumplimiento Años 1 2",
/*Case % Cumplimiento Año 1 2 3*/
CASE WHEN C."Valor Real Proyectado Años 1 2 3" IS NULL 
					THEN NULL 
				 WHEN (ISNULL(C."Valor Meta Normalizada Años 1 2 3",C."Valor Meta Años 1 2 3")<0 ) 
					THEN ((ISNULL(C."Valor Meta Normalizada Años 1 2 3",C."Valor Meta Años 1 2 3")- C."Valor Real Proyectado Años 1 2 3") / ISNULL(C."Valor Meta Normalizada Años 1 2 3",C."Valor Meta Años 1 2 3")) + 1 
				 WHEN ((C."Valor Meta Años 1 2 3" = 0 AND C."Valor Meta Normalizada Años 1 2 3" = 0) OR (C."Valor Meta Años 1 2 3" IS NULL AND C."Valor Meta Normalizada Años 1 2 3" = 0) OR (C."Valor Meta Años 1 2 3" = 0 AND C."Valor Meta Normalizada Años 1 2 3" IS NULL)) AND C."Valor Real Proyectado Años 1 2 3" = 0 
					THEN 1 
				 WHEN (C."Valor Meta Años 1 2 3" = 0 AND C."Valor Real Proyectado Años 1 2 3" = 0 AND (C."Valor Meta Normalizada Años 1 2 3" IS NULL OR C."Valor Meta Normalizada Años 1 2 3" = 0 )) OR (C."Valor Meta Normalizada Años 1 2 3" = 0 AND C."Valor Real Proyectado Años 1 2 3" = 0)
					THEN 1
                 WHEN (((C."Valor Meta Años 1 2 3" = 0 AND C."Valor Meta Normalizada Años 1 2 3" = 0) OR (C."Valor Meta Años 1 2 3" IS NULL AND C."Valor Meta Normalizada Años 1 2 3" = 0) OR (C."Valor Meta Años 1 2 3" = 0 AND C."Valor Meta Normalizada Años 1 2 3" IS NULL) OR (ISNULL(C."Valor Meta Normalizada Años 1 2 3",C."Valor Meta Años 1 2 3")=0)) AND C."Valor Real Proyectado Años 1 2 3" < 0) 
					THEN 0 
				 WHEN (((C."Valor Meta Años 1 2 3" = 0 AND C."Valor Meta Normalizada Años 1 2 3" = 0) OR (C."Valor Meta Años 1 2 3" IS NULL AND 
						C."Valor Meta Normalizada Años 1 2 3" = 0) OR (C."Valor Meta Años 1 2 3" = 0 AND C."Valor Meta Normalizada Años 1 2 3" IS NULL) OR (ISNULL(C."Valor Meta Normalizada Años 1 2 3",C."Valor Meta Años 1 2 3")=0)) 
						AND C."Valor Real Proyectado Años 1 2 3" > 0) 
					THEN 1 
				 WHEN C."Valor Meta Años 1 2 3" < 0 AND C."Valor Meta Normalizada Años 1 2 3" is null
					THEN CASE WHEN C."Valor Meta Años 1 2 3" = 0 
								 THEN 0 
							  ELSE ((C."Valor Meta Años 1 2 3" - C."Valor Real Proyectado Años 1 2 3") / C."Valor Meta Años 1 2 3") + 1 END 
				 WHEN C."Valor Meta Normalizada Años 1 2 3" < 0 AND C."Valor Meta Normalizada Años 1 2 3" is not null 
					THEN CASE WHEN C."Valor Meta Normalizada Años 1 2 3" = 0 
								THEN 0 
							  ELSE CASE WHEN C."Valor Meta Normalizada Años 1 2 3" IS NULL AND C."Valor Meta Años 1 2 3" <> 0 
										   THEN ((C."Valor Meta Años 1 2 3"-C."Valor Real Proyectado Años 1 2 3") / C."Valor Meta Años 1 2 3") + 1 
										ELSE ((C."Valor Meta Normalizada Años 1 2 3"-C."Valor Real Proyectado Años 1 2 3") / C."Valor Meta Normalizada Años 1 2 3") + 1 
									END 
						 END 
                 WHEN C."Valor Meta Normalizada Años 1 2 3" is null 
					THEN CASE WHEN C."Valor Meta Años 1 2 3" = 0 
								 THEN 0 
						 ELSE (C."Valor Real Proyectado Años 1 2 3" / C."Valor Meta Años 1 2 3") END
				 WHEN C."Valor Meta Normalizada Años 1 2 3" is not null 
					THEN CASE WHEN C."Valor Meta Normalizada Años 1 2 3" = 0 
								 THEN 0 
							  ELSE CASE WHEN C."Valor Meta Normalizada Años 1 2 3" IS NULL AND C."Valor Meta Años 1 2 3" <> 0 
										   THEN (C."Valor Real Proyectado Años 1 2 3" / C."Valor Meta Años 1 2 3") 
										ELSE CASE WHEN C."Valor Meta Normalizada Años 1 2 3" = 0 
													THEN 0 
											      ELSE (C."Valor Real Proyectado Años 1 2 3" / C."Valor Meta Normalizada Años 1 2 3") 
											 END 
								   END
                         END 
				 ELSE NULL END AS "% Cumplimiento Años 1 2 3",

CASE WHEN C."Valor Real Acumulado" IS NULL
					THEN NULL 
					WHEN (COALESCE(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1") = 0 OR COALESCE(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1") IS NULL) AND C."Valor Real Acumulado" <> 0
					THEN CASE WHEN UPPER(C.DESC_SENTIDO) = 'POSITIVO' AND C."Valor Real Acumulado" > 0
								THEN 1
								WHEN UPPER(C.DESC_SENTIDO) = 'POSITIVO' AND C."Valor Real Acumulado" < 0
								THEN 0
								WHEN UPPER(C.DESC_SENTIDO) = 'NEGATIVO' AND C."Valor Real Acumulado" < 0
								THEN 1
								WHEN UPPER(C.DESC_SENTIDO) = 'NEGATIVO' AND C."Valor Real Acumulado" > 0
								THEN 0
								ELSE NULL END
					WHEN (COALESCE(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1") = 0) AND C."Valor Real Acumulado" = 0 
						THEN 1
					WHEN UPPER(C.DESC_SENTIDO) = 'NEGATIVO' THEN ((COALESCE(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1")-C."Valor Real Acumulado")/(COALESCE(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1")))+1
				ELSE (C."Valor Real Acumulado" / COALESCE(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1")) 
				END AS "% Avance Acumulado ILP",

CASE WHEN C."Valor Real Proyectado Año 1" IS NULL
					THEN NULL 
					WHEN (COALESCE(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1") = 0 OR COALESCE(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1") IS NULL) AND C."Valor Real Proyectado Año 1" <> 0
					THEN CASE WHEN UPPER(C."DESC_SENTIDO") = 'POSITIVO' AND C."Valor Real Proyectado Año 1" > 0
								THEN 1
								WHEN UPPER(C."DESC_SENTIDO") = 'POSITIVO' AND C."Valor Real Proyectado Año 1" < 0
								THEN 0
								WHEN UPPER(C."DESC_SENTIDO") = 'NEGATIVO' AND C."Valor Real Proyectado Año 1" < 0
								THEN 1
								WHEN UPPER(C."DESC_SENTIDO") = 'NEGATIVO' AND C."Valor Real Proyectado Año 1" > 0
								THEN 0
								ELSE NULL END
					WHEN (COALESCE(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1") = 0) AND C."Valor Real Proyectado Año 1" = 0 
						THEN 1
					WHEN UPPER(C.DESC_SENTIDO) = 'NEGATIVO' THEN ((COALESCE(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1")-C."Valor Real Proyectado Año 1")/(COALESCE(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1")))+1
				ELSE (C."Valor Real Proyectado Año 1" / COALESCE(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1")) 
				END AS "% Avance ILP Año 1",
CASE WHEN C."Valor Real Proyectado Año 1" IS NULL
					THEN NULL 
					WHEN (COALESCE(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1") = 0 OR COALESCE(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1") IS NULL) AND C."Valor Real Proyectado Año 1" <> 0
					THEN CASE WHEN UPPER(C."DESC_SENTIDO") = 'POSITIVO' AND C."Valor Real Proyectado Año 1" > 0
								THEN 1
								WHEN UPPER(C."DESC_SENTIDO") = 'POSITIVO' AND C."Valor Real Proyectado Año 1" < 0
								THEN 0
								WHEN UPPER(C."DESC_SENTIDO") = 'NEGATIVO' AND C."Valor Real Proyectado Año 1" < 0
								THEN 1
								WHEN UPPER(C."DESC_SENTIDO") = 'NEGATIVO' AND C."Valor Real Proyectado Año 1" > 0
								THEN 0
								ELSE NULL END
					WHEN (COALESCE(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1") = 0) AND C."Valor Real Proyectado Año 1" = 0 
						THEN 1
					WHEN UPPER(C.DESC_SENTIDO) = 'NEGATIVO' THEN ((COALESCE(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1")-C."Valor Real Proyectado Año 1")/(COALESCE(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1")))+1
				ELSE (C."Valor Real Proyectado Año 1" / COALESCE(C."Valor Meta Normalizada Año 1",C."Valor Meta Año 1")) 
				END AS "% Avance ILP Años 1 2"
FROM (
SELECT   A.FK_PERIODO 
        ,A.FK_TABLERO                        
        ,A.DESC_TABLERO_CVR                  
        ,A.DESC_TABLERO   
		,A.VIGENCIA_TABLERO_DESDE
        ,A.VIGENCIA_TABLERO_HASTA                   
        ,A.DESC_VERSION                      
        ,A.DESC_GRUPO                        
        ,A.DESC_EMPRESA                      
        ,A.DESC_VP_EJECUTIVA                 
        ,A.DESC_GRUPO_SEGMENTO               
        ,A.DESC_SEGMENTO                     
        ,A.DESC_UNIDAD_NEGOCIO_NVL_2         
        ,A.DESC_UNIDAD_NEGOCIO_NVL_3         
        ,A.DESC_GERENCIA                     
        ,A.DESC_RUTINA                       
        ,A.DESC_SIGLA_AREA                   
        ,A.DESC_NIVEL                        
		,A.DESC_EJE_PALANCA                  
        ,A.DESC_OBJETIVO                     
        ,A.FK_INDICADOR                      
        ,A.ID_INDICADOR                      
        ,A.DESC_NOMBRE_INDICADOR             
        ,A.FK_PARAM_INDICADOR                
        ,A.DESC_DETALLE_INDICADOR            
        ,A.DESC_HITO_INDICADOR               
        ,A.DESC_FRECUENCIA                   
        ,A.VLR_PESO_INDICADOR                
        ,A.DESC_TIPO_TABLERO                 
        ,A.DESC_CORTO_LARGO_PLAZO            
        ,A.DESC_SECUENCIA_ORDEN              
        ,A.DESC_REFERENTE                    
        ,A.DESC_RESPONSABLE_MEDICION         
        ,A.DESC_CARGO_RESPONSABLE_MEDICION   
        ,A.DESC_CORREO_RESPONSABLE_MEDICION  
        ,A.DESC_RESPONSABLE_MEDICION_2       
        ,A.DESC_CARGO_RESPONSABLE_MEDICION_2 
        ,A.DESC_CORREO_RESPONSABLE_MEDICION_2
        ,A.DTM_FECHACARGA                    
        ,A.DESC_ANNIO  
		,A.DESC_ANNIO_HITO 
        ,A.DESC_PERIODO                      
        ,A.MES                               
        ,A.DESC_MENSAJE_CLAVE_INDICADOR      
        ,A.DESC_PREMISAS                     
        ,A.DESC_SENTIDO                      
        ,A.CANT_DECIMALES_CALCULO            
        ,A.CANT_DECIMALES_REPORTE            
        ,MAX(A.VLR_REAL_ACUMULADO) AS "Valor Real Acumulado"
        ,MAX(A.VLR_PLAN_ACUMULADO) AS "Valor Plan Acumulado"
        ,MAX(A.VLR_PLAN_ACUM_NORM) AS "Valor Plan Acumulado Normalizada"
        ,MAX(A.VLR_REAL_ANNIO_1) AS "Valor Real Año 1"
        ,MAX(A.VLR_REAL_ANNIO_2) AS "Valor Real Año 2"
        ,MAX(A.VLR_REAL_ANNIO_3) AS "Valor Real Año 3"
        ,MAX(A.VLR_REAL_ANNIO_12) AS "Valor Real Años 1 2"
        ,MAX(A.VLR_REAL_ANNIO_123) AS "Valor Real Años 1 2 3"
        ,MAX(A.VLR_META_ANNIO_1) AS "Valor Meta Año 1"
        ,MAX(A.VLR_META_ANNIO_1) AS "Valor Meta Año 2"
        ,MAX(A.VLR_META_ANNIO_1) AS "Valor Meta Año 3"
        ,MAX(A.VLR_META_ANNIO_1) AS "Valor Meta Años 1 2"
        ,MAX(A.VLR_META_ANNIO_1) AS "Valor Meta Años 1 2 3"
		,MAX(A.VLR_RETO) AS "Valor Reto"
        ,MAX(A.VLR_META_NORM_ANNIO_1) AS "Valor Meta Normalizada Año 1"
        ,MAX(A.VLR_META_NORM_ANNIO_1) AS "Valor Meta Normalizada Año 2"
		,MAX(A.VLR_META_NORM_ANNIO_1) AS "Valor Meta Normalizada Año 3"
		,MAX(A.VLR_META_NORM_ANNIO_1) AS "Valor Meta Normalizada Años 1 2"
		,MAX(A.VLR_META_NORM_ANNIO_1) AS "Valor Meta Normalizada Años 1 2 3"
        ,MAX(A.VLR_PROYECCION_ANNIO_2) AS "Valor Proyección Año 2"
		,MAX(A.VLR_PROYECCION_ANNIO_3) AS "Valor Proyección Año 3"
		,MAX(A.VLR_PROYECCION_ANNIO_12) AS "Valor Proyección Años 1 2"
		,MAX(A.VLR_PROYECCION_ANNIO_123) AS "Valor Proyección Años 1 2 3"
		
		,CASE WHEN A.DESC_ANNIO > A.DESC_ANNIO_HITO 
		      THEN (CASE WHEN A.CANT_DECIMALES_REPORTE IS NULL THEN B.VLR_REAL_ENTREGABLE ELSE ROUND(B.VLR_REAL_ENTREGABLE,A.CANT_DECIMALES_REPORTE)END )
 			  WHEN A.DESC_ANNIO = A.DESC_ANNIO_HITO AND A.MES='12'
			  THEN (CASE WHEN A.CANT_DECIMALES_REPORTE IS NULL THEN B.VLR_REAL_ENTREGABLE ELSE ROUND(B.VLR_REAL_ENTREGABLE,A.CANT_DECIMALES_REPORTE)END )
			  ELSE (CASE WHEN A.CANT_DECIMALES_REPORTE IS NULL THEN A.VLR_PROYECCION_ANNIO_ESC_MEDIO ELSE ROUND(A.VLR_PROYECCION_ANNIO_ESC_MEDIO,A.CANT_DECIMALES_REPORTE) END) END AS "Valor Real Proyectado Año 1"   

		,CASE WHEN A.DESC_ANNIO > A.DESC_ANNIO_HITO 
		      THEN (CASE WHEN A.CANT_DECIMALES_REPORTE IS NULL THEN B.VLR_REAL_ENTREGABLE ELSE ROUND(B.VLR_REAL_ENTREGABLE,A.CANT_DECIMALES_REPORTE)END )
 			  WHEN A.DESC_ANNIO = A.DESC_ANNIO_HITO AND A.MES='12'
			  THEN (CASE WHEN A.CANT_DECIMALES_REPORTE IS NULL THEN B.VLR_REAL_ENTREGABLE ELSE ROUND(B.VLR_REAL_ENTREGABLE,A.CANT_DECIMALES_REPORTE)END )
			  ELSE (CASE WHEN A.CANT_DECIMALES_REPORTE IS NULL THEN A.VLR_PROYECCION_ANNIO_ESC_MEDIO ELSE ROUND(A.VLR_PROYECCION_ANNIO_ESC_MEDIO,A.CANT_DECIMALES_REPORTE) END) END AS "Valor Real Proyectado Año 2"

		 ,CASE WHEN A.DESC_ANNIO > A.DESC_ANNIO_HITO 
		      THEN (CASE WHEN A.CANT_DECIMALES_REPORTE IS NULL THEN B.VLR_REAL_ENTREGABLE ELSE ROUND(B.VLR_REAL_ENTREGABLE,A.CANT_DECIMALES_REPORTE)END )
 			  WHEN A.DESC_ANNIO = A.DESC_ANNIO_HITO AND A.MES='12'
			  THEN (CASE WHEN A.CANT_DECIMALES_REPORTE IS NULL THEN B.VLR_REAL_ENTREGABLE ELSE ROUND(B.VLR_REAL_ENTREGABLE,A.CANT_DECIMALES_REPORTE)END )
			  ELSE (CASE WHEN A.CANT_DECIMALES_REPORTE IS NULL THEN A.VLR_PROYECCION_ANNIO_ESC_MEDIO ELSE ROUND(A.VLR_PROYECCION_ANNIO_ESC_MEDIO,A.CANT_DECIMALES_REPORTE) END) END "Valor Real Proyectado Año 3" 
			
		 ,CASE WHEN A.DESC_ANNIO > A.DESC_ANNIO_HITO 
		      THEN (CASE WHEN A.CANT_DECIMALES_REPORTE IS NULL THEN B.VLR_REAL_ENTREGABLE ELSE ROUND(B.VLR_REAL_ENTREGABLE,A.CANT_DECIMALES_REPORTE)END )
 			  WHEN A.DESC_ANNIO = A.DESC_ANNIO_HITO AND A.MES='12'
			  THEN (CASE WHEN A.CANT_DECIMALES_REPORTE IS NULL THEN B.VLR_REAL_ENTREGABLE ELSE ROUND(B.VLR_REAL_ENTREGABLE,A.CANT_DECIMALES_REPORTE)END )
			  ELSE (CASE WHEN A.CANT_DECIMALES_REPORTE IS NULL THEN A.VLR_PROYECCION_ANNIO_ESC_MEDIO ELSE ROUND(A.VLR_PROYECCION_ANNIO_ESC_MEDIO,A.CANT_DECIMALES_REPORTE) END) END "Valor Real Proyectado Años 1 2"

         ,CASE WHEN A.DESC_ANNIO > A.DESC_ANNIO_HITO 
		      THEN (CASE WHEN A.CANT_DECIMALES_REPORTE IS NULL THEN B.VLR_REAL_ENTREGABLE ELSE ROUND(B.VLR_REAL_ENTREGABLE,A.CANT_DECIMALES_REPORTE)END )
 			  WHEN A.DESC_ANNIO = A.DESC_ANNIO_HITO AND A.MES='12'
			  THEN (CASE WHEN A.CANT_DECIMALES_REPORTE IS NULL THEN B.VLR_REAL_ENTREGABLE ELSE ROUND(B.VLR_REAL_ENTREGABLE,A.CANT_DECIMALES_REPORTE)END )
			  ELSE (CASE WHEN A.CANT_DECIMALES_REPORTE IS NULL THEN A.VLR_PROYECCION_ANNIO_ESC_MEDIO ELSE ROUND(A.VLR_PROYECCION_ANNIO_ESC_MEDIO,A.CANT_DECIMALES_REPORTE) END) END AS "Valor Real Proyectado Años 1 2 3"
			  
        ,A.VLR_PROYECCION_ANNIO_ESC_MEDIO AS "Valor Proyección Año 1"
        /*,sum(A.PRC_CUMP_ACUM) AS "% Cumplimiento Acumulado"
        ,sum(A.PRC_CUMP_ANNIO_ESC_MEDIO) AS "% Cumplimiento Año 1"
		,sum(A.PRC_CUMP_ANNO2) AS "% Cumplimiento Año 2"
		,sum(A.PRC_CUMP_ANNO3) AS "% Cumplimiento Año 3"
		,sum(A.PRC_CUMP_ANNO12) AS "% Cumplimiento Años 1 2"
		,sum(A.PRC_CUMP_ANNO123) AS "% Cumplimiento Años 1 2 3"
		,sum(A.PRC_CUMP_ACUM) AS "% Avance Acumulado ILP"
		,sum(A.PRC_CUMP_ANNIO_ESC_MEDIO) AS "% Avance ILP Año 1"
		,sum(A.PRC_AVAN_ILP_ANNO12) AS "% Avance ILP Años 1 2"*/
        ,A.FECHA_CARGA_SYNAPSE
        ,A.FECHA_PROXIMA_ACTUALIZA_SYNAPSE
		,A.DESC_HITO_INDIC_HABILITADOR
		,A.ACTIVOCUMPLIMIENTOMIN
	    ,A.CUMPLIMIENTOMINIMO
	    ,A.RECONOCIMIENTOMINIMO
		,A.CM_RESUMEN
		
FROM [ATOMO].[CVC_HITO_INDICADOR_ILP] A
LEFT JOIN ( SELECT A.FK_INDICADOR,
                   A.FK_PARAM_INDICADOR,
				   A.FK_TABLERO,

				   A.FK_HITO,
				   SUM(A.VLR_REAL_ENTREGABLE) AS VLR_REAL_ENTREGABLE,
				   SUM(A.VLR_PROY_ESC_MEDIO_ENTREGABLE) AS VLR_PROY_ESC_MEDIO_ENTREGABLE

              FROM ( 
					SELECT 
						C.FK_INDICADOR,
						C.FK_PARAM_INDICADOR,
						C.FK_TABLERO,
						C.FK_HITO,
						COALESCE(C.VLR_REAL_FINAL_ENTREGABLE,C.VLR_CUMP_ENTREGABLE) * (C.".Peso Entregable"/100) AS VLR_REAL_ENTREGABLE,
						C.VLR_CUMP_ESC_MEDIO_ENTREGABLE * (C.".Peso Entregable"/100) AS VLR_PROY_ESC_MEDIO_ENTREGABLE
					FROM ( SELECT DISTINCT A.FK_INDICADOR,
								 	 A.FK_PARAM_INDICADOR,
								 	 A.FK_TABLERO,
			
									 B.FK_HITO,
									 (B.PRC_CUMP_ENTREGABLE * 100) AS VLR_CUMP_ENTREGABLE,
									 B.VLR_REAL_FINAL_ENTREGABLE,
									 B.VLR_REAL_ENTREGABLE,

								 	 B.VLR_PROY_ESC_MEDIO_ENTREGABLE,
									 (B.VLR_CUMP_ESC_MEDIO_ENTREGABLE * 100) AS VLR_CUMP_ESC_MEDIO_ENTREGABLE,

									 C.".Peso Entregable"

							 FROM [ATOMO].[CVC_HITO_INDICADOR_ILP] A
								LEFT JOIN [ATOMO].[DWH.FACT_ENTREGABLE_HITO] B
										ON A.FK_INDICADOR = B.FK_HITO 
										AND A.FK_PARAM_INDICADOR = B.FK_PARAM_INDICADOR
										AND A.FK_PERIODO = B.FK_PERIODO
										LEFT JOIN [ATOMO].[CVC_ENTREGABLES_HITO] C
												ON B.FK_ENTREGABLE = C.GK_ENTREGABLE_HITO
												AND A.FK_PARAM_INDICADOR = C.FK_PARAM_INDICADOR
							) C					
				   ) A
			GROUP BY A.FK_INDICADOR,
                   A.FK_PARAM_INDICADOR,
				   A.FK_TABLERO,
				   A.FK_HITO) B

		ON A.FK_INDICADOR = B.FK_HITO
		AND A.FK_PARAM_INDICADOR = B.FK_PARAM_INDICADOR
GROUP BY
         A.FK_TABLERO                        
        ,A.DESC_TABLERO_CVR                  
        ,A.DESC_TABLERO    
		,A.VIGENCIA_TABLERO_DESDE
        ,A.VIGENCIA_TABLERO_HASTA                  
        ,A.DESC_VERSION                      
        ,A.DESC_GRUPO                        
        ,A.DESC_EMPRESA                      
        ,A.DESC_VP_EJECUTIVA                 
        ,A.DESC_GRUPO_SEGMENTO               
        ,A.DESC_SEGMENTO                     
        ,A.DESC_UNIDAD_NEGOCIO_NVL_2         
        ,A.DESC_UNIDAD_NEGOCIO_NVL_3         
        ,A.DESC_GERENCIA                     
        ,A.DESC_RUTINA                       
        ,A.DESC_SIGLA_AREA                   
        ,A.DESC_NIVEL                        
		,A.DESC_EJE_PALANCA                  
        ,A.DESC_OBJETIVO                     
        ,A.FK_INDICADOR                      
        ,A.ID_INDICADOR                      
        ,A.DESC_NOMBRE_INDICADOR             
        ,A.FK_PARAM_INDICADOR                
        ,A.DESC_DETALLE_INDICADOR            
        ,A.DESC_HITO_INDICADOR               
        ,A.DESC_FRECUENCIA                   
        ,A.VLR_PESO_INDICADOR                
        ,A.DESC_TIPO_TABLERO                 
        ,A.DESC_CORTO_LARGO_PLAZO            
        ,A.DESC_SECUENCIA_ORDEN              
        ,A.DESC_REFERENTE                    
        ,A.DESC_RESPONSABLE_MEDICION         
        ,A.DESC_CARGO_RESPONSABLE_MEDICION   
        ,A.DESC_CORREO_RESPONSABLE_MEDICION  
        ,A.DESC_RESPONSABLE_MEDICION_2       
        ,A.DESC_CARGO_RESPONSABLE_MEDICION_2 
        ,A.DESC_CORREO_RESPONSABLE_MEDICION_2
        ,A.DTM_FECHACARGA                    
        ,A.DESC_ANNIO 
		,A.DESC_ANNIO_HITO
        ,A.FK_PERIODO                        
        ,A.DESC_PERIODO                      
        ,A.MES                               
        ,A.DESC_MENSAJE_CLAVE_INDICADOR      
        ,A.DESC_PREMISAS                     
        ,A.DESC_SENTIDO                      
        ,A.CANT_DECIMALES_CALCULO            
        ,A.CANT_DECIMALES_REPORTE            
		,A.FECHA_CARGA_SYNAPSE               
        ,A.FECHA_PROXIMA_ACTUALIZA_SYNAPSE   
		,A.DESC_HITO_INDIC_HABILITADOR
		,A.ACTIVOCUMPLIMIENTOMIN
	    ,A.CUMPLIMIENTOMINIMO
	    ,A.RECONOCIMIENTOMINIMO
		,A.CM_RESUMEN
		,B.VLR_REAL_ENTREGABLE
		,B.VLR_PROY_ESC_MEDIO_ENTREGABLE
		,A.VLR_PROYECCION_ANNIO_ESC_MEDIO

) AS C;