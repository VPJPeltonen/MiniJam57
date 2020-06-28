extends Spatial

func open_door():
	$door1.hide()
	$door2.show()
	$theObject.show()
	$theObject.available = true
