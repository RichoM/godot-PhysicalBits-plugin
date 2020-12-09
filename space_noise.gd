extends MeshInstance

export var speed = 1.0

onready var material = get_surface_material(0)

func _process(_delta):
	var position = global_transform.origin
	material.set("shader_param/uv1_offset", Vector3(position.x * speed, -position.y * speed, 0))
