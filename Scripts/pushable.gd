extends StaticBody

export var info = "This item appaers to be pushable"
export var has_item = false
export var item_held = "none" 
export var move_location = Vector3(0,0,0)
var original_location
var second_location
var current_target
var moving = false
var outline_mesh
onready var sound: AudioStreamPlayer3D = $AudioStreamPlayer3D

func _ready():
	var path := "MeshInstance/Outline"
	var path2 := "Outline"
	if has_node(path):
		outline_mesh = get_node(path)
	elif has_node(path2):
		outline_mesh = get_node(path2)
	else:
		push_error("Could not find Outline Mesh for %s" % name)
	original_location = translation
	second_location = translation + move_location

func _process(delta):
	if moving:
		translation = translation.linear_interpolate(current_target, delta)
		if translation == current_target:
			moving = false


func show_activetable():
	outline_mesh.show()

func hide_activetable():
	outline_mesh.hide()

func player_activate(player):
	if sound:
		sound.play()
	if !moving:
		if current_target == second_location:
			current_target = original_location
		else:
			current_target = second_location
		moving = true
	else:
		moving = false
