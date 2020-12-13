extends Spatial

export var root : NodePath
export var camera : NodePath
export var max_asteroids = 5

var asteroids = [preload("res://asteroid_0.tscn")]
var counter = 0


func _ready():
	var timer = $timer
	timer.connect("timeout", self, "spawn_new_asteroid")
	timer.start()

func spawn_new_asteroid():
	if counter < max_asteroids:
		var index = posmod(counter, asteroids.size())
		var asteroid = asteroids[index].instance() as Asteroid
		asteroid.camera = get_node(camera).get_path()
		get_node(root).add_child(asteroid)
		asteroid.global_transform.origin = global_transform.origin
		counter += 1
