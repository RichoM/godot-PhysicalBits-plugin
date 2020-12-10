extends Spatial

onready var cam = $Camera
onready var asteroid = $asteroid_1

func _input(event):
	if event is InputEventMouseButton:
		var pos = event.position
		var global_pos = cam.project_position(pos, cam.global_transform.origin.z)
		
		print("GLOBAL_POS: " + str(global_pos))
		
		if event.button_index == 1:
			var aabb = asteroid.get_transformed_aabb()
			print(asteroid.global_transform.origin)
			print(asteroid.translation)
			print(aabb.position)
			print(aabb.size)
			
			print(aabb.has_point(global_pos))
		elif event.button_index == 2:
			asteroid.global_transform.origin = global_pos
