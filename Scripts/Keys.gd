extends Spatial

export var info = "This appears to be a cube"
export var has_item = false
export var item_held = "none" 

var outline_mesh: MeshInstance

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

func show_activetable():
	outline_mesh.show()

func hide_activetable():
	outline_mesh.hide()

func player_activate(player):
	if player.inventory.has("safe code"):
		get_parent().get_parent().open_door()
		player.items_in_range.remove(0)
