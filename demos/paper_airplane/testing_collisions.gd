extends Spatial

var bodies = []

func _process(delta):
	if bodies.size() > 0:
		$label.text = "TRUE!"
	else:
		$label.text = "FALSE!"


func _physics_process(_delta):
	bodies = $airplane/rotation/area.get_overlapping_bodies()

func _input(event):
	if event is InputEventMouseMotion:
		var pos = $camera.project_position(event.position, $camera.global_transform.origin.z)
		$airplane.global_transform.origin = pos
