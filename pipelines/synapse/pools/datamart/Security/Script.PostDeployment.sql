/*
Plantilla de script posterior a la implementación							
--------------------------------------------------------------------------------------
 Este archivo contiene instrucciones de SQL que se anexarán al script de compilación.		
 Use la sintaxis de SQLCMD para incluir un archivo en el script posterior a la implementación.							
--------------------------------------------------------------------------------------
*/

IF  EXISTS (SELECT * from sys.tables WHERE Name = 'CVC_DESEMPENO_TABLERO')
     DROP TABLE [ATOMO].[CVC_DESEMPENO_TABLERO];
GO
