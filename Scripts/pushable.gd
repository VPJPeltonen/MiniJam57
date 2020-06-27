extends StaticBody

export var info = "This item appaers to be pushable"
export var move_location = Vector3(0,0,0)
var original_location
var second_location
var current_target
var moving = false

func _ready():
	original_location = translation
	second_location = translation + move_location

func _process(delta):
	if moving:
		translation = translation.linear_interpolate(current_target, delta)
		if translation == current_target:
			moving = false


func show_activetable():
	$MeshInstance/Outline.show()

func hide_activetable():
	$MeshInstance/Outline.hide()

func player_activate():
	if !moving:
		if current_target == second_location:
			current_target = original_location
		else:
			current_target = second_location
		moving = true
	else:
		moving = false
