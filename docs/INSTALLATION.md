# Instalación y uso

## Instalación

1. Descargar y ejecutar [Physical Bits](https://gira.github.io/PhysicalBits/download/) (versión 0.5.1 o superior).
2. Conectar Physical Bits a un [dispositivo](https://gira.github.io/PhysicalBits/getting_started/BOARDS.html) (habiendo previamente instalado el firmware como se explica [aquí](https://gira.github.io/PhysicalBits/getting_started/FIRMWARE.html)).
3. En su proyecto de [Godot](https://godotengine.org/) agregar un [Label](https://docs.godotengine.org/es/stable/classes/class_label.html) a la escena y asociarle el script [/src/PhysicalBits.gd](https://github.com/RichoM/godot-PhysicalBits-plugin/blob/main/src/PhysicalBits.gd).
4. Ejecutar la escena, si la conexión entre Godot y Physical Bits fue exitosa en el label deberían observarse los valores de las variables y los pines en uso en el programa.

![connection_successful]({{ site.baseurl }}/imgs/connection_successful.png)

## Uso

Desde el inspector se pueden configurar los parámetros de conexión del plugin (aunque normalmente no debería ser necesario).

![pbits_inspector]({{ site.baseurl }}/imgs/pbits_inspector.png)

Para acceder a los valores de los pines y variables del programa en el dispositivo:

```gdscript
# Obtener una referencia al plugin
var pbits = $PhysicalBits as PhysicalBits

# Leer un pin
var pin13 = pbits.get_data("D13")

# Leer un pin (valor por defecto: 0)
var pin12 = pbits.get_data("D12", 0)

# Escribir un pin
pbits.set_data("D13", 1)

# Leer una variable global
var foo = pbits.get_data("foo")

# Leer una variable global (valor por defecto: 42)
var bar = pbits.get_data("bar", 42)

# Escribir una variable global
pbits.set_data("bar", 24)
```
