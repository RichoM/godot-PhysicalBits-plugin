extends MeshInstance

export var speed = Vector3(1, 1, 1)
export var change_speed = 1

var time = 0
var next = change_speed

func _ready():
	var m = self.get_surface_material(0)
	var t_disp = m.get_shader_param("text_disp")
	t_disp.noise.seed = 0
	print(m)
	print(t_disp)

func _process(delta):
	time += delta
	if time >= next:
		print(time)
		var m = self.get_surface_material(0)
		var t_disp = m.get_shader_param("text_disp")
		t_disp.noise.seed += 1
		
		next = time + change_speed
		
	#rotate_object_local(Vector3.RIGHT, speed.x * delta)
	
	#rotate_object_local(Vector3.UP, speed.y * delta)
	rotate(Vector3.FORWARD, speed.z * delta)
