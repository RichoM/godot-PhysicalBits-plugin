extends MeshInstance

export var speed = 1.0

onready var material = get_surface_material(0)
var initial_pos := Vector3()

func _ready():
	initial_pos  = global_transform.origin + Vector3(randf() * 100, randf() * 100, 0)
	visible = randf() > 0.05

func _process(_delta):
	var position = initial_pos + global_transform.origin
	material.set("shader_param/uv1_offset", Vector3(position.x * speed, -position.y * speed, 0))
