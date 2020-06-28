extends Area

signal start_finale

func _on_Area_body_entered(body):
	if body.has_method("freeze"):
		body.freeze()
		emit_signal("start_finale")
