extends KinematicBody

export var speed = 1.0

func _physics_process(delta):
	move_and_slide(Vector3.LEFT * delta  * speed)
