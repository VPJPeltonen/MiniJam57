extends StaticBody

var invisible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func player_activate():
	if invisible:
		$MeshInstance.show()
		invisible = false
	else:
		$MeshInstance.hide()
		invisible = true
