extends Spatial

var move_location = Vector3(0,0,-3.1)
var target_rot = Vector3(0,120,0)
var second_location
var second_rot
var current_target
var opened = false
var moving = false

func _ready():
	second_location = translation + move_location
	second_rot =  rotation_degrees + target_rot

func _process(delta):
	if moving:
		translation = translation.linear_interpolate(second_location, delta)
		rotation = rotation_degrees.linear_interpolate(second_rot, delta)
		if translation == second_location and rotation_degrees == second_rot:
			opened = true
			moving = false

func start_moving():
	if !opened and moving:
		moving = true
