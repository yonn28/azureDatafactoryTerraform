/*
 Plantilla de script anterior a la implementación							
--------------------------------------------------------------------------------------
 Este archivo contiene instrucciones de SQL que se ejecutarán antes del script de compilación	
 Use la sintaxis de SQLCMD para incluir un archivo en el script anterior a la implementación			
--------------------------------------------------------------------------------------
*/

IF  EXISTS (SELECT * from sys.tables WHERE Name = 'CVC_DESEMPENO_TABLERO')
     DROP TABLE [ATOMO].[CVC_DESEMPENO_TABLERO];
GO

IF  EXISTS (SELECT * from sys.views WHERE Name = 'CVC_DESEMPENO_TABLERO')
     DROP VIEW [ATOMO].[CVC_DESEMPENO_TABLERO];
GO 