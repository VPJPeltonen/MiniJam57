extends Spatial

export var move_location = Vector3(0,0,0)
var original_location
var second_location
var current_target
var moving = false

# Called when the node enters the scene tree for the first time.
func _ready():
	original_location = translation
	second_location = translation + move_location
	current_target = second_location
	
func _process(delta):
	if moving:
		translation = translation.linear_interpolate(current_target, delta*0.2)
		if translation == current_target:
			moving = false

func _on_Area_start_finale():
	moving = true
