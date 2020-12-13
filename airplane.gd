extends Spatial

const GRAVITY = -1
const MIN_SPEED = deg2rad(-75)
const MAX_SPEED = deg2rad(75)

var time = 0
var vel = Vector2(0.25, 0.5)

var colliding = false

func _process(delta):
	if colliding:
		gameover(delta)
	else:
		control(delta)
		
func gameover(delta):
	vel.y += GRAVITY * delta
	$rotation.rotation.z -= delta * 2
	$rotation/mesh.rotation.x += delta * 3
	translate_object_local(Vector3.RIGHT * vel.x * delta + Vector3.UP * vel.y * delta)
	
	if abs(vel.y) > MAX_SPEED:
		get_tree().reload_current_scene()

func control(delta):
	if Input.is_action_pressed("movement_up"):
		vel.y -= GRAVITY * 2.5 * delta
	else:
		vel.y += GRAVITY * delta
		
	vel.y = clamp(vel.y, MIN_SPEED, MAX_SPEED)
	vel.x += 0.01 * delta
	
	var rot_z = (vel.y / (MAX_SPEED - MIN_SPEED) * 2)
	$rotation.rotation.z = rot_z * 1.25
	
	time += delta
	$rotation/mesh.rotation.x = sin(time * 5) * abs(vel.y) * 0.4
	
	translate_object_local(Vector3.RIGHT * vel.x * delta + Vector3.UP * vel.y * delta)

func _physics_process(delta):
	if colliding: return
	var bodies = $rotation/area.get_overlapping_bodies()
	if bodies.size() > 0:
		colliding = true
		var signs = (global_transform.origin - bodies[0].global_transform.origin).sign()
		vel = Vector2(0.5 * signs.x, 0.5)
