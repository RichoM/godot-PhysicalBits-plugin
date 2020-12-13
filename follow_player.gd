extends Camera

export var player : NodePath

onready var _player = get_node(player)
var offset = Vector2()

func _ready():
	offset.x = _player.global_transform.origin.x - global_transform.origin.x
	offset.y = _player.global_transform.origin.y - global_transform.origin.y

func _process(_delta):
	global_transform.origin.x = _player.global_transform.origin.x - offset.x
	global_transform.origin.y = _player.global_transform.origin.y - offset.y
