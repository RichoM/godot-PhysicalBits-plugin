extends Area

const GRAVITY = -1
const MIN_SPEED = deg2rad(-75)
const MAX_SPEED = deg2rad(75)

var time = 0
var vel = 0.5

var colliding = false

func _ready():
	pass

func _process(delta):
	if Input.is_action_pressed("movement_up"):
		vel -= GRAVITY * 2 * delta
	else:
		vel += GRAVITY * delta
		
	vel = clamp(vel, MIN_SPEED, MAX_SPEED)
	
	var rot_z = (vel / (MAX_SPEED - MIN_SPEED) * 2)
	$rotation.rotation.z = rot_z * 1.25
	
	time += delta
	$rotation/mesh.rotation.x = sin(time * 5) * abs(vel) * 0.4

	
	translate_object_local(Vector3.UP * vel * delta + Vector3.RIGHT * 0.25 * delta)
	
	var m = $rotation/mesh.get_surface_material(0)
	if colliding:
		m.albedo_color = Color(1.0, 0.0, 0.0, 1.0)
	else:
		m.albedo_color = Color("ffdb37")

func _physics_process(delta):
	# TODO(Richo): Bounce off collision
	colliding = get_overlapping_bodies().size() > 0
