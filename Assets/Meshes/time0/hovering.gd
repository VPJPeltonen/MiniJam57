extends Spatial

onready var chair: Spatial = $Chair

export(float) var speed = 0.1
export(float) var height = 0.1
export(float) var offset = 0.0
var t: float = 0.0

func _process(delta):
	chair.translation.y = sin(t * delta * speed + offset) * height
	t += 0.1
