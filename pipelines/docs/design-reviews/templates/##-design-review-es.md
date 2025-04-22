# [Título de la tarea](http://link-to-feature-or-story-work-item)

## Resumen

* Describe la característica/historia con un resumen de alto nivel.
* Considerar antecedentes y justificación adicionales, para la posteridad y el contexto histórico.
* Enumerar las suposiciones que se hicieron para este diseño.

## Objetivos/alcance

* Enumerar los objetivos que la característica/historia nos ayudará a lograr y que son más relevantes para la discusión de la revisión de diseño.
* Incluir los criterios de aceptación requeridos para cumplir con la definición de hecho.

## Fuera del alcance

* Enumerar los puntos que están fuera del alcance de la función/historia.
* Esto contiene trabajo que está más allá del alcance de lo que está destinado la función/componente/servicio.

## Diseño propuesto

* Describir brevemente la arquitectura de alto nivel de la función/historia.
* Los diagramas relevantes (por ejemplo, secuencia, componente, contexto, implementación) deben incluirse aquí.
* Imagenes deben ser agregadas en la carpeta `design-reviews/assets`.

Si prefieres crear diagramas utilizando texto y código en el documento en lugar de crearlos como imágenes, recomendamos el uso de [mermaid](https://mermaid-js.github.io/mermaid/#/). Ejemplo:

::: mermaid
sequenceDiagram
    participant Alice
    participant Bob
    Alice->>John: Hello John, how are you?
    loop Healthcheck
        John->>John: Fight against hypochondria
    end
    Note right of John: Rational thoughts <br/>prevail!
    John-->>Alice: Great!
    John->>Bob: How about you?
    Bob-->>John: Jolly good!
:::

## Tecnologías

* Describir el sistema operativo, el servidor web, la capa de presentación, la capa de persistencia, el almacenamiento en caché, los eventos/mensajería/trabajos relevantes, etc., lo que sea aplicable a la solución tecnológica general y cómo se utilizarán.
* Describir el uso de cualquier libreria open source..
* Enumere brevemente los idiomas y plataformas que componen la pila.

## Requisitos no funcionales

* ¿Cuáles son las principales preocupaciones de rendimiento y escalabilidad de esta función/historia?
* ¿Hay objetivos específicos de latencia, disponibilidad y RTO / RPO que deban cumplirse?
* ¿Existen cuellos de botella específicos o áreas potencialmente problemáticas? Por ejemplo, ¿las operaciones están vinculadas a la CPU o I/O (red, disco)?
* ¿Qué tan grandes son los conjuntos de datos y qué tan rápido crecen?
* ¿Cuál es el patrón de uso esperado del servicio? Por ejemplo, ¿habrá picos y valles de uso concurrente intenso?
* ¿Existen restricciones de costos específicas? (por ejemplo, costo  por transacción/dispositivo/usuario)

## Dependencias

* ¿Es necesario secuenciar esta característica/historia después de otra característica/historia asignada al mismo equipo y por qué?
* ¿La función / historia depende de que otro equipo complete otro trabajo?
* ¿El equipo deberá esperar a que se complete ese trabajo o podría el trabajo continuar en paralelo?

## Riesgos y Mitigación

* ¿El equipo necesita ayuda de expertos en la materia?
* ¿Qué preocupaciones de seguridad y privacidad tiene este hito / épico?
* ¿Toda la información sensible y los secretos se tratan de manera segura?

## Preguntas abiertas

* Enumere aquí cualquier pregunta o inquietud abierta.

## Referencias adicionales

* Enumere aquí cualquier referencia adicional, incluidos enlaces a elementos de la lista de trabajos pendientes, elementos de trabajo u otros documentos.
