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

[![paperairplane_godot]({{ site.baseurl }}/imgs/paperairplane_godot.PNG)]({{ site.baseurl }}/imgs/paperairplane_godot.PNG)
