---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---

![godot_physicalbits](imgs/godot_physicalbits.svg)

El objetivo de este plugin es vincular al motor gráfico [Godot](https://godotengine.org/) con el entorno de programación para robótica educativa [Physical Bits](https://gira.github.io/PhysicalBits/).

[Godot](https://godotengine.org/) es un motor gráfico ideal para el desarrollo de videojuegos 2D y 3D. Soporta múltiples plataformas, es libre y de código abierto, y permite exportar los videojuegos creados a PC, teléfonos móviles, y HTML5.

[![godot_screenshot](imgs/godot_screenshot.jpg)](https://godotengine.org/)
> Godot permite la creación de mundos digitales en 2D y 3D.

<hr>
<br>

[Physical Bits](https://gira.github.io/PhysicalBits/), por otro lado, es un entorno de programación para robótica educativa diseñado especialmente para facilitar la programación de dispositivos físicos a usuarios no experimentados.

[![line_follower](./imgs/line_follower.gif)](https://gira.github.io/PhysicalBits/)
> Physical Bits facilita la programación de robots y dispositivos físicos.

<hr>
<br>

Este plugin permite vincular ambas herramientas, haciendo posible el desarrollo de __experiencias audiovisuales que incluyan además algún tipo de interacción física__. Videojuegos innovadores, controles experimentales, arte digital interactivo, interfaces físicas, son potenciales ejemplos de aplicación para este plugin.

Asimismo, la interfaz de programación visual que provee Physical Bits es __ideal para artistas y diseñadores__ que deseen incursionar en el desarrollo de dispositivos físicos. La misma está diseñada como herramienta introductoria y, por lo tanto, no requiere amplios conocimientos de robótica ni de programación de microcontroladores. Physical Bits permite prototipar ideas y convertirlas en artefactos funcionales muy rápidamente. Esta facilidad, sumada al gran poder visual que ofrece Godot, abre las puertas al desarrollo de experiencias que integren tanto el mundo digital como el mundo físico.


# Ejemplo
## Paper Airplane

Este ejemplo consiste de un videojuego muy sencillo controlado mediante sensores conectados a un [Arduino UNO](ACAACA). Puede verse en funcionamiento en el siguiente video:

<p align="center">  
  <a href="https://youtu.be/V3eIrDwEnkA">
    <img src="./imgs/paperairplane_youtube.png">  
  </a>
</p>

Como se puede observar en el video, el juego consiste en un avión de papel que navega por el espacio ganando puntos en función de cuánto tiempo pase evitando chocar con asteroides.

El comportamiento del avión es muy simple: está en permanente caída libre EXCEPTO cuando se activa alguno de los siguientes sensores:

1. Un botón conectado al pin digital 7.
2. Un LDR conectado al pin analógico 5.
3. Un sensor ultrasónico HC-SR04 conectados a los pines digitales 11 y 12.

Asimismo, se cuenta con un LED en el pin digital 8 que se enciende cuando alguno de los sensores se activa y un potenciómetro en el pin analógico 4 que sirve de umbral para la activación del LDR.

El circuito completo usado en este ejemplo se puede ver a continuación (diagrama construido mediante la herramienta [fritzing](https://fritzing.org/)):

[![img](./imgs/paper_airplane_bb.svg)](https://fritzing.org/)

El programa instalado en el Arduino UNO consiste de una sola tarea que se ejecuta 1000 veces por segundo. Esta tarea tiene el único objetivo de chequear los valores de los sensores antes mencionados y establecer la variable `action` en caso de que alguno esté activado. Esta variable `action` será luego utilizada en el script del avión (en godot) para controlar la navegación.

Como se puede ver a continuación, el programa ejecutándose en el Arduino UNO es muy fácil de entender:

![paperairplane_blocks](./imgs/paperairplane_blocks_es.svg)
