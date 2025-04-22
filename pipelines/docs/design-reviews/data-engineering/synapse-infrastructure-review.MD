## Definición de Infraestructura

Según los lineamientos de Ecopetrol, los recursos del tipo Azure Synapse son recursos transversales, lo cual implica que el mismo es compartido por varios dominios. Sin embargo, esta guía de diseño no hará ninguna restricción sobre esta elección siendo totalmente compatible para los casos donde los recursos son transversales tanto como si los recursos fueran exclusivos para cada uno de los dominios. Esto demuestra también la flexibilidad del diseño propuesto. Teniendo en cuenta esto, las opciones disponibles son:

### Infraestructura transversal

En el caso de una infraestructura transversal, todos los dominios comparten un área de trabajo de Azure Synapse donde existe un SQL Pool que es compartido por todos los dominios. El tamaño de este pool (en terminos de poder de computo) deberá ser tal de poder manejar la carga conjunta de todos los dominios. La forma de asegurar la separación (hasta determinado grado) entre diferentes dominios es al instrumentar diferentes esquemas para cada dominio. De esta forma el dominio `Supply Chain` podría disponer del esquema `[supplychain]` mientras que `Retail` del esquema `[retail]`.

### Infraestructura por dominio

En el caso de una infraestructura por dominio, cada dominio puede disponer de su propia base de datos y SQL Pool, el cual le asegurará capacidad dedicada. El workspace de Synapse Analytics en este caso puede ser nuevamente compartido a traves de todos los dominios o dedicado para alguno de los mismos. La naturaleza del proyecto le indicará cual es el esquema más conveniente.
