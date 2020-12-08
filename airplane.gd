extends Area

const GRAVITY = -0.81

var time = 0
var vel = 0.5

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("movement_up"):
		vel -= GRAVITY * delta
	else:
		vel += GRAVITY * delta
		
	time += delta
	$rotation.rotation.z = clamp(vel * 2, deg2rad(-90), deg2rad(90))
	$rotation/mesh.rotation.x = sin(time * 2) / 5
	
	translate_object_local(Vector3.UP * vel * delta)

func _physics_process(delta):
	print(get_overlapping_bodies().size())
