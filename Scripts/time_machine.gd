extends Spatial

export var info = "This is the terminal of my time machine. I can use it to jump to different times."
export var has_item = false
export var item_held = "none"

export(Array, PackedScene) var packed_time_scenes

var outline_mesh: MeshInstance
onready var ui: Panel = $CanvasLayer/TimeMachineUI
onready var sound: AudioStreamPlayer = $AudioStreamPlayer

var time_buttons: Array

func _ready():
	var path := "MeshInstance/Outline"
	var path2 := "Outline"
	if has_node(path):
		outline_mesh = get_node(path)
	elif has_node(path2):
		outline_mesh = get_node(path2)
	else:
		push_error("Could not find Outline Mesh for %s" % name)
	outline_mesh.hide()
	
	# Setup time machine GUI
	time_buttons = get_node("CanvasLayer/TimeMachineUI/CenterContainer/VBoxContainer").get_children()
	var i: = 0
	for node in time_buttons:
		var button: Button = node
		button.connect("pressed", self, "travel_time", [i])
		enable_time(i, false)
		i += 1
	enable_time(0, true)
	ui.hide()

	
	# Get time scenes

	switch_time(0)

func show_activetable():
	outline_mesh.show()

func hide_activetable():
	outline_mesh.hide()

func enable_time(i: int, enable: bool = true):
	time_buttons[i].disabled = !enable

func player_activate(player: FPS_Controller):
	if player.inventory.count("old input device"):
		enable_time(1)
	if player.inventory.count("mysterious object"):
		enable_time(2)
	if player.inventory.count("ancient object"):
		enable_time(3)
	MouseCapture.free_mouse(false)
	ui.show()

func travel_time(time: int):
	switch_time(time)
	sound.play()
	ui.hide()
	MouseCapture.capture_mouse()
	
func switch_time(time: int):
	# Delete all old times
	var times_node: Spatial = get_tree().get_nodes_in_group("times")[0]
	var time_scenes = times_node.get_children()	
	for node in time_scenes:
		var scene: Spatial = node
		scene.queue_free()
	
	var new_scene = packed_time_scenes[time].instance()
	times_node.add_child(new_scene)

func _on_Exit_pressed():
	ui.hide()
	MouseCapture.capture_mouse()
