extends StaticBody

export var info = "This appears to be a cube"

func show_activetable():
	$MeshInstance/Outline.show()

func hide_activetable():
	$MeshInstance/Outline.hide()

func player_activate():
	pass
