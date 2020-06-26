extends StaticBody

var invisible = false
var info = "This appears to be a sphere"

func show_activetable():
	$MeshInstance/Outline.show()

func hide_activetable():
	$MeshInstance/Outline.hide()

func player_activate():
	if invisible:
		$MeshInstance.show()
		invisible = false
	else:
		$MeshInstance.hide()
		invisible = true
