---
sort: 2
---

# Uso de actuadores (Low Poly Racing)

## Descripción

Este ejemplo consiste de otro videojuego sencillo pero en lugar de usar el [Arduino UNO](https://store.arduino.cc/usa/arduino-uno-rev3) como un control experimental vamos a usarlo para mostrar información al jugador de lo que sucede en el juego. Para mostrar esta información usaremos una serie de actuadores.

El resultado puede verse en el siguiente video:

<iframe width="100%" height="515" src="https://www.youtube.com/embed/_SzpKWqWwGU" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
<br>

Como se observa en el video, se trata de un simple videojuego de carreras donde el objetivo es recorrer la pista en el menor tiempo posible.

## Componentes

El Arduino UNO cuenta con los siguientes componentes:

1. Una serie de LEDs conectados en los pines digitales 10, 11, y 12 que se prenden en secuencia, conformando así un semáforo.
2. Un buzzer conectado al pin digital 8 que emite un sonido luego de que se activen los LEDs del semáforo.
3. Dos servomotores conectados en los pines digitales 3 y 4 que levantan los cartelitos de giro.

El circuito completo usado en este ejemplo se puede ver a continuación (diagrama construido con la herramienta [fritzing](https://fritzing.org/)):

[![low_poly_racing_bb]({{ site.baseurl }}/imgs/low_poly_racing_bb.svg)]({{ site.baseurl }}/low_poly_racing.fzz)

## Código

El programa instalado en el Arduino UNO es un poco más complejo en este caso. Consta de dos tareas concurrentes y un procedimiento.

En primer lugar, la tarea `semaphore` se encarga de controlar la activación secuencial de los LEDs. Para ello, su ejecución se bloquea hasta que se active la variable global `play`. Esta variable es controlada desde el programa en godot y su valor pasa a `verdadero` cuando el jugador hace clic en el botón de "PLAY". A partir de ese momento se encienden los LEDs en secuencia con un segundo de espera entre cada LED. Cuando se terminan de encender todos los LEDs se ejecuta el procedimiento `go sound`, que es el encargado de reproducir el sonido que da inicio a la carrera. Finalmente, se apagan los tres LEDs y se desactiva la variable `play`, luego de lo cual la ejecución de la tarea vuelve al principio, a la espera de la próxima carrera.

En segundo lugar, la tarea `turn sign` se encarga de controlar los motores que levantan los carteles de giro. La primer acción que realiza, entonces, es mover los servomotores a su posición inicial. Para indicar la cercanía de una curva el programa en godot utiliza la variable `turn`, estableciendo su valor en 1 para indicar una giro a la derecha y -1 para indicar un giro a la izquierda. Por eso, luego de mover los motores a su posición inicial, la tarea entra en un bucle infinito y bloquea su ejecución a la espera de que la variable `turn` tome algún valor distinto de cero. En cuanto eso sucede se fija si el valor es positivo o negativo, para luego mover el servomotor correspondiente. Finalmente espera durante 1 segundo y medio antes de volver el motor a su posición inicial y establecer la variable `turn` nuevamente a cero.

A pesar de ser un poco más complicado que el ejemplo anterior, la interfaz de programación por bloques permite entender el código instalado en el Arduino UNO sin mayores problemas:

[![lowpolyracing_blocks]({{ site.baseurl }}/imgs/lowpolyracing_blocks_es.svg)]({{ site.baseurl }}/imgs/lowpolyracing_blocks_es.svg)

El código del lado del programa en godot es demasiado extenso como para incluirlo completo en este documento, pero se observa a continuación el extracto donde el juego interactúa con Physical Bits modificando las variables correspondientes (líneas 54, 60, y 63):

[![lowpolyracing_godot]({{ site.baseurl }}/imgs/lowpolyracing_godot.PNG)]({{ site.baseurl }}/imgs/lowpolyracing_godot.PNG)
