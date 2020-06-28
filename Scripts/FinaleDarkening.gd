extends Node2D

var counter = 0
var counting = false

func _process(delta):
	if counting:
		counter += delta
		if counter > 1:
			$InfoBox2.color = Color(0,0,0,(counter-1)/10)
