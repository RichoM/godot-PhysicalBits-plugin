---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---

![godot_physicalbits]({{ site.baseurl }}/imgs/godot_physicalbits.svg)

El objetivo de este plugin es vincular al motor gráfico [Godot](https://godotengine.org/) con el entorno de programación para robótica educativa [Physical Bits](https://gira.github.io/PhysicalBits/).

[Godot](https://godotengine.org/) es un motor gráfico ideal para el desarrollo de videojuegos 2D y 3D. Soporta múltiples plataformas, es libre y de código abierto, y permite exportar los videojuegos creados a PC, teléfonos móviles, y HTML5.

[![godot_screenshot]({{ site.baseurl }}/imgs/godot_screenshot.jpg)](https://godotengine.org/)
> Godot permite la creación de mundos digitales en 2D y 3D.

<hr>
<br>

[Physical Bits](https://gira.github.io/PhysicalBits/), por otro lado, es un entorno de programación para robótica educativa diseñado especialmente para facilitar la programación de dispositivos físicos a usuarios no experimentados.

[![line_follower]({{ site.baseurl }}/imgs/line_follower.gif)](https://gira.github.io/PhysicalBits/)
> Physical Bits facilita la programación de robots y dispositivos físicos.

<hr>
<br>

Este plugin permite vincular ambas herramientas, haciendo posible el desarrollo de __experiencias audiovisuales que incluyan además algún tipo de interacción física__. Videojuegos innovadores, controles experimentales, arte digital interactivo, interfaces físicas, son potenciales ejemplos de aplicación para este plugin.

Asimismo, la interfaz de programación visual que provee Physical Bits es __ideal para artistas y diseñadores__ que deseen incursionar en el desarrollo de dispositivos físicos. La misma está diseñada como herramienta introductoria y, por lo tanto, no requiere amplios conocimientos de robótica ni de programación de microcontroladores. Physical Bits permite prototipar ideas y convertirlas en artefactos funcionales muy rápidamente. Esta facilidad, sumada al gran poder visual que ofrece Godot, abre las puertas al desarrollo de experiencias que integren tanto el mundo digital como el mundo físico.


# Ejemplo 1 - Paper Airplane
## Uso de sensores

Este ejemplo consiste de un videojuego muy sencillo controlado mediante sensores conectados a un [Arduino UNO](https://store.arduino.cc/usa/arduino-uno-rev3). Puede verse en funcionamiento en el siguiente video:

<iframe width="100%" height="416" src="https://www.youtube.com/embed/V3eIrDwEnkA" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
<br>
Como se puede observar en el video, el juego consiste en un avión de papel que navega por el espacio ganando puntos en función de cuánto tiempo pase evitando chocar con asteroides.

El comportamiento del avión es muy simple: está en permanente caída libre EXCEPTO cuando se activa alguno de los siguientes sensores:

1. Un botón conectado al pin digital 7.
2. Un LDR conectado al pin analógico 5.
3. Un sensor ultrasónico HC-SR04 conectados a los pines digitales 11 y 12.

Asimismo, se cuenta con un LED en el pin digital 8 que se enciende cuando alguno de los sensores se activa y un potenciómetro en el pin analógico 4 que sirve de umbral para la activación del LDR.

El circuito completo usado en este ejemplo se puede ver a continuación (diagrama construido con la herramienta [fritzing](https://fritzing.org/)):

[![paper_airplane_bb]({{ site.baseurl }}/imgs/paper_airplane_bb.svg)]({{ site.baseurl }}/paper_airplane.fzz)

El programa instalado en el Arduino UNO consiste de una sola tarea que se ejecuta 1000 veces por segundo. Esta tarea tiene el único objetivo de chequear los valores de los sensores antes mencionados y establecer la variable `action` en caso de que alguno esté activado. Esta variable `action` será luego utilizada en el script del avión (en godot) para controlar la navegación.

Como se puede ver a continuación, el programa ejecutándose en el Arduino UNO es muy fácil de entender gracias a la interfaz de programación por bloques:

[![paperairplane_blocks]({{ site.baseurl }}/imgs/paperairplane_blocks_es.svg)]({{ site.baseurl }}/imgs/paperairplane_blocks_es.svg)

El código del lado de godot es muy extenso como para incluirlo en este documento, pero a continuación se puede observar como la función encargada del control del avión utiliza el valor de la variable `action` como input:

[![paperairplane_godot]({{ site.baseurl }}/imgs/paperairplane_godot.png)]({{ site.baseurl }}/imgs/paperairplane_godot.png)

# Ejemplo 2 - Low Poly Racing
## Uso de actuadores

Este ejemplo consiste de otro videojuego sencillo pero en lugar de usar el [Arduino UNO](https://store.arduino.cc/usa/arduino-uno-rev3) como un control experimental vamos a usarlo para mostrar información al jugador de lo que sucede en el juego. Para mostrar esta información usaremos una serie de actuadores. Puede verse en el siguiente video:

<iframe width="100%" height="416" src="https://www.youtube.com/embed/_SzpKWqWwGU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
<br>

Como se observa en el video, se trata de un simple videojuego de carreras donde el objetivo es recorrer la pista en el menor tiempo posible.

El Arduino UNO cuenta con los siguientes componentes:

1. Una serie de LEDs conectados en los pines digitales 10, 11, y 12 que se prenden en secuencia, conformando así un semáforo.
2. Un buzzer conectado al pin digital 8 que emite un sonido luego de que se activen los LEDs del semáforo.
3. Dos servomotores conectados en los pines digitales 3 y 4 que levantan los cartelitos de giro.

El circuito completo usado en este ejemplo se puede ver a continuación (diagrama construido con la herramienta [fritzing](https://fritzing.org/)):

[![low_poly_racing_bb]({{ site.baseurl }}/imgs/low_poly_racing_bb.svg)]({{ site.baseurl }}/low_poly_racing.fzz)

El programa instalado en el Arduino UNO es un poco más complejo en este caso. Consta de dos tareas concurrentes y un procedimiento.

En primer lugar, la tarea `semaphore` se encarga de controlar la activación secuencial de los LEDs. Para ello, su ejecución se bloquea hasta que se active la variable global `play`. Esta variable es controlada desde el programa en godot y su valor pasa a `verdadero` cuando el jugador hace clic en el botón de "PLAY". A partir de ese momento se encienden los LEDs en secuencia con un segundo de espera entre cada LED. Cuando se terminan de encender todos los LEDs se ejecuta el procedimiento `go sound`, que es el encargado de reproducir el sonido que da inicio a la carrera. Finalmente, se apagan los tres LEDs y se desactiva la variable `play`, luego de lo cual la ejecución de la tarea vuelve al principio, a la espera de la próxima carrera.

En segundo lugar, la tarea `turn sign` se encarga de controlar los motores que levantan los carteles de giro. La primer acción que realiza, entonces, es mover los servomotores a su posición inicial. Para indicar la cercanía de una curva el programa en godot utiliza la variable `turn`, estableciendo su valor en 1 para indicar una giro a la derecha y -1 para indicar un giro a la izquierda. Por eso, luego de mover los motores a su posición inicial, la tarea entra en un bucle infinito y bloquea su ejecución a la espera de que la variable `turn` tome algún valor distinto de cero. Si eso sucede se fija si el valor es positivo o negativo, moviendo el servomotor correspondiente. Luego espera durante 1 segundo y medio antes de volver el motor a su posición inicial y establecer la variable `turn` nuevamente a cero.

A pesar de ser un poco más complicado que el ejemplo anterior, la interfaz de programación por bloques permite entender el código instalado en el Arduino UNO sin mayores problemas:

[![lowpolyracing_blocks]({{ site.baseurl }}/imgs/lowpolyracing_blocks_es.svg)]({{ site.baseurl }}/imgs/lowpolyracing_blocks_es.svg)

El código del lado del programa en godot es demasiado extenso como para incluirlo completo en este documento, pero se observa a continuación el extracto donde el juego interactúa con Physical Bits modificando las variables correspondientes:

[![lowpolyracing_godot]({{ site.baseurl }}/imgs/lowpolyracing_godot.png)]({{ site.baseurl }}/imgs/lowpolyracing_godot.png)
