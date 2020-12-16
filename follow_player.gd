extends Camera

export var player : NodePath

onready var _player = get_node(player)

var offset := Vector2()
var bullet_time := false

func _ready():
	offset.x = _player.global_transform.origin.x - global_transform.origin.x
	offset.y = _player.global_transform.origin.y - global_transform.origin.y

func _process(delta):
	global_transform.origin.x = _player.global_transform.origin.x - offset.x
	global_transform.origin.y = _player.global_transform.origin.y - offset.y
	
	if bullet_time:
		size -= delta * 0.5
	else:
		size += delta * 0.75
	size = clamp(size, 0.85, 1)


func _on_airplane_bullet_time_begin():
	bullet_time = true

func _on_airplane_bullet_time_end():
	bullet_time = false
