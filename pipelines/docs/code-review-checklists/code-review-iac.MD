# [Code Review checklist para infraestructura como código](https://dev.azure.com/ecopetrolad/BI/_backlogs/backlog/DM_CadenaSuministro/Backlog%20items/?workitem=122211)

## Descripción general

* Este documento lista una serie de elementos a considerar al momento de aplicar la revisión de contribuciones al repositorio de infraestructura como código.

## Objetivos/alcance

* Realizar revisiones de código efectivas para validar el software y comprobar su calidad.

## Checklist
Revisión para Infraestrctura como código, si cree que la respuesta no es satisfactoria a alguna de las preguntas siguientes, puede sugerir/recomendar cambios en el código.

1. [ ] ¿Puedo **entender** el código fácilmente?
2. [ ] ¿El código está escrito siguiendo los estándares/pautas de codificación?
3. [ ] ¿El código está bien documentado?
4. [ ] ¿La alineación, margenes y espacios en blanco se utilzan de forma adecuada?
5. [ ] ¿Se han resguardado contraseñas, palabras clave o datos sensibles?
6. [ ] ¿Se utiliza `lowerCamelCase` (mezcla de mayúsculas y minúsculas), para los nombres de variables y parámetros?
7. [ ] ¿Proporciona descripción de cada parametro en etiqueta `metadata`?
8. [ ] ¿Se utiliza `"type": "securestring"` para contraseñas y palabras claves en los parametros?
9. [ ] ¿Existen units test que cubran internamente las pruebas del código recién añadido y que pasen en el sistema CI/CD que utiliza el proyecto?
10. [ ] ¿Los nombres de objetos, variables y parámetros son significativos y reflejan su intención?
11. [ ] ¿Los nombres de objetos, variables y parámetros son neutrales con respecto a entornos y dominios?
12. [ ] ¿Los cambios en el nivel de los _templates_ entrarán en conflicto con el repositorio de _templates_ `upstream`? 

## Referencias adicionales

* [ARM - Template best practices](https://docs.microsoft.com/es-es/azure/azure-resource-manager/templates/template-best-practices)
* [Effective code Reviews](https://www.evoketechnologies.com/blog/code-review-checklist-perform-effective-code-reviews/)
* [Camel Case](https://es.wikipedia.org/wiki/Camel_case)